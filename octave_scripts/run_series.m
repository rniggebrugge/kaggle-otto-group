function [theta1_return theta2_return c] = run_series(iterations, m, ...
	lambda_vector, hl_vector, feature_set_vector, th1, th2)

	max_acc = -10;

	simulation = 1;


%	xtrain_raw = csvread("fair_training.csv");
%	ytrain = xtrain_raw(:,95);
%	xtrain_raw(:,95) = [];
%	xtrain_raw(:,1) = [];
%	xtest_raw  = csvread("remaining_testing.csv");
%	ytest  = xtest_raw(:,95);
%	xtest_raw(:,95)=[];
%	xtest_raw(:,1)=[];


	for f=1:length(feature_set_vector)
		feature_set = feature_set_vector(f);


		for j=1:length(hl_vector)

			hidden_layer_size = hl_vector(j);

			for i=1:length(lambda_vector)

				 [x y] = get_raw_data(m+7000);
				 xtrain_raw = x(1:m,:);
				 ytrain = y(1:m);
				 xtest_raw  = x(m+1:end,:);
				 ytest  = y(m+1:end);

				if feature_set==1
					fprintf("feature set 1 \n");
					[xtrain xadd xdiv] = features_set_1(xtrain_raw);
					xtest = features_set_1(xtest_raw, xdiv);
				elseif feature_set==2
					fprintf("feature set 2 \n");
					[xtrain xadd xdiv] = features_set_2(xtrain_raw);
					xtest = features_set_2(xtest_raw, xdiv);
				elseif feature_set==3
					fprintf("feature set 3 \n");
					[xtrain xadd xdiv] = features_set_3(xtrain_raw);
					xtest = features_set_3(xtest_raw, xdiv);
				elseif feature_set==4
					fprintf("feature set 4 \n");
					[xtrain xadd xdiv] = features_set_4(xtrain_raw);
					xtest = features_set_4(xtest_raw, xdiv);
				elseif feature_set==5
					fprintf("feature set 5 \n");
					[xtrain xadd xdiv] = features_set_5(xtrain_raw);
					xtest = features_set_5(xtest_raw, xdiv);
				elseif feature_set==6
					fprintf("feature set 6 \n");
					[xtrain xadd xdiv] = features_set_6(xtrain_raw);
					xtest = features_set_6(xtest_raw, xadd, xdiv);
					else
					fprintf('original set\n');
					xtrain = xtrain_raw;
					xtest = xtest_raw;
					xadd=zeros(1,93);
					xdiv=ones(1,93);
				end

				size(xtrain)
				
				input_layer_size= size(xtrain,2);
				num_labels = 9;

				if ~exist('th1', 'var') || isempty(th1)
					fprintf('Random theta\n');
					initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
					initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
				else
					fprintf('Starting with given theta\n');
					initial_Theta1 = th1;
					initial_Theta2 = th2;
				end

				initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];
				options = optimset('MaxIter', iterations);


				
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

				cTheta1{simulation} = Theta1;
				cTheta2{simulation} = Theta2;
				cFeatureSet{simulation} = feature_set;
				cAdd{simulation} = xadd;
				cDiv{simulation} = xdiv;
				cAccuracy{simulation} = accuracy;

				if accuracy>max_acc
					max_acc = accuracy;
					lambda_optimal = lambda;
					hl_optimal = hidden_layer_size;
					theta1_return = Theta1;
					theta2_return = Theta2;
					optimal_feature_set= feature_set;
				end



				fprintf(['%i : Lambda: %6.2f '...
		         ''], [simulation,lambda]);
				fprintf(['Hidden layer: %6.0f '...
		         ''], hidden_layer_size);
				fprintf(['Accuracy on traning: %9.5f '...
		         ''], self_accuracy);
				fprintf(['Accuracy on test: %9.5f '...
		         ''], accuracy);
				fprintf('Feature set: %i', feature_set);
				fprintf('\n');

				simulation++;

			end

		end
	end


	fprintf(['\n\n Best result: %9.5f' ...
			'\n Lambda: %6.2f' ...
			'\n Hiddenlayer: %f' ...
			'\n Feature set: $i \n'] , [max_acc lambda_optimal hl_optimal optimal_feature_set]);
	fprintf('\n\n');

	c{1}=cTheta1;
	c{2}=cTheta2;
	c{3}=cFeatureSet;
	c{4}=cAdd;
	c{5}=cDiv;
	c{6}=cAccuracy;

end