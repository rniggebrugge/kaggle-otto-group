function [x xadd xdivide] = features_set_4(X_in, xd)

	x = X_in;
	x2 = x.^2;
	x3 = x.^3;
	x4 = x.^4;

	x = [x x2];
	x = [x x3];
	x = [x x4];

	if ~exist('xd', 'var') || isempty(xd)
		xmax = max( max(x), abs(min(x)));
		xmax = max(xmax, 1e-14);
	else
		xmax=xd;
	end

	xadd = zeros(1, size(x,2));
	xdivide=xmax;
	x = bsxfun(@rdivide, x, xdivide);

end