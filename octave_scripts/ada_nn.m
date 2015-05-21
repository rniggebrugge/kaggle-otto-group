function [model_theta_1, model_theta_2, fs, alpha] = ada_nn( ...
	x, y, 
	lambda, ...
	iterations, ...
	samplesize, ...
	ntrainings, ...
	nfeatures)

	% input: x, y, lambda, iterations, samplesize, 
	% ntrainings, nfeatures


	model_theta_1 = {};
	model_theta_2 = {};
	fs = [];
	alpha = [];

	[m, n] = size(x);
	D = ones(m,1)/m;

	for its = 1:iterations
		randomrows = randperm(m)(1:samplesize);
		y_subset = y(randomrows);
		minError = inf;
		for mdls = 1:ntrainings
			randomcols = randperm(n)(1:nfeatures);
			x_subset = x(randomrows, randomcols);
			x_small = x(:, randomcols); % for testing
			% here is some work to be done. random hiddenlayersize
			hidden_layer = 60 + randi(24)*5;
			fprintf('\n>> Iteration %i of %i , ', [its, iterations]);
			fprintf('model %i of %i , ', [mdls, ntrainings]);
			fprintf(' :: Hidden layer size %i\n', hidden_layer);
			[th1 th2] = kaggle_run(x_subset, y_subset, hidden_layer, lambda, 150);
			[pred h2] = predict(th1, th2, x_small);
			logloss = multiclass_logloss2(y, h2);
			accuracy = mean(pred ==y);
			Err = 1 - (pred == y);
			Err(randomrows) = 0;  % ignore training set!
			weightedError = D' * Err;
			fprintf('....logloss over test %.3f , accuracy %.3f , error %.3f \n',...
			 	[logloss, accuracy, weightedError]);
			if weightedError < minError
				minError = weightedError;
				bestth1=th1;
				bestth2=th2;
				bestset=randomcols;
				bestprediction = pred;
				bestfeats = randomcols;
			end

		end
		% So now we have the best model for this iteration
		model_theta_1{its} = bestth1;
		model_theta_2{its} = bestth2;
		fs = [fs; bestfeats];
		AL = log((1-minError)/max(minError,1e-16)) + log(9);
		alpha = [alpha AL];
		expon = -((bestprediction==y)*2-1)*AL;
		D = D.*exp(expon);
		D = D/sum(D);
	end

end
