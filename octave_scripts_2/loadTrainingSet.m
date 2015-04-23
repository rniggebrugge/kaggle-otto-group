function [x y] = loadTrainingSet(n)

	% Loads either the training set 1 or 2. Entirely.
	% Input
	% 	n (training set, 1 (Default) or 2)
	% Output
	% 	x
	% 	y

	if n==2
		data = csvread("../data_training/data_train_2.csv");
	else
		data = csvread("../data_training/data_train_1.csv");
	end

	y = data(:,end);
	data(:,end) = [];
	x = data;
end