function files = download_data(dataset_name)
%Download dataset.

switch lower(dataset_name)
  case {'mnist-full', 'mnist-test'}
    files = download_mnist();
  case 'fashion-mnist'
    files = download_fmnist();
  case 'usps'
    files = download_usps();
  case {'cifar-10', 'cifar-100'}
    files = download_cifar();
  case 'stl-10'
    files = download_stl();
  otherwise
    error('Unknown dataset! Support: mnist-full, mnist-test, fashion-mnist, usps, cifar-10, cifar-100, stl-10');
end

end

function files = download_mnist()
% download mnist data (http://yann.lecun.com/exdb/mnist/)

data_dir = fullfile(gac_root, 'data', 'mnist') ;

files = {'train-images-idx3-ubyte', ...
         'train-labels-idx1-ubyte', ...
         't10k-images-idx3-ubyte', ...
         't10k-labels-idx1-ubyte'} ;

if ~exist(data_dir, 'dir')
  mkdir(data_dir) ;
end

for i=1:length(files)
  if ~exist(fullfile(data_dir, files{i}), 'file')
    url = sprintf('http://yann.lecun.com/exdb/mnist/%s.gz',files{i}) ;
    fprintf('downloading %s\n', url) ;
    gunzip(url, data_dir) ;
  end
end

end

function files = download_fmnist()
% download fashion-mnist data (https://github.com/zalandoresearch/fashion-mnist)

data_dir = fullfile(gac_root, 'data', 'fashion-mnist') ;

files = {'train-images-idx3-ubyte', ...
         'train-labels-idx1-ubyte', ...
         't10k-images-idx3-ubyte', ...
         't10k-labels-idx1-ubyte'} ;

if ~exist(data_dir, 'dir')
  mkdir(data_dir) ;
end

for i=1:length(files)
  if ~exist(fullfile(data_dir, files{i}), 'file')
    url = sprintf('http://fashion-mnist.s3-website.eu-central-1.amazonaws.com/%s.gz',files{i}) ;
    fprintf('downloading %s\n', url) ;
    gunzip(url, data_dir) ;
  end
end

end

function files = download_usps()
% download usps data (https://cs.nyu.edu/~roweis/data/)

data_dir = fullfile(gac_root, 'data', 'usps') ;

files = {'usps_all'} ;

if ~exist(data_dir, 'dir')
  mkdir(data_dir) ;
end

for i=1:length(files)
  if ~exist(fullfile(data_dir, [files{i} '.mat']), 'file')
    url = sprintf('https://cs.nyu.edu/~roweis/data/%s.mat',files{i}) ;
    fprintf('downloading %s\n', url) ;
    websave(fullfile(data_dir, files{i}), url) ;
  end
end

end

function files = download_cifar()
% download fashion-mnist data (https://www.cs.toronto.edu/~kriz)

data_dir = fullfile(gac_root, 'data', 'cifar') ;

url_path = 'https://www.cs.toronto.edu/~kriz';
files = {'cifar-10-matlab', ...
    'cifar-100-matlab'} ;

if ~exist(data_dir, 'dir')
  mkdir(data_dir) ;
end

for i=1:length(files)
  if ~exist(fullfile(data_dir, files{i}), 'dir')
    url = sprintf('%s/%s.tar.gz', url_path, files{i}) ;
    fprintf('downloading %s\n', url) ;
    gunzip(url, data_dir) ;
    untar(sprintf('%s/%s.tar', data_dir, files{i}), data_dir);
  end
end

if exist(fullfile(data_dir, 'cifar-10-batches-mat'), 'dir')
    movefile(fullfile(data_dir, 'cifar-10-batches-mat'), fullfile(data_dir, files{1}));
end

end

function files = download_stl()
% download fashion-mnist data (https://github.com/zalandoresearch/fashion-mnist)

data_dir = fullfile(gac_root, 'data', 'stl') ;

url_path = 'http://ai.stanford.edu/~acoates/stl10';
files = {'stl10_matlab'} ;

if ~exist(data_dir, 'dir')
  mkdir(data_dir) ;
end

for i=1:length(files)
  if ~exist(fullfile(data_dir, files{i}), 'dir')
    url = sprintf('%s/%s.tar.gz', url_path, files{i}) ;
    fprintf('downloading %s\n', url) ;
    gunzip(url, data_dir) ;
    untar(sprintf('%s/%s.tar', data_dir, files{i}), data_dir);
  end
end
exit();

end
