function EEG_ATTLAB_Merge_Partial_Recordings(brokenDataPath,mergedFilename,varargin)
%{
EEG_ATTLAB_Merge_Broken_Files
Author: Tom Bullock, UCSB Attention Lab
Date created: 09.30.20
Date updated: 09.30.20

Purpose: merge files from an interrupted recording

Inputs: 
brokenDataPath: directory where the partial recordings are stored
mergedFilename: what you want to call the new merged file (e.g.
'sj01_Cond01.mat').  Must have full extension.  
varargin: filenames of partial recordings in the order that you want to
merge them.  Can take 2 or more inputs e.g. {'sj01_Cond01_p1.bdf','sj01_Cond01_p2.bdf',...}

Output: 
Script will save a merged data file in .mat format with the designated
name.  The file will save to the same directory as the partial recordings.

%}

for i=1:length(varargin{1})
    disp(['Merging File ' num2str(i)])
    if i==1 % load first EEG file
        if strcmp(varargin{1}{i}(end),'r') % if brain vision files (.vhdr)
            EEGO = pop_fileio([brokenDataPath '/' varargin{1}{i}]);
        else % if biosemi files (bdf)
            EEGO = pop_biosig([brokenDataPath '/' varargin{1}{i}]);
        end
    else % load subsequent EEG file(s) and merge
        if strcmp(varargin{1}{i}(end),'r') % if brain vision files (.vhdr)
            EEG = pop_fileio([brokenDataPath '/' varargin{1}{i}]);
        else % if biosemi files (bdf)
            EEG = pop_biosig([brokenDataPath '/' varargin{1}{i}]);
        end
        EEGO = pop_mergeset(EEGO,EEG);
    end
end

EEG = EEGO;

% save merged data file as .mat
save([brokenDataPath '/' mergedFilename],'EEG')

return