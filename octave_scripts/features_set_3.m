function [x xadd xdivide] = features_set_2(X_in, xd)
function [x xadd xdivide] = features_set_2(X_in, xd)

	if ~exist('xd', 'var') || isempty(xd)
		xmax = max(X_in);
		xmax = max(xmax, 1e-14);
	else
		xmax=xd;
	end

	xadd = zeros(1, size(x,2));
	xdivide = xmax;
	x = bsxfun(@rdivide, X_in, xdivide);

end