function [Xtrain Xtest] = take_random_parts(filename, mtrain, mtest)
	X = csvread(filename);
	X(1,:) = []; %% remove first line (labels)
	X(:,1) = []; %% remove first column (ids)
	if mtrain == 0
		Xtrain = X;
		Xtest = [];
	else
		v = randperm(size(X,1));
		X = X(v,:);
		Xtrain = X(1:mtrain,:);
		Xtest = X((mtrain+1):(mtrain+mtest),:);
	end
end