# Fourier-domain image optimization and deconvolution

This repository contains the implementation of the technical report on *How to Solve Convex Image Optimization and Deconvolution Efficiently in the Fourier Domain*, available [online](https://arxiv.org/abs/1809.04187) on arXiv. 

## Authors

- [Majed El Helou](http://majedelhelou.github.io/)
- Frederike Dümbgen (frederike.duembgen@epfl.ch)
- Radhakrishna Achanta
- Sabine Süsstrunk

## Overview

This repository contains the following scripts: 

- python/Convolution.ipynb
- matlab/Convolution.m

Scripts for visualizing the convolution in space and Fourier domains. 

- python/Optimization.ipynb
- matlab/Optimization.m

Script for solving the image debluring example in Fourier domain.

- python/tools.py
- python/psf2otf.py
- matlab/sh_computation.m
- matlab/vec2mat.m

Tools for plotting and other basic operations. 

## Contribute

We are happy about contributions of any form (implementation in different programming language, improvement of existing code, etc.). Please submit a pull request if you have something to be added to the code, or send us an e-mail. 

## Acknowledgments

We would like to thank Dr.  Zahra Sadeghipoor,  Dr.  Nikolaos Arvanitopoulos and Dr.
Radhakrishna Achanta for valuable discussions and advice. The authors also thank Alexandre Boucaud for providing a python implementation of psf2otf. 


## License

This source code is provided under the MIT license. 

If you are using this code or parts of it in your own implementation, please cite it as follows:

``` 
@article{el2018fourier,
  title={Fourier-domain optimization for image processing},
  author={El Helou, Majed and D{\"u}mbgen, Frederike and Achanta, Radhakrishna and S{\"u}sstrunk, Sabine},
  journal={arXiv preprint arXiv:1809.04187},
  year={2018}
}
```
