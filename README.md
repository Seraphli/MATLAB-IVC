# MATLAB-IVC
MATLAB Image Video Convert (MATLAB-IVC) provide
a set of scripts for conversion
between video files and images.

Scripts is developed to be used in MATLAB.

Please read demo scripts before using these code.

Examples of converting images to a video file
is list in **f2v_demo.m**.

Examples of converting a video file to images
is list in **v2f_demo.m**.

## Examples
Images to a video file

``` MATLAB
clc;clear;
video_opt.fps         = 20;
frame_opt.format      = '%04d.jpg';
fvconvert.f2v(video_opt, frame_opt);
```

A video file to images

## Notice

+ If setting changes,
you need to clear the environment of MATLAB.
+ You should at least provide one parameter
for each option.
+ If you want to use scripts outside of this folder,
you can follow the instruction in **startup.m**.
