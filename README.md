# A Soft-Margin Neutrosophic-Logic Bio-Inspired WASD Neural Network for Human Activity Recognition in Assistive Technologies and Pattern Classification

Implementation of a bio-inspired weights-and-structure-determination (WASD) 3-layer feed-forward neural network model, equipped with a soft-margin three-membership neutrosophic logic controller (NLC) and trained via the Beetle Antennae Search (BAS) metaheuristic algorithm, called BSW.

The purpose of this package is to present applications on assistive Human Activity Recognition (HAR) for physical disabilities as the primary evaluation domain (using UCI HAR dataset retrieved from https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones), alongside financial trend pattern classification (Bank of America and Tesla stock price series) as a secondary cross-domain validation task.

The main article used is the following:
* R.T. Alqahtani, T.E. Simos, S.D. Mourtas and V.N. Katsikis, "A Soft-Margin Neutrosophic-Logic Bio-Inspired WASD Neural Network for Human Activity Recognition in Assistive Technologies and Pattern Classification", 2026.

# M-files Description
* Main_WASD.m: the main function executing the pipeline across all benchmark datasets
* problem.m: input feature sets loading and binary classification target preprocessing
* BSW.m: function for finding the optimal power activation indices, the internal scaling bias vector profiles via BAS, and the algebraic output weights via WDD for the BSW network
* SW.m: baseline Swish-activated WASD neural network model, retrieved from https://doi.org/10.1051/itmconf/20257205006
* KNBayes_CL.m: baseline Kernel Naive Bayes classifier model
* FineTree_CL.m: baseline Fine Decision Tree classifier model
* LinearSVM_CL.m: baseline Linear Support Vector Machine classifier model
* EBT_CL.m: baseline Ensemble Bagged Trees classifier model
* FineKNN_CL.m: baseline Fine K-Nearest Neighbors classifier model
* Normalization.m: feature normalization function scaling input data into the stable boundary interval [-0.5, -0.25]
* Qmatrix.m: function for calculating the activation matrix K of the BSW network
* predictN.m: function for binary classification testing with the BSW network via the Neutrosophic Logic Controller
* error_pred.m: function for calculating performance statistics (MAE, Precision, Recall, Accuracy, F-score)
* mcnemar_test.m: function for executing McNemar's paired statistical hypothesis test at a 5% significance level
* NLC.fis: Mamdani-style neutrosophic inference system configuration file
* Problem_figures.m: function for generating the experimental tracking and comparative figures

# Installation
* Unzip the downloaded repository and copy the BSW directory to a location, e.g., `/my-directory/BSW/`
* Open MATLAB and navigate to `/my-directory/BSW/` in the command prompt
* Run `Main_BSW` (MATLAB)

# Results
After running the `Main_WASD.m` file, the package outputs are the following:
* The optimal structural hidden-layer configuration, power activation indices $N$, and localized bias profiles $b$.
* The model's classification metrics (Precision, Recall, Accuracy, F-score) and confusion matrices across the testing sets.
* Statistical significance evaluation results via McNemar's paired test comparing BSW against baseline classifiers.
* Graphical illustrations displaying structural loss convergence paths, bias search profiles, and comparative decision boundaries.

# Environment
The BSW package has been tested in MATLAB 2025a on Windows 10 64-bit.
To ensure 100% experimental reproducibility across all evaluations, the random number generator is initialized using `rng(0)`.
