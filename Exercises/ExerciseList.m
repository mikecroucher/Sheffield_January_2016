%% Exercise list.
%
% Copyright MathWorks Inc, 2016.

%% Population dynamics.
%
% The number of individuals in a population at a given time step can be 
% modelled by the following equation:
% x_{n+1} = x_n + R*x_n*(C-x_n)/C,
% where R represents the reproduction rate of the population, and C 
% represents the carrying capacity of the environment (the number of 
% individuals an environment can support).
% 
% * Run the following code in MATLAB to see how the population changes as 
%   the reproduction rate varies.
%
% initPop = 5000;
% Rminmax = [1.5, 3.0];
% Rstep = 1e-5;
% numsteps = 1200;
% capacity = 10000;
% cycles = popdynamics(initPop, Rminmax, Rstep, numsteps, capacity);
%
% figure
% Rvec = Rminmax(1):Rstep:Rminmax(2);
% plot(Rvec, cycles)
%
% * Modify the popdynamics.m code to run on multiple instances of MATLAB.  
% * Run the modified version and plot the results. Verify that the results 
%   match those obtained using a single instance of MATLAB.
% * Use the tic/toc functions (or otherwise) to compute the speedup
%   obtained by using parallel processing on this problem.

%% Monte Carlo GDP price simulation.
% One way of simulating a financial asset is to transform the observable 
% price series so that it is possible to identify the underlying random 
% process. After that, the next step is to generate random sequences from 
% that process and transform them back to price series. These price 
% curves can then be analyzed in various ways. In this exercise, the goal 
% is to improve the performance of the sequential code.
%
% * Inspect the original version of the code, randsim.m, and run it using 
%   2000 simulations. 
% * Rerun the code in the MATLAB Profiler to see the bottlenecks.
% * Save the original file randsim.m as "randsimVec.m" so that you can
%   modify the code without altering the original version.
% * Adjust the code in the simulations subfunction for performance by 
%   generating a vector of random numbers instead of one random number at 
%   a time, thereby removing the inner for-loop.
% * Run the modified version of the code and compare the timings.
%   Ensure that the results are comparable to those obtained running the 
%   original code.















