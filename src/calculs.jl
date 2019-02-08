export fluctuation_function, log_space
using Polynomials

function log_space(start::Int,stop::Int,num::Int)
    tmp = map(x -> round(Int,x), exp10.(range(log10(start), stop=log10(stop), length=num)))
    spacing = Int[]
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


function partitioning(x,window,step)
    return [x[i:i+window-1] for i in 1:step:length(x) if  i + window <= length(x)]
end

function partitionin(x,box_size)
    partitionned_data = Float64[]
    len = length(x)-(box_size-1)
    for i in 1:len
        for j in 0:(box_size-1)
            append!(partitionned_data,x[i+j])
        end
    end
    return reshape(partitionned_data,(box_size,len))'
end

function detrending(values; order = 1)
    position = collect(1:length(values))
    fit = polyfit(position,values,order)
    return values - polyval(fit,position)
end

function fluctuation_function(x,y, box_start::Int, box_stop::Int, nb_pts::Int, step::Int)
    if mod(box_start,10) !=0 || mod(box_stop,10) !=0
        print("ERROR : sizes of windows must be multiple of 10")
    end
    ff = Float64[]
    #ffi = Float64[]
    for i in log_space(box_start,box_stop,nb_pts)
        ffi = 0
        xi = partitioning(cumsum(x),i,step)
        yi = partitioning(cumsum(y),i,step)
        n = length(xi)
        for j in 1:n
            ffi += 1/i*(detrending(xi[j])'*detrending(yi[j]))
        end
        append!(ff,sqrt(abs(ffi)))
    end
    return ff
end
