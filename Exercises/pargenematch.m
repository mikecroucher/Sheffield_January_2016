function results = pargenematch()

% Define sequence to find and number of tasks to create.
searchSeq = repmat('gattaca', 1, 10);
numTasks = 2;
numBases = 7048095;

% TODO: Create a cluster object.

% TODO: Create a job on the cluster.

% TODO: Call the splitDataset function to obtain the start and end values.

% Add border handling.
offsetLeft = floor(length(searchSeq)/2);
if mod(length(searchSeq),2) == 0
    offsetRight = offsetLeft - 1;
else
    offsetRight = offsetLeft;
end
    
startValues(2:end) = startValues(2:end) - offsetLeft;
endValues(1:end-1) = endValues(1:end-1) + offsetRight;

% TODO: Create the tasks, using the genematch function with different 
% starting and end indices. You need to make use of the startValues and
% endValues variables created above.
for tasknum = 1:numTasks
    
end

% TODO: Submit the job and wait for the results.

% TODO: Retrieve the results and tidy up.

% Process the results.
results = cell2mat(results);
[~, idx] = max(results(:,1));
bpm = results(idx,1);
msi = results(idx,2)+startValues(idx)-1;


function [startValues, endValues] = splitDataset(numTotalElements, numTasks)

% Divide up the total elements among the tasks
numPerTask = repmat(floor(numTotalElements/numTasks), 1, numTasks);
leftover = rem(numTotalElements, numTasks);
numPerTask(1:leftover) = numPerTask(1:leftover) + 1;

% Determine the start end end values for the vector
endValues = cumsum(numPerTask);
startValues = [1 endValues(1:end-1) + 1];
