function f2v(video_opt, frame_opt)
%F2V Create a new video file from frames
%   Example
%       video_opt.name        = 'video.avi';
%       video_opt.profile     = 'Motion JPEG AVI';
%       video_opt.fps         = 10;
%
%       frame_opt.path        = 'walking';
%       frame_opt.format      = '%04d.jpg';
%       frame_opt.start       = 1;
%       frame_opt.end         = 412;
%
%       f2v(video_opt, frame_opt);

  frame_opt = default_field(frame_opt, 'path', uigetdir);
  if frame_opt.path(end)~='\'
    frame_opt.path=[frame_opt.path,'\'];
  end
  dirs=dir([frame_opt.path, '*.*']);

  frame_opt = default_field(frame_opt, 'start', 1);
  frame_opt = default_field(frame_opt, 'end',...
   sum(cellfun(@(x) size(sscanf(x,frame_opt.format),1),{dirs.name})));

   index    = strfind(frame_opt.path, '\');
   folder   = frame_opt.path(index(end - 1) + 1 : index(end) - 1);

  video_opt = default_field(video_opt, 'name', folder);
  video_opt = default_field(video_opt, 'fps', 30);

  if (isfield(video_opt, 'profile'))
    writer_obj = VideoWriter(video_opt.name, video_opt.profile);
  else
    writer_obj = VideoWriter(video_opt.name);
  end

  writer_obj.FrameRate  = video_opt.fps;

  open(writer_obj);
  for i = frame_opt.start : frame_opt.end
    frame_fn    = sprintf(frame_opt.format, i);
    frame       = imread([frame_opt.path, frame_fn]);
    writeVideo(writer_obj, frame);
  end

  close(writer_obj);
end

function opt = default_field(opt, field, default)
  if (~isfield(opt, field))
    eval(sprintf('opt.%s = default;',field));
  end
end
