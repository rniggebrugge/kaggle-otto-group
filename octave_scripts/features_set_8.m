function [xtr, xte] = features_set_8(Xtrain, Xtest )

	xtot = [Xtrain; Xtest];
	m =size(Xtrain,1);
	xnew = [];

	for i=1:93
		t = xtot(:,i);
		[a, b, c] = unique(t);
		xnew = [xnew c];
	end

	xnew(xnew==1)=0;
	
	xtr = xnew(1:m,:);
	xte = xnew(m+1:end,:);

end