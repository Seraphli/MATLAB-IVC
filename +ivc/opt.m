classdef opt < handle
  properties (Access = private)
    f_path    = 'auto';
    v_name    = 'folder';
    f_end     = 0;
    f_count   = 0;
  end

  properties
    OptType   = '';
    F_Start   = 1;
    Profile   = 0;
    FPS       = 30;
    F_Format  = 0;
    Multi     = false;
  end

  properties (Dependent = true)
    F_Path
    V_Name
    F_End
    F_Count
  end

  methods
    function f_path = get.F_Path(obj)
      if strcmp(obj.f_path, 'select')
        if obj.Multi
          if strcmp(obj.OptType, 'f2v')
            str =  'Select a folder contain multiple folders';
          else
            str =  'Select a folder contain multiple files';
          end
        else
          if strcmp(obj.OptType, 'f2v')
            str =  'Select a folder contain frames';
          else
            str =  'Select a folder to save frames';
          end
        end
        obj.f_path = uigetdir(pwd, str);
      end
      if strcmp(obj.f_path, 'auto') && ~obj.Multi
        obj.f_path = obj.GetVideoName();
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
      if strcmp(obj.OptType, 'f2v')
        if ~obj.Multi
          if strcmp(obj.v_name, 'input')
            obj.v_name = uiputfile(...
              {'*.avi;*.mj2;*.mp4;*.m4v','All Supported Files'},...
              'Save as');
            if ~obj.v_name
              obj.v_name  = [obj.GetFolderName() '.avi'];
            end
          end
          if strcmp(obj.v_name, 'folder')
            obj.v_name  = [obj.GetFolderName() '.avi'];
          end
        end
      else
        if strcmp(obj.v_name, 'input')
          obj.v_name = uigetfile(...
            {'*.avi;*.mj2;*.mp4;*.m4v','All Supported Files'},...
            'Select a video file');
        end
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

    function f_count = get.F_Count(obj)
      dirs  = dir([obj.F_Path, '*.*']);
      obj.f_count = sum(...
        cellfun(@(x) size(sscanf(x, obj.F_Format), 1), {dirs.name}));
      f_count = obj.f_count;
    end
  end

  methods
    function folder = GetFolderName(obj)
      index   = strfind(obj.F_Path, '\');
      folder  = obj.F_Path(...
        index(end - 1) + 1 : index(end) - 1);
    end

    function name = GetVideoName(obj)
      index1   = strfind(obj.V_Name, '\');
      index2   = strfind(obj.V_Name, '.');
      if isempty(index1)
        name    = obj.V_Name(...
          1 : index2(1) - 1);
      else
        name    = obj.V_Name(...
          index1(end - 1) + 1 : index2(1) - 1);
      end
    end

    function dirs = FindSubFolder(obj)
      dirs = dir(obj.F_Path);
      dirs = dirs(cellfun(@(x) isequal(x, 1), {dirs(:).isdir}));
      dirs = dirs(~cellfun(...
        @(x) strcmp(x, '.')||strcmp(x, '..'), {dirs(:).name}));
    end

    function files = FindFiles(obj)
      files = dir(obj.F_Path);
      files = files(cellfun(@(x) isequal(x, 0), {files(:).isdir}));
      f = @(x) strfind(x, '.avi')...
        || strfind(x, '.mj2')...
        || strfind(x, '.mp4')...
        || strfind(x, '.m4v');
      files = files(cellfun(f, {files(:).name}));
    end

    function CheckValid(obj)
      if strcmp(obj.OptType, 'f2v')

        if ~obj.F_Path
          throw(MException('Exception:InvalidOption',...
            'Select a folder first!'));
        else
          if ~exist(obj.F_Path, 'dir')
            throw(MException('Exception:IOError',...
              'Folder path doesn''t exist!'));
          end
        end

      else

        if ~obj.V_Name
          throw(MException('Exception:InvalidOption',...
            'Select a video file first!'));
        else
          if ~exist(obj.V_Name, 'file')
            throw(MException('Exception:IOError',...
              'The video file doesn''t exist!'));
          end
        end

        if ~obj.F_Path
          throw(MException('Exception:InvalidOption',...
            'Select a folder first!'));
        else
          if ~exist(obj.F_Path, 'dir')
            mkdir(obj.F_Path);
          end
        end
      end

      if ~obj.F_Format
        throw(MException('Exception:InvalidOption',...
          'Please specify format string of frame files!'));
      end
    end

    function CountFrames(obj)
      if ~obj.F_Count
        throw(MException('Exception:IOError',...
          'No valid frames in the folder!'));
      end
    end
  end
end
