function [data, labels] = load_data(dataset_name)
%Load dataset for experiment.

files = download_data(dataset_name);

switch lower(dataset_name)
  case {'mnist-full', 'mnist-test'}
    [data, labels] = load_mnist(dataset_name, files);
  case 'fashion-mnist'
    [data, labels] = load_fmnist(dataset_name, files);
  case 'usps'
    [data, labels] = load_usps(dataset_name, files);
  case {'cifar-10', 'cifar-100'}
    [data, labels] = load_cifar(dataset_name, files);
  case 'stl-10'
    [data, labels] = load_stl(dataset_name, files);
  otherwise
    error('Unknown dataset! Support: mnist-full, mnist-test, fashion-mnist, usps, cifar-10, cifar-100, stl-10');
end

end

function [data, labels] = load_mnist(dataset_name, files)

fprintf('loading %s\n', dataset_name);
data_dir = fullfile(gac_root, 'data', 'mnist') ;

if isequal(lower(dataset_name), 'mnist-full')
    images = loadMNISTImages(fullfile(data_dir, files{1}));
    labels = loadMNISTLabels(fullfile(data_dir, files{2}));
    images1 = loadMNISTImages(fullfile(data_dir, files{3}));
    labels1 = loadMNISTLabels(fullfile(data_dir, files{4}));
    data = [images, images1];
    labels = [labels; labels1];
elseif isequal(lower(dataset_name), 'mnist-test')
    data = loadMNISTImages(fullfile(data_dir, files{3}));
    labels = loadMNISTLabels(fullfile(data_dir, files{4}));
else
    error('Unknown dataset: neither mnist-full nor mnist-test');
end

end

function [data, labels] = load_fmnist(dataset_name, files)

fprintf('loading %s\n', dataset_name);
data_dir = fullfile(gac_root, 'data', 'fashion-mnist') ;

images = loadMNISTImages(fullfile(data_dir, files{1}));
labels = loadMNISTLabels(fullfile(data_dir, files{2}));
images1 = loadMNISTImages(fullfile(data_dir, files{3}));
labels1 = loadMNISTLabels(fullfile(data_dir, files{4}));
data = [images, images1];
labels = [labels; labels1];

end

function [data, labels] = load_usps(dataset_name, files)

fprintf('loading %s\n', dataset_name);
data_dir = fullfile(gac_root, 'data', 'usps') ;

load(fullfile(data_dir, files{1}), 'data');
data = reshape(data, 256, []);
labels = reshape(repmat([0:9], size(data,2)/10, 1), [], 1);

end

function [data, labels] = load_cifar(dataset_name, files)

fprintf('loading %s\n', dataset_name);
data_dir = fullfile(gac_root, 'data', 'cifar') ;

mat_file = sprintf('%s/%s-all.mat', data_dir, dataset_name);
if exist(mat_file, 'dir')
    load(mat_file, 'data', 'labels');
else
    if isequal(lower(dataset_name), 'cifar-10')
        images = [];
        gt_labels = [];
        baseDir = sprintf('%s/cifar-10-matlab', data_dir);
        for i = 1 : 5
            load(sprintf('%s/data_batch_%d', baseDir, i), 'data', 'labels');
            images = [images; data];
            gt_labels = [gt_labels; labels];
        end
        load(sprintf('%s/test_batch', baseDir), 'data', 'labels');
        images = [images; data];
        gt_labels = [gt_labels; labels];

    elseif isequal(lower(dataset_name), 'cifar-100')
        baseDir = sprintf('%s/cifar-100-matlab', data_dir);
        load(sprintf('%s/train', baseDir), 'data', 'fine_labels');
        images = data;
        gt_labels = fine_labels;
        load(sprintf('%s/test', baseDir), 'data', 'fine_labels');
        images = [images; data];
        gt_labels = [gt_labels; fine_labels];

    else
        error('Unknown dataset type: neither full nor test')
    end

    images = single(images)' / 255.0;
    labels = single(gt_labels);
    
    param.imageSize = [32 32]; % it works also with non-square images (use the most common aspect ratio in your set)
    param.orientationsPerScale = [8 8 8 8]; % number of orientations per scale
    param.numberBlocks = 4;
    param.fc_prefilt = 4;
    
    data = zeros(512+324, size(images, 2), 'single'); %324, 944
    for i = 1 : size(images, 2)
        im = reshape(images(:, i), [32, 32, 3]);
        tmp1 = extractHOGFeatures(mean(im, 3), 'CellSize', [8, 8]);
%         tmp1 = extractLBPFeatures(mean(im, 3), 'CellSize', [8, 8]);
        tmp2 = LMgist(im, '', param);
        data(:, i) = [tmp1(:);tmp2(:)];
    end

    save(mat_file, 'data', 'labels');
end

end
