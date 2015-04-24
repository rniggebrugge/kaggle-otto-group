function [x y] = loadTestSet()

	% Loads either the test set. Entirely.
	% Output
	% 	x
	% 	y

	data = csvread("../data_test/data_test.csv");
	y = data(:,end);
	data(:,end) = [];
	x = data;
end