function v2f(opt)
%V2F Generate frames from a video file
%   Example
%     opt = ivc.opt();
%     opt.V_Name    = 'video.avi';
%     opt.F_Path    = 'walking2';
%     opt.F_Format  = '%04d.jpg';

  ivc.v2f(opt);
  opt.OptType = 'v2f';
  opt.CheckValid();

  reader_obj = VideoReader(opt.V_Name);
  nFrames = reader_obj.NumberOfFrames;

  for i = 1 : nFrames
    frame     = read(reader_obj, i);
    frame_fn  = sprintf(opt.F_Format, i);
    imwrite(frame, [opt.F_Path, frame_fn]);
  end
end
