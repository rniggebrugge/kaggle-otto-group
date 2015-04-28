function [h2_all_train, h2_all_test] = stack_models_2(c, Xtr, Xte)
	
	% This function stacks various previously calculated/learned
	% models and trains a new model based on the the resulting 
	% prediction matrices.
	% Input:
	%	c : ensemble of models
	%	x : training set
	% Output
	%	h2_all : horizontally merged prediction matrices

	n_models = size(c{1},2);

	h2_all_train = []; %zeros(size(x,1),n_models*9);
	h2_all_test  = [];

	% stacking the models first, calculating and merging
	% all the prediction matrices h2.

	model_used_index = 1;

	for model=1:n_models

		fprintf ('Model %i of %i \n',[model, n_models]);
		theta1 = c{1}{model};
		theta2 = c{2}{model};
		feature_set = c{3}{model};
		xadd = c{4}{model};
		xdiv = c{5}{model};
		logloss = c{6}{model};

		if feature_set==8
			fprintf("feature set 8 \n");
			[xtrain xtest] = features_set_8(Xtr, Xte);
		elseif feature_set==9
			fprintf("feature set 9 \n");
			[xtrain xtest] = features_set_9(Xtr, Xte);
		end

		[p h2] = predict(theta1, theta2, xtrain);
		h2 = h2./sum(h2,2);
		h2_all_train = [h2_all h2];

		[p h2] = predict(theta1, theta2, xtest);
		h2 = h2./sum(h2,2);
		h2_all_test = [h2_all h2];

		model_used_index++;

	end

end 