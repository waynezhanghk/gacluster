# GACluster -- Graph Agglomerative Clustering Library

> Version 0.1.0

### Table of Contents
* [Introduction](#introduction)
* [Citations](#citations)
* [Benchmark Results](#benchmark-results)
* [Quick start with MATLAB](#quick-start-with-matlab)
* [Changes](#changes)
* [References](#references)
* [Clustering Project](http://statfe.com/projcluster.html)
* [Homepage](http://statfe.com/)

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
[Paper](http://openaccess.thecvf.com/content_cvpr_2016/papers/Yang_Joint_Unsupervised_Learning_CVPR_2016_paper.pdf)
[Code](https://github.com/jwyang/JULE.torch)

[4] K.G. Dizaji, A. Herandi, C. Deng, W. Cai, H. Huang. Deep clustering via joint convolutional autoencoder embedding and relative entropy minimization. ICCV, 2017.
[Paper](http://openaccess.thecvf.com/content_ICCV_2017/papers/Dizaji_Deep_Clustering_via_ICCV_2017_paper.pdf)
[Code](https://github.com/herandy/DEPICT)

[5] S.A. Shah and V. Koltun. Robust continuous clustering. PNAS, 114(37), pp.9814-9819, 2017.
[Paper](https://www.pnas.org/content/114/37/9814)
[Code](https://bitbucket.org/sohilas/robust-continuous-clustering)

[6] Shah, S.A. and Koltun, V., Deep Continuous Clustering.
[Paper](https://arxiv.org/pdf/1803.01449.pdf)
[Code](https://github.com/shahsohil/DCC)

[7] X. Guo, E. Zhu, X. Liu and J. Yin. Deep embedded clustering with data augmentation. ACML, 2018.
[Paper](http://proceedings.mlr.press/v95/guo18b/guo18b.pdf)
[Code](https://github.com/XifengGuo/DEC-DA)

[8] X. Guo, L. Gao, X. Liu and J. Yin. Improved deep embedded clustering with local structure preservation. IJCAI, 2017.
[Paper](https://www.ijcai.org/proceedings/2017/0243.pdf)
[Code](https://github.com/XifengGuo/IDEC)

[9] J. Xie, R. Girshick and A. Farhadi. Unsupervised deep embedding for clustering analysis. ICML, 2016.

[10] Z. Jiang, Y. Zheng, H. Tan, B. Tang and H. Zhou. Variational deep embedding: An unsupervised and generative approach to clustering. IJCAI, 2017.
[Paper](https://www.ijcai.org/proceedings/2017/0273.pdf)
[Code](https://github.com/slim1017/VaDE)

[11] J. Chang, L. Wang, G. Meng, S. Xiang and C. Pan. Deep adaptive image clustering. ICCV, 2017.
[Paper](http://openaccess.thecvf.com/content_ICCV_2017/papers/Chang_Deep_Adaptive_Image_ICCV_2017_paper.pdf)
[Code](https://github.com/vector-1127/DAC)

[12] F. Li, H. Qiao and B. Zhang. Discriminatively boosted image clustering with fully convolutional auto-encoders. Pattern Recognition, 83, 2017.
[Paper](https://arxiv.org/pdf/1703.07980.pdf)

[13] Y. Ren, N. Wang, M. Li and Z. Xu. Deep Density-based Image Clustering. arXiv preprint arXiv:1812.04287, 2018.
[Paper](https://arxiv.org/pdf/1812.04287.pdf)

[14] K.G. Dizaji, X. Wang, C. Deng and H. Huang. Balanced Self-Paced Learning for Generative Adversarial Clustering Network. CVPR, 2019.
[Paper](http://openaccess.thecvf.com/content_CVPR_2019/papers/Ghasedi_Balanced_Self-Paced_Learning_for_Generative_Adversarial_Clustering_Network_CVPR_2019_paper.pdf)

[15] W. Hu, T. Miyato, S. Tokui, E. Matsumoto and M. Sugiyama. Learning Discrete Representations via Information Maximizing Self-Augmented Training. ICML, 2017.
[Paper](http://proceedings.mlr.press/v70/hu17b.html)
[Code](https://github.com/weihua916/imsat)

[16] U. Shaham, K. Stanton, H. Li, B. Nadler, R. Basri and Y. Kluger. SpectralNet: Spectral Clustering Using Deep Neural Networks. ICLR, 2018.
[Paper](https://openreview.net/pdf?id=HJ_aoCyRZ)
[Code](https://github.com/KlugerLab/SpectralNet)

[17] X. Guo, X. Liu, E. Zhu, X. Zhu, M. Li,X. Xu and J. Yin. Adaptive Self-paced Deep Clustering with Data Augmentation. IEEE TKDE, 2019.
[Paper](https://xifengguo.github.io/papers/TKDE19-ASPC-DA.pdf)
[Code](https://github.com/XifengGuo/ASPC-DA)

