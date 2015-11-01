function f2v(opt)
%F2V Create a new video file from frames
%  Example
%    opt = ivc.opt();
%    opt.V_Name      = 'video.avi';
%    opt.Profile     = 'Motion JPEG AVI';
%    opt.FPS         = 10;
%    opt.F_Path      = 'walking';
%    opt.F_Format    = '04d.jpg';
%    opt.F_Start     = 1;
%    opt.F_End       = 412;
%
%    ivc.f2v(opt);

  opt.OptType = 'f2v';
  opt.CheckValid();
  opt.CountFrames();

  if opt.Profile
    writer_obj = VideoWriter(opt.V_Name, opt.Profile);
  else
    writer_obj = VideoWriter(opt.V_Name);
  end

  writer_obj.FrameRate  = opt.FPS;

  open(writer_obj);
  for i = opt.F_Start : opt.F_End
    frame_fn    = sprintf(opt.F_Format, i);
    frame       = imread([opt.F_Path, frame_fn]);
    writeVideo(writer_obj, frame);
  end

  close(writer_obj);
end
