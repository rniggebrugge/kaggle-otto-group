function [prediction cl] = classify_by_distance(train, Ytrain, test, Ytest)

	mtrain = size(train,1);
	m = size(test,1);
	prediction = zeros(m,9);

	Xmax = max(train);
	train = train./Xmax;
	test = test./Xmax;

	non_zero = sum(train~=0,2)/93;

	for i=1:m
		fprintf('%f', i);
		vector = test(i,:);

		% distance calculations
		dt = train.-vector;
		dt = dt.^2;
		dt = sum(dt,2);
		% max_distance = min(dt)*1.6;
		[distances idx] = sort(dt);
		j=1;
		while(j<100)
			prediction(i,Ytrain(idx(j))) +=  1; %+non_zero(idx(j)) / distances(j) ; 
			% prediction(i,Ytrain(idx(mtrain-j+1))) -= 1/j;
			j++;
		end
	end

%	prediction = prediction./count;

	[dummy cl] = max(prediction, [], 2);

	accuracy = mean(cl==Ytest);
	logloss = multiclass_logloss2(Ytest, prediction);
	fprintf('Accuracy %10.4f, logloss: %10.4f. \n', [accuracy logloss]);

end