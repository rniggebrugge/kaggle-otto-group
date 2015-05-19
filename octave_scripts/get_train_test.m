function [xtrain, ytrain, xtest, ytest] = get_train_test(perc)

	d = csvread("train_digits.csv");
	m = size(d,1);
	cutoff = round(perc*m);

	d(1,:)=[];
	y = d(:,1);
	y(y==0)=10;
	d(:,1)=[];

	xtrain = d(1:cutoff,:);
	xtest  = d(cutoff+1:end,:);
	ytrain = y(1:cutoff);
	ytest  = y(cutoff+1:end);

end


