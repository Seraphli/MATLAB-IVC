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
%    ivc.f2v(opt);

  opt.OptType = 'f2v';

  if opt.Multi
    code_path = pwd;
    addpath(code_path);
    cd(opt.F_Path);
    dirs = opt.FindSubFolder();
    for i = 1 : size(dirs, 1)
      tmp_opt = ivc.opt();
      tmp_opt.F_Path    = [opt.F_Path dirs(i).name '\'];
      tmp_opt.F_Format  = opt.F_Format;
      tmp_opt.FPS       = opt.FPS;
      tmp_opt.V_Name    = opt.V_Name;
      ivc.f2v(tmp_opt);
    end
    cd(code_path);
  else
    opt.CheckValid();
    opt.CountFrames();

    if opt.Profile
      writer_obj = VideoWriter(opt.V_Name, opt.Profile);
    else
      writer_obj = VideoWriter(opt.V_Name);
    end

    writer_obj.FrameRate  = opt.FPS;

    open(writer_obj);
    hwait = waitbar(0, ['Generate video ', opt.V_Name]);
    set(findall(hwait, 'type', 'text'), 'Interpreter', 'none');
    for i = opt.F_Start : opt.F_End
      h = tic;
      frame_fn    = sprintf(opt.F_Format, i);
      frame       = imread([opt.F_Path, frame_fn]);
      writeVideo(writer_obj, frame);
      time = toc(h) * (opt.F_End - i);
      minute = floor(time / 60);
      second = ceil(time - 60 * minute);
      PerStr = fix(i * 100 / (opt.F_End - opt.F_Start + 1));
      str = {[opt.V_Name,...
          ' | ', 'Frame ', num2str(i)],...
          [num2str(PerStr), '% Completed',...
          ' | ', num2str(minute), ':', num2str(second), ' Remain']};
      waitbar(i / (opt.F_End-opt.F_Start), hwait, str);
    end
    close(hwait);
    close(writer_obj);
  end
end
