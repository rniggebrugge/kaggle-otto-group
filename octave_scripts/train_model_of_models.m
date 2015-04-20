function [prediction majority ys] = train_model_of_models(c, x, y)
	
	n_models = size(c{1},2);

	prediction = zeros(size(x,1),9);
	majority = zeros(size(x,1),9);
	ys = zeros(size(x,1),n_models);


	%% Calculate the h2 probability matrix for each model.

	for model=1:n_models

		theta1 = c{1}{model};
		theta2 = c{2}{model};
		feature_set = c{3}{model};
		xadd = c{4}{model};
		xdiv = c{5}{model};
		accuracy = c{6}{model};

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

		h2{model} = h2./sum(h2,2);

	end

	% With all models used for prediction, try to find the optimal mix
	% Initiate to all be equal.
	Theta = ones(n_models,1)/n_models;

end 