module DFA2D

using PyPlot
include("calculs.jl")

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

export DFA

end
