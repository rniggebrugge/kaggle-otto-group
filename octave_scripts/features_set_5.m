function [x xadd xdivide] = features_set_5(X_in, xd)

	x = X_in;

	v = sum(X_in>0);
	[i ix] = sort(v, "descend");

	x = log(1+x);
	x2 = x.^2;
	x3 = x.^3;
	x4 = x.^4;



	x = [x x2];
	x = [x x3];
	x = [x x4];

	[means vars stds] = overall_stats();
	[g_means g_vars] = group_stats();

	distances = [];
	for idx=1:9
		vector = g_means(idx,:);
		vector_vars = max(g_vars(idx,:), 1e-14);
		temp = (bsxfun(@minus, X_in, vector).*(X_in~=0)).^2;
		temp = bsxfun(@rdivide, temp, 2*vector_vars);
		dt = exp(-sum(temp,2));
		distances = [distances dt];
	end


	x = [x distances];



	for i=1:9
		for j=(i+1):10
			x = [x X_in(:,ix(i)).*X_in(:,ix(j))];
			x = [x X_in(:,ix(i))./(1+X_in(:,ix(j)))];
		end
	end

	% %% power3-products

	for i=1:10
		for j=i:10
			for k=j:10	
				x = [x X_in(:,ix(i)).*X_in(:,ix(j)).*X_in(:,ix(k))];
			end
		end
	end

	% if ~exist('xd', 'var') || isempty(xd)
	% 	xmax = max( max(x), abs(min(x)));
	% 	xmax = max(xmax, 1e-14);
	% else
	% 	xmax=xd;
	% end

	% xadd = zeros(1, size(x,2));
	% xdivide=xmax;
	% x = bsxfun(@rdivide, x, xdivide);

end