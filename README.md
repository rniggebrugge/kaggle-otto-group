###Some ideas for averaging over the ensemble

When it comes to collecting a large number of models and translate these into one, hopefully highly accurate model, 
I find the theory a bit hard for now. Let's try with the following approaches:

1. Give each model equal weight, calclulate the cumulative chance per product, per category. And calculate a majority vote
(if available) or most votes (if not).

2. Give each model a weight equal to the accuracy of the predictions, therefore the weight is per model, not per category.

3. Give each model a weight per category, based on the accuracy of successfully predicting that category. 

4. As 3., but using F1 score (2*precision*recall/(precision+recall)) per category.
