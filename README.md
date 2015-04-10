# Kaggle: Otto Group Product Classification Challenge

https://www.kaggle.com/c/otto-group-product-classification-challenge

### Preprocessing

1. Remove Class from file to make target numeric:
   sed -i 's/Class\_//g' train.csv
2. Reading file "train.csv" as X=csvread("train.csv")
3. Remove first row (labels): X(1,:)=[];
4. Set Y to be the target: Y = X(:,95);
5. Remove last column (target): X(:,95)=[];
6. Calculuate mean and range of features. This is for normalisation and
   the same values should be applied to test dataset (not the mean and 
   range of that set!!!)
      Xmean = mean(X);
      Xrange = range(X);
7. Normalize X: Xnorm = (X - Xmean)./Xrange;
8. Undo normalization of first column (ids), this column should anyway 
   later be ignored, it does/should not contribute:
      Xnorm(:,1)=X(:,1);
   Alternatively: remove first column in step 3.
9. Save X and Y: save xydata.mat X Y 
   Do not save the Xnorm, Xrange and Xmean, the file will be too large
   github.
10. Alternative approach (I tend to prefer actually):
       Xmax = max(X);
       Xnorm = X./Xmax;
    This since all the features are ranging from 0 to 10, 100, 350 etc.
    And there are many 0 values. It just seems to make more sense....



