%% Example 1:
% Specify all parameter
% Auto create the directory
clc;clear;
opt = ivc.opt();
opt.V_Name    = 'video.avi';
opt.F_Path    = 'walking2';
opt.F_Format  = '%04d.jpg';

ivc.v2f(opt);
%% Example 2:
% Select the video file using a dialog
% Auto using video name as folder name
clc;clear;
opt = ivc.opt();
opt.V_Name    = 'input';
opt.F_Format  = '%04d.jpg';

ivc.v2f(opt);
%% Example 3:
% Select folder using a dialog
clc;clear;
opt = ivc.opt();
opt.F_Path    = 'select';
opt.F_Format  = '%04d.jpg';

ivc.v2f(opt);

%% Example 4:
% Select a folder contain multiple video files
% e.g. ./another_path/video_seq
clc;clear;
opt = ivc.opt();
opt.Multi     = true;
opt.F_Format  = '%04d.jpg';

ivc.v2f(opt);
