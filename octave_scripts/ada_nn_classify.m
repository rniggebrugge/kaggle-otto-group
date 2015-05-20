function [pred, h2] = ada_nn_classify(...
	x, ...
	model_theta_1, ...
	model_theta_2, ...
	fs, ...
	alpha)

% input X, Theta1, Theta2, Featuresets, Alphas

	m    = size(x,1);
	n    = length(alpha);

	h2   = zeros(m,10);
	pred = [];


	for ix = 1:n

		theta1 = model_theta_1{ix};
		theta2 = model_theta_2{ix};
		feats  = fs(ix,:);
		[p h] = predict(theta1, theta2, x(:,feats));
		pred = [pred p];
		% h     = h./sum(h,2);
		h2    = h2 + alpha(ix)*h;

	end

	h2 = h2./sum(h2,2);
	% [dummy, pred] = max(h2, [], 2);

end