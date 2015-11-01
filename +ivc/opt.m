classdef opt < handle
  properties (Access = private)
    f_path    = '';
    v_name    = 'input';
    f_end     = 0;
    f_count   = 0;
  end

  properties
    F_Start   = 1;
    Profile   = 0;
    FPS       = 30;
    F_Format  = 0;
  end

  properties (Dependent = true)
    F_Path
    V_Name
    F_End
  end

  methods
    function f_path = get.F_Path(obj)
      if isempty(obj.f_path)
        obj.f_path = uigetdir(pwd, 'Select a folder contain frames');
      end
      if ischar(obj.f_path)  && (obj.f_path(end) ~= '\')
        obj.f_path = [obj.f_path, '\'];
      end
      f_path = obj.f_path;
    end
    function set.F_Path(obj, f_path)
      obj.f_path = f_path;
    end

    function name = get.V_Name(obj)
      if strcmp(obj.v_name, 'input')
        obj.v_name = uiputfile(...
          {'*.avi;*.mj2;*.mp4;*.m4v','All Support Files'},...
          'Save as');
        if ~obj.v_name
          obj.v_name  = [obj.GetFolderName() '.avi'];
        end
      end
      if strcmp(obj.v_name, 'folder')
        obj.v_name  = [obj.GetFolderName() '.avi'];
      end
      name = obj.v_name;
    end
    function set.V_Name(obj, name)
      obj.v_name = name;
    end

    function f_end = get.F_End(obj)
      if ~obj.f_end
        obj.f_end = obj.f_count;
      end
      f_end = obj.f_end;
    end
    function set.F_End(obj, f_end)
      obj.f_end = f_end;
    end

    function folder = GetFolderName(obj)
      index       = strfind(obj.F_Path, '\');
      folder      = obj.F_Path(...
        index(end - 1) + 1 : index(end) - 1);
    end

    function CheckValid(obj)
      if ~obj.F_Path
        error('Exception:InvalidOption', 'Select a folder first!');
      else
        if ~exist(obj.F_Path, 'dir')
          error('Exception:IOError', 'Folder path doesn''t exist!');
        end
      end

      if ~obj.F_Format
        error('Exception:InvalidOption',...
          'Please specify format string of frame files!')
      else
        dirs  = dir([obj.F_Path, '*.*']);
        obj.f_count = sum(...
          cellfun(@(x) size(sscanf(x, obj.F_Format), 1), {dirs.name}));
        if ~obj.f_count
          error('Exception:InvalidOption',...
            'Please check your format string!');
        end
      end
    end
  end
end