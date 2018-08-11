
% visualizeHR_2.m
% inspired from visualizeHRV_2.m
% compare the effects of a manipulation on HR data
% appy in:
% /Users/labodance/Documents/DataAnalysis/transfering_files_labodanse_2/2_data_analysis/bioharness_new/bioharness_3

% created by JLUF 19/08/2015

%% Defining the destiny folder 

destinyFolder = input('Folder name to save the data? > ', 's');
% example: > bioharness_2
sourcePath = pwd;

%% variables

session = {'ECG_2014_12_11' 'ECG_2014_12_12'};
effects = {'PM1_alt' 'PM2_alt' 'Yoga'};
%effects = {'PM1_alt' 'Yoga'};

%for i_session = 1:length(session)
for i_session = 2:2
    for i_effects = 1:length(effects)
        
        if strcmp(effects{i_effects}, 'PM1_alt') || strcmp(effects{i_effects}, 'PM2_alt')
            first_path = sprintf('%s_%s_PTB', session{i_session}, effects{i_effects});
            second_path = sprintf('%s_%s_PTA', session{i_session}, effects{i_effects});
        else
            first_path = sprintf('%s_%s_YTB', session{i_session}, effects{i_effects});
            second_path = sprintf('%s_%s_YTA', session{i_session}, effects{i_effects});
        end
        
        if strcmp(effects{i_effects}, 'PM1_alt') || strcmp(effects{i_effects}, 'PM2_alt')
            first_matfile = sprintf('HRVstruct_%s_%s_PTB.mat', session{i_session}, effects{i_effects});
            first_targetfile = sprintf('HRVstruct_%s_%s_PTB', session{i_session}, effects{i_effects});
            second_matfile = sprintf('HRVstruct_%s_%s_PTA.mat', session{i_session}, effects{i_effects});
            second_targetfile = sprintf('HRVstruct_%s_%s_PTA', session{i_session}, effects{i_effects});
        else
            first_matfile = sprintf('HRVstruct_%s_%s_YTB.mat', session{i_session}, effects{i_effects});
            first_targetfile = sprintf('HRVstruct_%s_%s_YTB', session{i_session}, effects{i_effects});
            second_matfile = sprintf('HRVstruct_%s_%s_YTA.mat', session{i_session}, effects{i_effects});
            second_targetfile = sprintf('HRVstruct_%s_%s_YTA', session{i_session}, effects{i_effects});
        end
        
        first_link = fullfile(first_path, first_matfile);
        load(first_link);
        eval([' first_file = ' first_targetfile ';']);
        
        second_link = fullfile(second_path, second_matfile);
        load(second_link);
        eval([' second_file = ' second_targetfile ';']);
        
        %structureName = sprintf('first_file.Freq1HR'); % before data
        %eval(['lengthData = length(' structureName ');']);
        
        %%
        first_file_HR = first_file.HRInterp;
        first_file_HR_save = first_file.HRInterp;
        second_file_HR = second_file.HRInterp;
        second_file_HR_save = second_file.HRInterp;
         
        %% first part
        figure1 = figure('Color',[1 1 1]);
        set(gcf,'Visible','off');
        set(gcf, 'units', 'normalized', 'position', [0 0 1 1]);
        
        titleFigure_ini = sprintf('%s_%s', session{i_session}, effects{i_effects});
        titleFigure = strrep(titleFigure_ini,'_','-');
                
        % ----------------------------- %
        
        if strcmp(session{i_session}, 'ECG_2014_12_11') && strcmp(effects{i_effects}, 'PM1_alt')   
            cellReplace = cell(length(first_file_HR), 1);
            cellReplace{1} = second_file_HR{1};
            cellReplace{2} = second_file_HR{2};
            cellReplace{3} = NaN;
            cellReplace{4} = second_file_HR{3};
            cellReplace{5} = second_file_HR{4};
            cellReplace{6} = second_file_HR{5};
            %
            second_file_HR = cellReplace;
            
        elseif strcmp(session{i_session}, 'ECG_2014_12_12') && strcmp(effects{i_effects}, 'PM1_alt')            
            cellReplace = cell(length(first_file_HR), 1);
            cellReplace{1} = second_file_HR{1};
            cellReplace{2} = NaN;
            cellReplace{3} = second_file_HR{2};
            cellReplace{4} = second_file_HR{3};
            cellReplace{5} = second_file_HR{4};
            cellReplace{6} = second_file_HR{5};
            cellReplace{7} = NaN;
            cellReplace{8} = NaN;
            cellReplace{9} = NaN;
            %
            second_file_HR = cellReplace;
        
        elseif strcmp(session{i_session}, 'ECG_2014_12_12') && strcmp(effects{i_effects}, 'PM2_alt')            
            cellReplace = cell(5, 1);
            cellReplace{1} = first_file_HR{1};
            cellReplace{2} = NaN;
            cellReplace{3} = first_file_HR{2};
            cellReplace{4} = first_file_HR{3};
            cellReplace{5} = first_file_HR{4};
            %
            first_file_HR = cellReplace;
            
            cellReplace2 = cell(8, 1);
            cellReplace2{1} = second_file_HR{1};
            cellReplace2{2} = NaN;
            cellReplace2{3} = second_file_HR{2};
            cellReplace2{4} = second_file_HR{3};
            cellReplace2{5} = second_file_HR{4};
            %
            second_file_HR = cellReplace2;            
            
        end        
        
        lengthData = length(first_file_HR);
        
        %% second part
        for i_subplot = 1:lengthData
            subplot(3,4,i_subplot)
            
            i_subplot_b = i_subplot;
            eval_1 = sprintf('h1 = plot(first_file_HR{%d}, \''color\'',\''b\'');', i_subplot); % before
            eval(eval_1)
            hold on
            eval_2 = sprintf('h2 = plot(second_file_HR{%d}, \''color\'', \''r\'');', i_subplot_b); % after
            eval(eval_2)
            
            xlabel('datapoints'), ylabel('HR')
            titleStr = sprintf('before(b) vs after(r) (subj %d)', i_subplot);
            title(titleStr)
        end
        suplabel(titleFigure, 't');
        tightfig;
        
        %% Save
        
        ouputFolder = sprintf('../%s', destinyFolder);
        cd (ouputFolder)
        
        %% third part
        nameFigure = sprintf('%s_%s_comparison_HR.png', session{i_session}, effects{i_effects});
        f = getframe(gcf); % Capture the current window
        imwrite(f.cdata, nameFigure); % Save the frame data
        close(gcf);
        
        cd (sourcePath)
        
    end
end