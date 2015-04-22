function logloss = multiclass_logloss2(y, p)

	m = length(y);
	n = size(p, 2);

	y = eye(n)(y,:);

	p = bsxfun(@rdivide,p, sum(p,2));


	p(p<1e-15) = 1e-15;

	p(p>(1-1e-15)) = 1 - 1e-15;

	p = log(p);

	temp = p.*y;

	logloss = -1/m*sum(temp(:));

end




