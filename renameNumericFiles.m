function [] = renameNumericFiles(fileName)
%Function to search the cd for files with fileName and renames numerical
%indexes in filenames to have a fixed number of digits (one more than need
%for the number of files found)

files = dir(fileName);

pat1 = '[.]';
pat2 = '[0-9]';

for ii = 1:length(files)
    
    pIdx = regexp(files(ii).name,pat1);
% %     numIdx = regexp(files(ii).name,pat2);
% % 
% %     diffIdx_ = [numIdx,pIdx];
% %     clear diifIdx
% %     for jj = 1:length(diffIdx_)-1
% %         diffIdx(jj) = diffIdx_(jj+1)-diffIdx_(jj);
% %     end
% %     b = find(fliplr(diffIdx)>1,1,'first');
% %     numStart = pIdx - b + 1;
% %     numEnd = pIdx - 1;
% %     
% %     idx = [numStart:numEnd];
% %     orig_num = files(ii).name(idx(regexp(files(ii).name(numStart:numEnd),pat2)));
    
    cnt = 0;
    cur_char = files(ii).name(pIdx-1);
    while ~isnan(str2num(cur_char))
        cur_char = files(ii).name(pIdx-1-cnt);
        cnt = cnt+1;
    end    
    
    orig_num = files(ii).name(pIdx-cnt+1:pIdx-1)
    
    fileNum = 10*length(files) + str2double(orig_num);
    
    pre = files(ii).name(1:pIdx-cnt);
    post = files(ii).name(pIdx:end);
    movefile(['.',filesep,files(ii).name],['.',filesep,pre,num2str(fileNum),post]);
% ['.',filesep,pre,num2str(fileNum),post]    


end


end







