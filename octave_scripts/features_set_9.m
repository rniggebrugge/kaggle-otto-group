function [xtr, xte] = features_set_9(Xtrain, Xtest )

	m =size(Xtrain,1);
	mt = size(Xtest,1);
	xnew = [];

	for i=1:10
		fn = sum(Xtrain(:,(i-1)*10+1:min(93,i*10)),2);
		fnt = sum(Xtest(:,(i-1)*10+1:min(93,i*10)),2);
		Xtrain = [Xtrain ceil(fn/10)];
		Xtest = [Xtest ceil(fnt/10)];
	end

	xtot = [Xtrain; Xtest];

	for i=1:size(Xtrain,2)
		t = xtot(:,i);
		[a, b, c] = unique(t);
		xnew = [xnew c];
	end

	xnew(xnew==1)=0;
	
	xtr = xnew(1:m,:);
	xte = xnew(m+1:end,:);

end