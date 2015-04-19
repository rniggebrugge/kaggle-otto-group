function [prediction ys] = ensemble_averaging(c, x)
	
	n_models = size(c{1},2);

	prediction = zeros(size(x,1),9);
	ys = zeros(size(x,1),n_models);

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
		ys(:,model)=p;

		prediction += h2;

	end

end 