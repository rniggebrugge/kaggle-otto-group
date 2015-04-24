function h2_all = stack_models(c, x)
	
	% This function stacks various previously calculated/learned
	% models and trains a new model based on the the resulting 
	% prediction matrices.
	% Input:
	%	c : ensemble of models
	%	x : training set
	% Output
	%	h2_all : horizontally merged prediction matrices

	n_models = size(c{1},2);

	h2_all = []; %zeros(size(x,1),n_models*9);

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

		if logloss<1.6
			if feature_set==1
				xtest = features_set_1(x, xdiv);
			elseif feature_set==2
				xtest = features_set_2(x, xdiv);
			elseif feature_set==3
				xtest = features_set_3(x, xdiv);
			elseif feature_set==4
				xtest = features_set_4(x, xdiv);
			elseif feature_set==5
				xtest = features_set_5(x, xdiv);
			elseif feature_set==6
				xtest = features_set_6(x, xadd, xdiv);
			else
				xtest = x;
			end
			[p h2] = predict(theta1, theta2, xtest);
			h2 = h2./sum(h2,2);
			% h2_all(:,(9*(model_used_index-1)+1):(9*model_used_index))=h2;
			h2_all = [h2_all h2];
			model_used_index++;
		end

	end

end 