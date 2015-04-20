####Some ideas for averaging over the ensemble

When it comes to collecting a large number of models and translate these into one, hopefully highly accurate model, 
I find the theory a bit hard for now. Let's try with the following approaches:

1. Give each model equal weight, calclulate the cumulative chance per product, per category. And calculate a majority vote
(if available) or most votes (if not).

2. Give each model a weight equal to the accuracy of the predictions, therefore the weight is per model, not per category.

3. Give each model a weight per category, based on the accuracy of successfully predicting that category. 

4. As 3., but using F1 score (2*precision*recall/(precision+recall)) per category.

5. Give each model equal weight (Theta_i, with i = 1:#models) and calculate cost (1-accuracy) for the overall model. 
  Train this model-of-models to have the optimal Theta.


#### Some ideas for improving models

Look at where the models make most mistakes (at a first glance it seems specially class 1, 3 and 4 are very hard to predict, possibly also class 7). Can we boost the model(s) by splitting the dataset before learning further?

Does the system improve by artificially adding weight to these classes? Or does a minimum score below 50% for these classes mean that with a high probability they are true? Despite other classes perhaps having higher calculated chance?
