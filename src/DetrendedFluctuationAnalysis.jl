module DetrendedFluctuationAnalysis

export DFA

include("calculs.jl")

function DFA(data1,data2,box_b::Int,box_s::Int,nb_pt::Int,step::Int)
    x = log_space(box_b,box_s,nb_pt)
    y = fluctuation_function(data1,data2,box_b,box_s,nb_pt,step)
    return x,y
end
end
