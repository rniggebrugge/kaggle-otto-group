function Theta = train_model_of_models(all_h2, x, y)
	
	n_models = size(all_h2,2)/9;
	m = length(y);
	sigma = 0.01;

	Theta = ones(n_models,1);

	%% Calculate the h2 probability matrix for each model.

	for model=1:n_models

%		theta1 = c{1}{model};
%		theta2 = c{2}{model};
%		feature_set = c{3}{model};
%		xadd = c{4}{model};
%		xdiv = c{5}{model};
%		accuracy = c{6}{model};
%
%		if feature_set==1
%			xtest = features_set_1(x, xdiv);
%		elseif feature_set==2
%			xtest = features_set_2(x, xdiv);
%		elseif feature_set==3
%			xtest = features_set_3(x, xdiv);
%		elseif feature_set==4
%			xtest = features_set_4(x, xdiv);
%		elseif feature_set==5
%			xtest = features_set_5(x, xdiv);
%		elseif feature_set==6
%			xtest = features_set_6(x, xadd, xdiv);
%		else
%			xtest = x;
%		end
%
%		[p h2] = predict(theta1, theta2, xtest);

		h2{model} = all_h2(:,((model-1)*9+1):(model*9));
	end

	% With all models used for prediction, try to find the optimal mix
	% Initiate to all be equal.

	function a = get_accuracy(th)
		predict = zeros(m, 9);
		for model=1:n_models
			predict+=th(model)*h2{model};
		end
		[i yp] = max(predict,[],2);
		a = mean(yp==y);
	end


	accuracy = get_accuracy(Theta);
	for iterations=1:400
		v = randperm(n_models);
		for i=1:n_models
			th_min = Theta;
			th_min(v(i)) -= sigma;
			th_plus = Theta;
			th_plus(v(i)) += sigma;
			[du idx] = max([get_accuracy(th_min)  get_accuracy(th_plus) accuracy],[],2);
			if idx==1
				Theta = th_min;
				fprintf('d ');
			elseif idx==2
				Theta = th_plus;
				fprintf('u ');
			end
			accuracy =du;
		end
		fprintf('\nIteration %i , accuracy %.3f \n', [iterations accuracy]);

	end


end 