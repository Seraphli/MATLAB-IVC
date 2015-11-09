function v2f(opt)
%V2F Generate frames from a video file
%   Example
%     opt = ivc.opt();
%     opt.V_Name    = 'video.avi';
%     opt.F_Path    = 'walking2';
%     opt.F_Format  = '%04d.jpg';
%     ivc.v2f(opt);

  opt.OptType = 'v2f';

  if opt.Multi
    opt.F_Path = 'select';
    code_path = pwd;
    addpath(code_path);
    cd(opt.F_Path);
    dirs = opt.FindFiles();
    for i = 1 : size(dirs, 1)
      tmp_opt = ivc.opt();
      tmp_opt.F_Format  = opt.F_Format;
      tmp_opt.V_Name    = dirs(i).name;
      ivc.v2f(tmp_opt);
    end
    cd(code_path);
  else
    opt.CheckValid();

    reader_obj = VideoReader(opt.V_Name);
    nFrames = reader_obj.NumberOfFrames;
    if isempty(opt.F_End) || opt.F_End == 0
      opt.F_End = nFrames;
    end

    hwait = waitbar(0, ['Generate video ', opt.V_Name]);
    for i = opt.F_Start : opt.F_End
      frame     = read(reader_obj, i);
      frame_fn  = sprintf(opt.F_Format, i);
      imwrite(frame, [opt.F_Path, frame_fn]);
      PerStr = fix(i * 100 / (opt.F_End - opt.F_Start + 1));
      str = [opt.V_Name,...
          ' | ', 'Frame ', num2str(i),...
          ' | ', num2str(PerStr), '% Completed'];
      waitbar(i / (opt.F_End-opt.F_Start), hwait, str);
    end
    close(hwait);
  end
end
