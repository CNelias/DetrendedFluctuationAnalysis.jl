export fluctuation_function, DFA, log_space
using Polynomials
using PyPlot

function log_space(start::Int,stop::Int,num::Int)
    tmp = map(x -> round(Int,x), logspace(log10(start),log10(stop),num))
    spacing = Int64[]
    push!(spacing,tmp[1])
    deleteat!(tmp,1)
    for i in tmp
        if i != spacing[end]
            append!(spacing,i)
        elseif i == spacing[end]
            append!(spacing,i+1)
        end
    end
    return spacing
end
    
function partitioning(x,box_size) 
    data = copy(x)
    partitionned_data = Vector{Vector{Float64}}()
    @inbounds for i in 1:(length(x)-(box_size-1))
        tmp = Vector{Float64}()
        @inbounds for j in 0:(box_size-1)
            append!(tmp,data[i+j])
        end
        push!(partitionned_data,tmp)
    end
    return hcat(partitionned_data...)'
end

function detrending(values; reg_type = "linear", order = 1)
    position = collect(1:length(values))
    if reg_type == "polynomial"
    fit = polyfit(position,values,order)
    return values -  polyval(fit,position)
    elseif reg_type == "linear"
    curve = linreg(position,values)
    return values - (position*curve[2] + curve[1])
    end
end

function integrate(x)
    return cumsum(x)
end

function fluctuation_function(x,y, box_start::Int, box_stop::Int, nb_pts::Int; fit_type = "polynomial")
    if mod(box_start,10) !=0 || mod(box_stop,10) !=0
        print("ERROR : sizes of windows must be multiple of 10")     
    end
    ff = Float64[]
    ffi = Float64[]
    @inbounds for i in log_space(box_start,box_stop,nb_pts)
        ffi = 0
        xi = partitioning(integrate(x),i)
        yi = partitioning(integrate(y),i)
        n = length(@view xi[:,1])
        @inbounds for j in 1:n
            ffi += ((1/i)*detrending(xi[j,:]; reg_type = fit_type)'detrending(yi[j,:]; reg_type = fit_type))
        end
        append!(ff,1/n*sqrt(abs(ffi)))
    end
    return ff
end

function DFA(data1,data2,box_b::Int,box_s::Int,nb_pt::Int,plot::Bool)
    x =  log_space(box_b,box_s,nb_pt)
    y = fluctuation_function(data1,data2,box_b,box_s,nb_pt; fit_type = "polynomial")
    if plot == false 
      return y
    elseif plot == true
      plot(x,y,"bo-",markersize = 4, label = "DFA of data"); 
      a = linreg(log.(x),log.(y))[2]
      b = linreg(log.(x),log.(y))[1]      
      title("DFA_2D analysis")
      legend()
      xscale("log")
      yscale("log")
      xlabel("Log(s)")
      ylabel("Log(F(n))")
      plot(x,exp(b)*x.^a, color = "black",linestyle = ":", label = string(L"fit. exponant $\alpha$ = ", a))
    end
end
