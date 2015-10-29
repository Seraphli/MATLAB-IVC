%% Example 1:
clc;clear;
video_opt.name        = 'video.avi';
video_opt.profile     = 'Motion JPEG AVI';
video_opt.fps         = 10;

frame_opt.path        = 'walking';
frame_opt.format      = '%04d.jpg';
frame_opt.start       = 1;
frame_opt.end         = 412;

ivc.f2v(video_opt, frame_opt);
%% Example 2:
clc;clear;
video_opt.fps         = 20;
frame_opt.format      = '%04d.jpg';
ivc.f2v(video_opt, frame_opt);
