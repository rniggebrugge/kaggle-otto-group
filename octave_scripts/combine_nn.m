function [combi, predictions] = combine_nn(xtr, ytr, xte, yte)

	combi = [];
	predictions = yte;

	for l = 1:1
		sizes = randperm(30)+17;
		for l2 = 1:length(sizes)
			[th1 th2] = kaggle_run(xtr, ytr, sizes(l2), 2, 50);
			pred = predict(th1, th2, xte);
			combi = [combi pred==yte];
			predictions = [predictions pred];
		end
	end

	combi = [combi sum(combi,2)];
end



