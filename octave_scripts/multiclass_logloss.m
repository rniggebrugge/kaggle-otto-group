function logloss = multiclass_logloss(y, Theta1, Theta2, X)

	m = size(X);
	n = size(Theta2, 1);

	y = eye(n)(y,:);

	h1 = sigmoid([ones(m, 1) X] * Theta1');
	p = sigmoid([ones(m, 1) h1] * Theta2');


	p = bsxfun(@rdivide,p, sum(p,2));


	p(p<1e-15) = 1e-15;

	p(p>(1-1e-15)) = 1 - 1e-15;

	p = log(p);

	p

	temp = p.*y;

	sum(temp(:))

	% logloss = -1/m*sum(temp(:));
logloss=3;
end




