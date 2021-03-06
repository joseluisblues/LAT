
% timedelaycheckengplotting.m
% apply in
%/Users/labodance/Documents/DataAnalysis/transfering_files_labodanse_3/2015_05_12_14_15/Server

% created by JLUF 11/06/2015
% updates:
% JLUF 23/06/2015

%% variables
folders = {'LD_expMay2015_Day1','LD_expMay2015_Day2','LD_expMay2015_Day3'};
homeFolder = pwd;

%% get into each data-type folder

for i_folder = 1:length(folders)
    
    cd (folders{i_folder})
    cd ('ENG')
    files2 = dir('*.csv');
    fileNames2 = {files2.name}; % get the name of each file
    
    for i_dataFile = 1:length(files2)
        
        localFolder = pwd;
        nameFile = fileNames2{i_dataFile};
        dataFile = importdata(fileNames2{i_dataFile});
        
        % difference time server/tablet
        differenceTiming = dataFile.data(:,2) - dataFile.data(:,1);
        
        destinyFolder = '/Users/labodance/Documents/DataAnalysis/transfering_files_labodanse_3/3_images';
        [pathstrFile,nameFile2,extFile] = fileparts(nameFile);
        %fullPath = fullfile(destinyFolder, nameFile2);
        nameFile3 = strrep(nameFile2, '_', '-');
        
        figure,
        set(gcf,'Visible','off');
        set(gcf, 'units', 'normalized', 'position', [0 0 1.3 .8]);
        plot(differenceTiming)
        xlabel('Samples'), ylabel('LINUX timestemps difference (SERVER-TABLET)');
        title(nameFile3)
        
        nameFigure = sprintf('delay_tablet_server_ENG_%s.png', nameFile2);
        
        % save
        cd (destinyFolder)
        
        f = getframe(gcf); % Capture the current window
        imwrite(f.cdata, nameFigure); % Save the frame data
        close(gcf);
                
        cd (localFolder)
        
    end
    
    cd ../..
end

%% END