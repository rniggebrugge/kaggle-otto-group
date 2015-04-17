function [theta1_return theta2_return xtrain xadd xdiv] = run_series(iterations, m, ...
	lambda_vector, hl_vector, feature_set)

	[x y] = get_raw_data(m+7000);
	xtrain = x(1:m,:);
	ytrain = y(1:m);
	xtest  = x(m+1:end,:);
	ytest  = y(m+1:end);
	max_acc = -10;

	if feature_set==1
		[xtrain xadd xdiv] = features_set_1(xtrain);
		xtest = features_set_1(xtest, xdiv);
		xtest = features_set_1(xtest, xdiv);
	elseif feature_set==2
		[xtrain xadd xdiv] = features_set_2(xtrain);
		xtest = features_set_2(xtest, xdiv);
	else
		fprintf('Not yet implemented');
	end

	size(xtrain)

	input_layer_size= size(xtrain,2);
	num_labels = 9;


	for j=1:length(hl_vector)

		hidden_layer_size = hl_vector(j);

		initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
		initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

		initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];
		options = optimset('MaxIter', iterations);

		for i=1:length(lambda_vector)
			
			lambda = lambda_vector(i);
		
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
			self_accuracy = mean(pred_self==ytrain);
			pred = predict(Theta1, Theta2, xtest);
			accuracy = mean(pred==ytest);

			if accuracy>max_acc
				max_acc = accuracy;
				lambda_optimal = lambda;
				hl_optimal = hidden_layer_size;
				theta1_return = Theta1;
				theta2_return = Theta2;
			end



			fprintf(['Lambda: %6.2f '...
	         ''], lambda);
			fprintf(['Hidden layer: %6.0f '...
	         ''], hidden_layer_size);
			fprintf(['Accuracy on traning: %9.5f '...
	         ''], self_accuracy);
			fprintf(['Accuracy on test: %9.5f '...
	         ''], accuracy);
			fprintf('\n');
		end

	end


	fprintf(['\n\n Best result: %9.5f' ...
			'\n Lambda: %6.2f' ...
			'\n Hiddenlayer: %f'] , [max_acc lambda_optimal hl_optimal]);
	fprintf('\n\n');



end