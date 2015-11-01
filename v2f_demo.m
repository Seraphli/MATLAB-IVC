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
opt.F_Path    = 'auto';
opt.F_Format  = '%04d.jpg';

ivc.v2f(opt);
%% Example 3:
% Select folder using a dialog
clc;clear;
opt = ivc.opt();
opt.F_Format  = '%04d.jpg';

ivc.v2f(opt);