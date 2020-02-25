function [scale] = vid2imgs(vidName,folder_out,desamp,ref_length)
%This function take in the path to a video file and an output directory and
%deconstructs the video into frames taken at the given sampling rate (every
%n'th frame is gathered). 

%Set up the object defining the video parameters
vidObj = VideoReader(vidName);
vidHeight = vidObj.Height;
vidWidth = vidObj.Width;

if nargin < 4
    ref_length = 1;
end

%Make a new output folder if none exists
if exist(folder_out,'dir') ~= 7
    mkdir(folder_out);
end

%Variable declaration
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
    'colormap',[]);
k = 1;
h = 0;
desamp = desamp-1;

%Loop through the video to extract frames
while hasFrame(vidObj)
    
    %Define a temp variable so that readFrame works properly
    temp = readFrame(vidObj);
    
    %Check the frame number
    if mod(h,desamp) == 0
        
        %When at the correct place, save the next frame to the output
        s(k).cdata = readFrame(vidObj);
        k = k+1;
    end
    
    %Clear temp to free up memory
    clear temp
    
    h = h+1;
    
end

% whos s
% 
% %Display the resultant video in the correct-size window, and the correct
% %duration (i.e. the new framerate)
% set(gcf,'position',[150 150 vidObj.Width vidObj.Height]);
% set(gca,'units','pixels');
% set(gca,'position',[0 0 vidObj.Width vidObj.Height]);
% movie(s,1,vidObj.FrameRate/desamp);

%% Pick cropping region

figure(1)
imagesc(s(floor(length(s)/2)).cdata)
title('Click to select cropping region. Define two points: top right and bottom left')
axis('image');
[top_left,bottom_right] = ginput(2);
top_left = ceil(top_left);
bottom_right = ceil(bottom_right);

if nargin < 4
    title('Click to set scale. Define two points.')
    [X,Y] = ginput(2);
else
    
%% Write out images
ext = '.tiff';
fmt = 'tiff';
folder = './output_images/';

prefixes = cell(1,26^3);

alphab = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o',...
    'p','q','r','s','t','u','v','w','x','y','z'};

kk = 0;
for hh = 1:length(alphab)
    for ii = 1:length(alphab)
        for jj = 1:length(alphab)
            kk = kk + 1;
            prefixes{kk} = strcat(alphab{hh},alphab{ii},alphab{jj});
        end
    end
end

for ii = 1:k-1
    
    dir_filename = strcat(folder,prefixes{ii},'_frame_number_',...
        num2str((ii-1)*(desamp+1)),ext); %use prefix to ensure proper ordering
    cur_img_ = s(ii).cdata;
    cur_img = cur_img_(top_left(2):top_left(1),bottom_right(1):bottom_right(2),:); %Cropped size from ginput
    imwrite(cur_img,dir_filename,fmt); %Write the file with the specified settings

end






