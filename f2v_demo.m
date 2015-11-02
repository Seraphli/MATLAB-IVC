%% Example 1:
% Specify all parameter
clc;clear;
opt = ivc.opt();
opt.V_Name    = 'video.avi';
opt.Profile   = 'Motion JPEG AVI';
opt.FPS       = 10;
opt.F_Path    = 'walking';
opt.F_Format  = '%04d.jpg';
opt.F_Start   = 1;
opt.F_End     = 10;

ivc.f2v(opt);
%% Example 2:
% Select folder using a dialog
% Auto using folder name as video name
clc;clear;
opt = ivc.opt();
opt.F_Path      = 'select';
opt.FPS         = 20;
opt.F_Format    = '%04d.jpg';

ivc.f2v(opt);
%% Example 3:
% Pop a save file dialog to save video file
clc;clear;
opt = ivc.opt();
opt.F_Path      = 'select';
opt.V_Name      = 'input';
opt.FPS         = 20;
opt.F_Format    = '%04d.jpg';

ivc.f2v(opt);
%% Example 4:
% Select a folder contain multiple folders
% e.g. ./another_path/image_seq
clc;clear;
opt = ivc.opt();
opt.Multi     = true;
opt.F_Format  = '%04d.jpg';

ivc.f2v(opt);
