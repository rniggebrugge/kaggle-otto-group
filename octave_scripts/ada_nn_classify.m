function [pred, h2, progress, count] = ada_nn_classify(...
	x,y, ...
	model_theta_1, ...
	model_theta_2, ...
	fs, ...
	alpha)

% input X, Theta1, Theta2, Featuresets, Alphas

	m    = size(x,1);
	n    = length(alpha);

	h2   = zeros(m,10);
	pred = [];
	progress = [];
	count = zeros(m,10);

	for ix = 1:n
		theta1 = model_theta_1{ix};
		theta2 = model_theta_2{ix};
		feats  = fs(ix,:);
		[p h] = predict(theta1, theta2, x(:,feats));
		pred = [pred p];
		% h     = h./sum(h,2);
		h2    = h2 + h; % alpha(ix)*h;
		[dd p_] = max(h2, [], 2);
		count += eye(10)(p,:);
		progress=[progress mean(p_==y)];
	end

	h2 = h2./sum(h2,2);
	% [dummy, pred] = max(h2, [], 2);
end
