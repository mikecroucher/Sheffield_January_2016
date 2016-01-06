function setWorkshopPath()

rootDir = fileparts(which(mfilename));

foldersToAdd = {'Data', 'Exercises', 'Lesson_Plans', 'Reference'};

for k = 1:numel(foldersToAdd)
    addpath(genpath([rootDir, filesep, foldersToAdd{k}]))
end

end