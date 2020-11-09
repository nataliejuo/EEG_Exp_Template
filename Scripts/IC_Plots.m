% TASK:

% Your job is to create a script that will load each ICA preprocessed EEG
% dataset, generate IC Plots for all components, then save those plots as
% image files in a new folder.

% PSEUDO CODE:
clear
close all
% set up directories, paths etc

% set EEGLAB Path (if not already set)
eeglabDir = 'C:/Users/natal/OneDrive/Documents/Lab/GitFolder/EEG_Exp_Template/eeglab2019_1';
if ~exist('eeglab.m')
    cd(eeglabDir);eeglab;clear;close all;cd ..
else
    eeglabDir = 'C:/Users/natal/OneDrive/Documents/Lab/GitFolder/EEG_Exp_Template/eeglab2019_1';
end

% set directories
rDir = 'C:/Users/natal/OneDrive/Documents/Lab/GitFolder/EEG_Exp_Template';
sourceDir = [rDir '/' 'EEG_Prepro3'];  
destDir = [rDir '/' 'Plots_IC']; 

% create a list of filenames in your ICA preprocessed directory (use "dir"
% function)
cd(sourceDir)
d=dir('*3.mat');
cd ..

% subjects for processing
subjects = 1:3;

% start looping through filenames
for iSub=1:length(subjects)
    sjNum = subjects(iSub);
end
       
% save IC plots using this code (you'll need to modify lines 22,23,35 to
% work with your filename)


for iFile=1:length(d)
    filename = d(iFile).name;
    
    % load data
    load([sourceDir '/' filename])

        
        sjNum=filename(3:4); % pull out the subject number from the filename
        seNum=filename(8:9); % pull out the session number from the filename
        
        % generate IC plots (this should bring up two figures)
        pop_viewprops(EEG,0,1:size(EEG.icaweights,1),'freqrange',[2,50])
    
    for i=1:2
    
        if i==1; mapID=2;
        elseif i==2; mapID=1;
        end

        h=gcf; % gets the current figure
        
        saveas(h,[destDir '/' sprintf('sj%s_se%s_map%d_iclabels.jpg',sjNum,seNum,mapID)],'jpeg')
    
        close
    end
end

close all

% end loop, load next filename