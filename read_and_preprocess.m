function [X Y ] = read_and_preprocess(filename)
	X = csvread(filename);
	X(1,:) = []; 	%% remove first row (labels)
	X(:,1) = []; 	%% remove first column (ids)

	[X, Y] = add_features(X);
end