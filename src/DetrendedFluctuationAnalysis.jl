module DetrendedFluctuationAnalysis

include("calculs.jl")

function DFA(data1,data2,box_b::Int,box_s::Int,nb_pt::Int,plot::Bool)
    x =  log_space(box_b,box_s,nb_pt)
    y = fluctuation_function(data1,data2,box_b,box_s,nb_pt; fit_type = "polynomial")
    return x,y
end

export DFA

end
