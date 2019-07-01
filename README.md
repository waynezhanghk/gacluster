# GACluster -- Graph Agglomerative Clustering Library

> Version 0.1.0

### Table of Contents
* [Introduction](#introduction)
* [Citations](#citations)
* [Benchmark Results](#benchmark-results)
* [Quick start with MATLAB](#quick-start-with-matlab)
* [Changes](#changes)
* [References](#references)

### Introduction

The GACluster open source library implements popular Graph Agglomerative Clustering
algorithms.

GACluster is distributed under the BSD license (see the `COPYING` file).

Two major limits of previous GAC toolbox are 1) memory cost and 2) C++ MEX implementation. This new version only includes pure MATLAB code and is optimized for memory. E.g., [5] did not report the result of GDL [1] on 70000 samples of MNIST full dataset due to huge memory cost, and it is possible to run GDL with this library if you have 24G memory. Further optimization is possbile with less readability.

### Citations

Please cite the following papers, if you find the code is helpful.

      @inproceedings{zhang2012graph,
        title={Graph degree linkage: Agglomerative clustering on a directed graph},
        author={Zhang, Wei and Wang, Xiaogang and Zhao, Deli and Tang, Xiaoou},
        booktitle={European Conference on Computer Vision},
        pages={428--441},
        year={2012}
      }

      @article{zhang2013agglomerative,
        title={Agglomerative clustering via maximum incremental path integral},
        author={Zhang, Wei and Zhao, Deli and Wang, Xiaogang},
        journal={Pattern Recognition},
        volume={46},
        number={11},
        pages={3056--3065},
        year={2013}
      }

### Benchmark Results

GDL without deep representation achieves close performance to state-of-the-art deep clustering algorithms.

Clustering performances of different algorithms in terms of NMI/ACC.

| DataSet | MNIST | MNIST-test | USPS | Fashion-MNIST |
|:-:|:-:|:-:|:-:|:-:|
| GDL [1] | 0.910/0.964 | 0.864/0.933 | 0.860/0.922 | 0.660/0.627 |
| [Deep Clustering] | | | | |
| DEC [9] | -/0.843 | -/- | -/- | -/- |
| JULE [3] | 0.913/0.964 | 0.915/0.961 | 0.913/- | -/- |
| DEPICT [4] | 0.917/0.965 | 0.915/0.963 | 0.927/0.964 | -/- |
| VaDE [10] | -/0.945 | -/- | -/- | -/- |
| DAC [11] | 0.935/0.978 | -/- | -/- | -/- |
| DBC [12] | 0.917/0.964 | -/- | 0.724/0.743 | -/- |
| ConvDEC-DA [7] |  0.960/0.985 | 0.958/0.983 | 0.962/0.987 | 0.636/0.586 |
| DDC-DA [13] | 0.941/0.969 | 0.927/ 0.970 | 0.939/0.977 |  0.661/0.609 |
| ClusterGAN [14] | 0.921/0.964 | -/- | 0.931/0.970 | -/- |

### Quick start with MATLAB

GACluster provides a number of demos for reproducing results on popular datasets. 

### Changes

- Initial public release.

### TODO


### References

[1] W. Zhang, X. Wang, D. Zhao and X. Tang. Graph degree linkage: Agglomerative clustering on a directed graph. ECCV, 2012.

[2] W. Zhang, D. Zhao and X. Wang. Agglomerative clustering via maximum incremental path integral. Pattern Recognition, 46(11), pp.3056-3065, 2013.

[3] J. Yang, D. Parikh and D. Batra. Joint unsupervised learning of deep representations and image clusters. CVPR, 2016.

[4] K.G. Dizaji, A. Herandi, C. Deng, W. Cai, H. Huang. Deep clustering via joint convolutional autoencoder embedding and relative entropy minimization. ICCV, 2017.

[5] S.A. Shah and V. Koltun. Robust continuous clustering. PNAS, 114(37), pp.9814-9819, 2017.

[6] Shah, S.A. and Koltun, V., Deep Continuous Clustering.

[7] X. Guo, E. Zhu, X. Liu and J. Yin. Deep embedded clustering with data augmentation. ACML, 2018.

[8] X. Guo, L. Gao, X. Liu and J. Yin. Improved deep embedded clustering with local structure preservation. IJCAI, 2017.

[9] J. Xie, R. Girshick and A. Farhadi. Unsupervised deep embedding for clustering analysis. ICML, 2016.

[10] Z. Jiang, Y. Zheng, H. Tan, B. Tang and H. Zhou. Variational deep embedding: An unsupervised and generative approach to clustering. IJCAI, 2017.

[11] J. Chang, L. Wang, G. Meng, S. Xiang and C. Pan. Deep adaptive image clustering. ICCV, 2017.

[12] F. Li, H. Qiao and B. Zhang. Discriminatively boosted image clustering with fully convolutional auto-encoders. Pattern Recognition, 83, 2017.

[13] Y. Ren, N. Wang, M. Li and Z. Xu. Deep Density-based Image Clustering. arXiv preprint arXiv:1812.04287, 2018.

[14] K.G. Dizaji, X. Wang, C. Deng and H. Huang. Balanced Self-Paced Learning for Generative Adversarial Clustering Network. CVPR, 2019.
