%% Machine learning.

%% Clustering (unsupervised learning).
% Voting record data.
%
% * Load voting.mat. This file contains a matrix representing the 
%   congressional voting record of 435 U.S. representatives on 16 key 
%   issues, and a categorical array with their political party affiliation
%   (“Democrat” or “Republican”). The votes are recorded as “-1” for a 
%   negative vote, “1” for a positive vote, and “0” for a neutral or no 
%   vote.
load voting
% * Calculate the “city block” distance between each representative’s 
%   record. (The city block distance is the sum of all total differences.)
cityBlockDistances = pdist(vote, 'cityblock');
% * Use cmdscale to reconstruct coordinates from the distances. Check the
%   eigenvalues to see how many dimensions dominate the structure. Plot the
%   reconstructed coordinates in two dimensions, grouped by political 
%   party.
[compressedVotes, eigVals] = cmdscale(cityBlockDistances);
% Check quality of compression:
figure
subplot(2, 1, 1)
plot(eigVals, 'bo-')
subplot(2, 1, 2)
pareto(eigVals)
% Visualise the data in 2D:
figure
gscatter(compressedVotes(:, 1), compressedVotes(:, 2), party)
% PARTY - categorical (discrete) grouping variable

% * Use k-means clustering to divide the representatives into two groups. 
%   Remember to use the city block distance.
rng default % Obtain consistent results
[grpIdx, centroids] = kmeans(vote, 2, 'Distance', 'cityblock');
figure
bar(centroids(1, :))
title('Centroid of cluster 1')
figure
bar(centroids(2, :))
title('Centroid of cluster 2')
% Centroids represent "typical" voting records for individuals in the two
% groups.
% x-axis: # of votes
% y-axis: vote records (+1, -1, 0).

% * Create a silhouette plot to evaluate the quality of the clustering.
figure
silhouette(vote, grpIdx, 'cityblock')

% * Compare the grouping from the clustering with the grouping by political
%   party. To perform the comparison, you will need to convert the group 
%   variable to a categorical with the same levels (“Democrat” or 
%   “Republican”) as the party array. Calculate the proportion of matches
%   between the group designation and the political party.
kmeansResults = categorical(repmat({'democrat'}, size(party)));
kmeansResults(grpIdx == 2) = 'republican';
errorRate = 100 * (sum(kmeansResults ~= party))/ numel(party);
% When we compare the kmeans groups to the actual political
% parties, we obtain about 85% accuracy (100% - errorRate).

%% Voting record - classification and reduction.
%
% * Load voting.mat. This file contains a matrix representing the 
%   congressional voting record of 435 U.S. representatives on 16 key 
%   issues, and a categorical array with their political party affiliation
%   (“Democrat” or “Republican”). The votes are recorded as “-1” for a 
%   negative vote, “1” for a positive vote, and “0” for a neutral or no 
%   vote.
load voting
X = vote; % Different voting results (16 discrete variables). 
y = party; % Political party (binary, categorical (2 levels)).
% * Use cvpartition to split the voting record and party affiliation 
%   variables into a training set and a validation set. 
rng default
c = cvpartition(numel(y), 'HoldOut', 0.20); % Leave 20% for testing.
trainingIdx = training(c);
testIdx = test(c);
XTrain = X(trainingIdx, :); 
XTest = X(testIdx, :);
yTrain = y(trainingIdx);
yTest = y(testIdx);
% * Create an ensemble of bagged decision trees that predicts political 
%   party affiliation based on voting record.
singleTree = fitctree(XTrain, yTrain);
% Visualise:
view(singleTree, 'mode', 'graph')

% Extend this to a forest of trees (bootstrapped aggregation):
f = fitensemble(XTrain, yTrain, 'Bag', 500, 'Tree', 'Type', 'Classification');
% Here, we're using 500 trees to classify the data.

% * Use the validation set to evaluate the accuracy of the trees’ 
%   predictions.
fPred = predict(f, XTest);
errors = fPred ~= yTest;
errRate = 100*sum(errors)/numel(errors);
fprintf('Error rate for random forest is %.2f%%\n', errRate);
% Confusion matrix:
confMat = confusionmat(yTest, fPred);
figure
imagesc(confMat)
colormap('cool')
colorbar
xlabel('Predicted class')
ylabel('Known class')
title('Confusion matrix for random forest')
labels = categories(party);
set(gca, 'XTick', 1:numel(labels), 'XTickLabel', labels, ...
    'YTick', 1:numel(labels), 'YTickLabel', labels)
[Xgrid, Ygrid] = meshgrid(1:size(confMat, 1));
Ctext = num2str(confMat(:));
text(Xgrid(:), Ygrid(:), Ctext)
% * Compute the predictor importance scores in your model and determine the
%   top five most important predictors.
p = predictorImportance(f);
% Visualise.
[pSorted, sortPos] = sort(p);
figure
barh(pSorted)
set(gca, 'YTick', 1:numel(p), 'YTickLabel', issues(sortPos))
% (Reorders the voting issues by importance.)
title('Random Forest Predictor Importance')
top5PredsIdx = sortPos(end:-1:end-4);
top5Issues = issues(top5PredsIdx);
% * Create another bagged tree ensemble using only the issues determined in
%   the previous step. Compare the accuracy of this model with the accuracy
%   of the full model.
f2 = fitensemble(XTrain(:, top5PredsIdx), ...
                 yTrain, 'Bag', 500, 'Tree', 'Type', 'Classification');
f2Pred = predict(f2, XTest(:, top5PredsIdx));
errors = f2Pred ~= yTest;
errRate = 100*sum(errors)/numel(errors);
fprintf('Error rate for second random forest is %.2f%%\n', errRate);
% Visualise the split on the voting issue "physician-fee-freeze":
figure
subplot(2, 1, 1)
stem(X(party == 'republican', top5PredsIdx(1)))
title('Republicans')
subplot(2, 1, 2)
stem(X(party == 'democrat', top5PredsIdx(1)))
title('Democrats')