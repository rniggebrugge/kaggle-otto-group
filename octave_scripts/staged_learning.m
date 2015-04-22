function [prediction h2] = staged_learning(...
	iterations, lambdas, hls, xtrain, ytrain, xtest, ytest)

	xtrain = log(1+xtrain);
	xtest = log(1+xtest);

	stages = min([length(lambdas) length(hls) ]);

	for stage=1:stages
		lambda = lambdas(stage);
		hidden_layer_size = hls(stage);
		num_labels = 9;
	
		input_layer_size= size(xtrain,2);

		initial_Theta1 = randInitializeWeights(...
			input_layer_size, hidden_layer_size);
		initial_Theta2 = randInitializeWeights(...
			hidden_layer_size, num_labels);

		initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];
		options = optimset('MaxIter', iterations);
				
		costFunction = @(p) nnCostFunction(p, ...
                        input_layer_size, ...
                        hidden_layer_size, ...
                        num_labels, xtrain, ytrain, lambda);

		[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

		Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
			                 hidden_layer_size, (input_layer_size + 1));

		Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
			                 num_labels, (hidden_layer_size + 1));

		pred_self = predict(Theta1, Theta2, xtrain);
		xtrain = [xtrain pred_self];
		[prediction h2] = predict(Theta1, Theta2, xtest);
		xtest = [xtest prediction];

		if ~exist('ytest', 'var') || isempty(ytest)
			fprintf('Stage %i finished.\n', stage);
		else
			logloss = multiclass_logloss2(ytest, h2);
			fprintf('Stage %i, logloss: %10.4f. \n', [stage logloss]);
		end
	end

end




