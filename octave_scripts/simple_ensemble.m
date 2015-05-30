function [m1 m2 fs preds] = simple_ensemble(x,y, ntotal)

	[m n] = size(x);
	mistakes = zeros(m,1);
	preds = [];
	fs = [];
	m1 = [];
	m2 = [];
	nmodels = 25;
	samplesize = 1000;
	colsize = 80;
	cached_m1 = [];
	cached_m2 = [];
	cached_fs = [];
	cached_preds = [];

	function create_models()
		current_n = size(cached_fs,2)+1;
		for ix=current_n:nmodels
			fprintf('Create model %i \n', ix);
			randomrows = randperm(m)(1:samplesize);
			y_subset = y(randomrows);
			randomcols = randperm(n)(1:colsize);
			x_subset = x(randomrows, randomcols);
			x_small = x(:, randomcols); 
			[th1 th2] = kaggle_run(x_subset, y_subset, 177, 5, 100);
			[p_temp h2] = predict(th1, th2, x_small);
			logloss = multiclass_logloss2(y, h2);
			accuracy = mean(p_temp ==y);
			fprintf('....logloss over test %.3f , accuracy %.3f \n',...
			 	[logloss, accuracy]);
			cached_m1 = [cached_m1 th1(:)];
			cached_m2 = [cached_m2 th2(:)];
			cached_fs = [cached_fs randomcols'];
			cached_preds = [cached_preds p_temp];
		end
	end

	function remove_models(c)			
		cached_m1(:, c)= [];
		cached_m2(:, c)= [];
		cached_fs(:, c)= [];
		cached_preds(:, c)= [];
	end



	for its = 1:ntotal
		fprintf('-----------------------------------------------------------------------------\n');
		fprintf('Now doing iteration %i out of %i \n', [its, ntotal]);
		fprintf('-----------------------------------------------------------------------------\n');
		create_models(); % fill up models till 25
		scores = mistakes' * (cached_preds==y);
		[max_score best_model] = max(scores);
		p_best = cached_preds(:, best_model);
		m1 = [m1 cached_m1(:, best_model)];
		m2 = [m2 cached_m2(:, best_model)];
		fs = [fs cached_fs(:, best_model)];
		preds = [preds p_best];
		remove_models(best_model);
		mistakes = mistakes + (y~=p_best);
		scores = mistakes' * (cached_preds==y);
		[vs ix] = sort(scores);
		remove_models(ix(1:4)); % remove worst models
	end


end