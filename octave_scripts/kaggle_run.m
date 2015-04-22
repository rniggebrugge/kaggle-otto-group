function [Theta1 Theta2] = ...
	kaggle_run(x, y, hidden_layer_size, lambda, iterations, th1, th2)

	if ~exist('lambda', 'var') || isempty(lambda)
	    lambda = 0.0;
	end

	if ~exist('hidden_layer_size', 'var') || isempty(hidden_layer_size)
	    hidden_layer_size = 25;
	end

	size(x)

	input_layer_size = size(x,2); 
	num_labels = 9; 

	if ~exist('th1', 'var') || isempty(th1)
		initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
		initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
	else
		initial_Theta1 = th1;
		initial_Theta2 = th2;
	end

	initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

	options = optimset('MaxIter', iterations);
	
	costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, x, y, lambda);

	[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

	Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

	Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));


	[pred_self h2] = predict(Theta1, Theta2, x);

	self_accuracy = mean(pred_self==y);
	logloss = multiclass_logloss2(y, h2);
	fprintf('Accuracy %10.4f, logloss: %10.4f. \n', [self_accuracy logloss]);

end
