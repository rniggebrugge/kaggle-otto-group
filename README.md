# Kaggle: Otto Group Product Classification Challenge

https://www.kaggle.com/c/otto-group-product-classification-challenge

### Preprocessing

1. Remove Class from file to make target numeric:
   sed -i 's/Class\_//g' train.csv
2. Reading file "train.csv" as X=csvread("train.csv")
3. Remove first row (labels): X(1,:)=[];
4. Set Y to be the target: Y = X(:,95);
5. Remove last column (target): X(:,95)=[];


