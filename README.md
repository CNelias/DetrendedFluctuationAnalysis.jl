Detrended Fluctuation Analysis (DFA)
=============================================

A module to perform detrended fluctuation analysis, which also gives the possibility to analyse the correlations between two time series 
(sometimes called the DCCA or DFA2D method). 
The DFA allows one to study correlations in data, without disturbance of seasonality or trend.

The implementation is based, among others, on this article:
*Podobnik B Stanley H . Detrended cross-correlation analysis: A new method for analyzing two nonstationary time series (2008)*         DOI : 10.1103/PhysRevLett.100.084102

### Perform a 2D DFA computation :

Call the DFA function DFA(data1,data1,box_b::Int,box_s::Int,nb_pt::Int)

the arguments have the following meaning :
* data1, data2 : the first  and second time series of data to analyse
* box_b, box_s : the starting and ending point of the analysis. It's recommended for box_s not to be to big in comparison to 
the total length of the time-series, otherwise you'll get artefacts. Stopping at a box_s roughly equal to 1/4 of the total length 
is a good idea.
* nb_pt : the number of points you want to perform the analysis onto. 

It returns :
* the list of points where the analysis was performed
* the value of the fluctuation coefficient at each of these points

### Perform a traditional DFA computation :

Simply feed the DFA function with the same time serie twice (in other words data1 and data2 needs to be provided with the same time serie)
the rest is identical to a 2D DFA computation !

### Example of DFA (1D) :

Calling the DFA function with white noise,

```julia
julia> a = rand(1000)
x,y = DFA(a,a,20,200,30)
```
will give the following plot :

```julia
using PyPlot

plot(x,y,"bo-",markersize = 4);      
title("DFA analysis of white noise")
legend()
xscale("log")
yscale("log")
xlabel("Log(s)")
ylabel("Log(F(n))")

# the following lines are here to perform the linear fit of the results
# in order to get the exponent alpha
a = linreg(log.(x),log.(y))[2]
b = linreg(log.(x),log.(y))[1] 
plot(x,exp(b)*x.^a, color = "black",linestyle = ":", label = string(L"fit. exponant $\alpha$ = ", a))
```

![index](https://user-images.githubusercontent.com/34754896/42929947-e085364e-8b3b-11e8-80d9-98e863ad9744.png)



Requirements
------------

* Polynomials
