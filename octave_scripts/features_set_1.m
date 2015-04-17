function [x xadd xdivide] = features_set_1(X_in, xd)

	[means vars stds] = overall_stats();
	[g_means g_vars] = group_stats();

	x = ((X_in.-means)./stds).*(X_in~=0);

	distances = [];
	for idx=1:9
		vector = g_means(idx,:);
		vector_vars = max(g_vars(idx,:), 1e-14);
		temp = (bsxfun(@minus, X_in, vector).*(X_in~=0)).^2;
		temp = bsxfun(@rdivide, temp, 2*vector_vars);
		dt = exp(-sum(temp,2));
		distances = [distances dt];
	end

	x = [x x.^2];

	if ~exist('xd', 'var') || isempty(xd)
		xmax = max( max(x), abs(min(x)));
		xmax = max(xmax, 1e-14);
	else
		xmax=xd;
	end

	x= [x distances];
	xadd = zeros(1, size(x,2));
	xdivide = ones(1, size(x,2));
	xdivide(1:length(xmax))=xmax;
	x = bsxfun(@rdivide, x, xdivide);

end