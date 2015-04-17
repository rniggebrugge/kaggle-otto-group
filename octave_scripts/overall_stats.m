function [means vars stds] = overall_stats()

	x =  get_raw_data(-1);

	means = sum(x)./sum(x~=0);

	vars =  sum((bsxfun(@minus, x, means).*(x~=0)).^2)./sum(x~=0);

	stds = sqrt(vars);

end