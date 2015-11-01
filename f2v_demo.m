%% Example 1:
% Specify all parameter
clc;clear;
opt = ivc.opt();
opt.V_Name      = 'video.avi';
opt.Profile     = 'Motion JPEG AVI';
opt.FPS         = 10;
opt.F_Path      = 'walking';
opt.F_Format    = '%04d.jpg';
opt.F_Start     = 1;
opt.F_End       = 41;

ivc.f2v(opt);
%% Example 2:
% Select folder using a dialog
% Auto using folder name as video name
clc;clear;
opt = ivc.opt();
opt.V_Name      = 'folder';
opt.FPS         = 20;
opt.F_Format    = '%04d.jpg';

ivc.f2v(opt);
%% Example 3:
% Pop a save file dialog to save video file
clc;clear;
opt = ivc.opt();
opt.FPS         = 20;
opt.F_Format    = '%04d.jpg';

ivc.f2v(opt);
