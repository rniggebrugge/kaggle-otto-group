function [xtrain, ytrain, xvalid, yvalid, xtest, ytest] = get_tvt(perc1, perc2)

	d = csvread("train_digits.csv");
	m = size(d,1);
	cutoff1 = round(perc1*m);
	cutoff2 = round((perc1+perc2)*m);

	d(1,:)=[];
	y = d(:,1);
	y(y==0)=10;
	d(:,1)=[];

	xtrain = d(1:cutoff1,:);
	xvalid  = d(cutoff1+1:cutoff2,:);
	xtest = d(cutoff2+1:end,:);
	ytrain = y(1:cutoff1);
	yvalid  = y(cutoff1+1:cutoff2);
	ytest = y(cutoff2+1:end);

end
