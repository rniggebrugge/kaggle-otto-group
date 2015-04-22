function [prediction majority ys all_h2] = ensemble_averaging(c, x, TH)
	
	n_models = size(c{1},2);

	prediction = zeros(size(x,1),9);
	majority = zeros(size(x,1),9);
	ys = zeros(size(x,1),n_models);
	all_h2 = zeros(size(x,1),n_models*9);

	for model=1:n_models

		fprintf ('Model %i of %i \n',[model, n_models]);
		theta1 = c{1}{model};
		theta2 = c{2}{model};
		feature_set = c{3}{model};
		xadd = c{4}{model};
		xdiv = c{5}{model};
		if ~exist('TH', 'var') || isempty(TH)
			accuracy = c{6}{model};
		else
			accuracy = TH(model);
		end

		accuracy = 1;

		if feature_set==1
			xtest = features_set_1(x, xdiv);
		elseif feature_set==2
			xtest = features_set_2(x, xdiv);
		elseif feature_set==3
			xtest = features_set_3(x, xdiv);
		elseif feature_set==4
			xtest = features_set_4(x, xdiv);
		elseif feature_set==5
			xtest = features_set_5(x, xdiv);
		elseif feature_set==6
			xtest = features_set_6(x, xadd, xdiv);
		else
			xtest = x;
		end

		[p h2] = predict(theta1, theta2, xtest);
		h2 = h2./sum(h2,2);
		ys(:,model)=p;
		majority += eye(9)(p,:);

		prediction += accuracy*h2;

		all_h2(:,(9*(model-1)+1):(9*model))=h2;

	end
%majority = 0;
%ys = 0;
%all_h2 = 0;
end 