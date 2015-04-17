function [x xadd xdivide] = features_set_2(X_in, xd)

	[means vars stds] = overall_stats();
	[g_means g_vars] = group_stats();

	x = ((X_in.-means)./stds).*(X_in~=0);

	if ~exist('xd', 'var') || isempty(xd)
		xmax = max( max(x), abs(min(x)));
		xmax = max(xmax, 1e-14);
	else
		xmax=xd;
	end

	xadd = zeros(1, size(x,2));
	xdivide = xmax;
	x = bsxfun(@rdivide, x, xdivide);

end