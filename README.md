Detrended Cross-Correlation Analysis (DFA 2D)
=============================================

A module to perform DCCA analysis, sometimes also called DFA 2D because it works 
excactly like DFA but extended for potentially 2 time series.

The implementation is based, among others, on the following articles:

* Podobnik B Stanley H . Detrended cross-correlation analysis: A new method for analyzing two nonstationary time series (2008)
  DOI : 10.1103/PhysRevLett.100.084102
* Zebende G, Da Silva, M MacHado Filho A. DCCA cross-correlation coefficient differentiation: Theoretical and practical approaches (2012).
  DOI : 10.1016/j.physa.2013.01.011
  
Requirements
------------

* Polynomials
* PyPlo

#### Perform a 2D DFA computation :

To perform a 2D DFA computation, call the DFA function providing the following arguments: 

* data1, data2 : the first  and second time series of data to analyse
* box_b, box_s : the starting and ending point of the analysis. It's recommended for box_s not to be to big in comparison to 
the total length of the time-series, otherwise you'll get artefacts. Stopping at a box_s roughly equal to 1/4 of the total length 
is a good idea.
* nb_pt : the number of points you want to perform the analysis onto. 
* plot : A boolean parameter. If given true, the function will plot the results of the 2D DFA analysis.

example :
'''julia
x1 = rand(1000)
x2 = rand(1000)
DFA(x1,x2,20,200,30,true)
'''
will give the following plot :


### Perform a traditional DFA computation :

Simply feed the DFA function with the same time serie twice (in other words data1 and data2 needs to be provided with the same time serie)
the rest is identical to a 2D DFA computation !
