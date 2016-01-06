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

%% Gene matching.
%
% * Use the gunzip command to extract the data file gene.txt contained in 
%   the archive gene.txt.gz.
%
% * Invoke the (sequential) genematch function using the following syntax:
%   >> [bestPercentMatch, matchStartIndex] = genematch('gattaca', 'gene.txt');
%
% * Open the file pargenematch in the MATLAB Editor. The next steps are 
%   described in the TODO comments contained in this file. Run the function
%   pargenematch to offload the gene matching computation as a parallel
%   job.

%% Parallel image filtering.
%
% * Open the file parallelImageReadStart.m in the MATLAB Editor and examine
%   its contents. The code reads in a noisy image and applies the median 
%   filtering algorithm to remove the noise.
% * Modify the code to read the image data in parallel, following the TODO
%   steps within the function. Test the parallel algorithm using the
%   "MarsNoisy.tif" image as the input.

%% Exploratory data analysis.
%
% * Load quakes14.mat. This file contains a table of earthquake data for 14
%   countries through the 20th century. The data includes the date and time
%   of the quake, its magnitude, location, and impact (in terms of life and
%   cost).
% * Make a histogram of earthquake magnitudes. Calculate the skewness and 
%   kurtosis, and compare them to the skewness and kurtosis of a normal 
%   distribution (0 and 3, respectively).
% * Repeat step 2 with just Japanese earthquakes.
% * Use grpstats to calculate the mean magnitude for each country.
% * Sort the countries by mean magnitude. Hint: Use the categories function
%   to get the country names.
% * Make a boxplot of magnitudes grouped by country. Does this agree with 
%   your findings above?
% * Make a scatter plot of the logarithm of the number of deaths and the 
%   logarithm of the damage cost. (These variables have a highly 
%   exponential distribution; taking the logarithm makes visualization of 
%   their relationship clearer.) Calculate the correlation coefficient.

%% Probability distributions.
%
% * Load quakes14.mat. This file contains a table of earthquake data for 14
%   countries through the 20th century. The data includes the date and time
%   of the quake, its magnitude, location, and impact (in terms of life and
%   cost).
% * Make a histogram of earthquake magnitudes. It can be difficult to 
%   determine if data is normally distributed from a histogram alone.  
%   Make a normal probability plot and use an appropriate test to determine
%   whether magnitudes are normally distributed.
% * Repeat step 2 with just Japanese earthquakes, and again with just 
%   Turkish earthquakes.
% * Fit normal distributions to the Japanese and Turkish earthquake 
%   magnitudes.
% * Compare the two distributions by plotting their pdfs on the same set 
%   of axes.

%% Curve-fitting and regression.
% * Load WCgoals.mat. This file contains a record of the number of goals 
%   and number of matches played in each FIFA World Cup™.
% * Make a plot of the average number of goals per match, as a function of 
%   year.
% * Calculate two best-fit trendlines: one for the entire data set, and the
%   other for just the World Cups from 1962 onward. Overlay both lines on 
%   the plot.
% * Make normal probability plots of the residuals from both fits. Are the
%   residuals normally distributed?

%% Signal processing and FFTs.
% Exponential moving averages are commonly used in applications. 
% These moving averages assign more weight to recent observations, and less
% weight to historically older observations. In this exercise, you will 
% compute the exponential moving average for a time series using different
% techniques. An exponential moving average is computed as follows:
% y_1 = x_1, y_n = ?*x_n + (1-?)*y_{n-1},
% where ? is an application-specific scalar parameter chosen in the 
% range [0, 1]. 
%
% * Load the data from the file electricity.mat. Plot the series price 
%   against dates.
% * Create scalar variables n = 13 and alpha = 2/(n+1).
% * Use the NaN function to preallocate a variable y_expma with the same 
%   size as price. Use a for-loop to implement the exponential moving 
%   average as defined above. Add y_expma to your plot from step 1.
% * Rearrange the equation above into standard form, and create vector 
%   variables a and b representing the filter coefficients. 
%   Does this filter have a finite or infinite impulse response? 
%   Hint: >> doc filter. Standard filter form is:
%   a_1*y_n + a_2*y_{n-1} + a_3*y_{n-2} + ... = 
%   b_1*x_n + b_2*x_{n-1} + b_3*x_{n-2} + ...
% * Use the filter function and step 4 to apply an exponential moving 
%   average to the retailPrice series. Add the result to your plot.
% * Repeat step 5 using the filtfilt function. 
% * Use impz to plot the impulse response of this filter, taking 50 
%   samples. Does this agree with your conclusion from step 4? 
%   (Note: filtfilt and impz require Signal Processing Toolbox.)