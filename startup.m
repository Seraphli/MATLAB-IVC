path    = mfilename('fullpath');
i       = strfind(path, '\');
path    = path(1 : i(end));
fprintf('Please put this following code before the usage of converter:\n');
fprintf('addpath(''%s'');\n', path);
