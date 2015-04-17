function p = values_based_prediction(x)

	% c = feature_values();
	load c.mat;
	m = size(x,1);
	p = zeros(m,9);


	for idx = 1:m
		fprintf('Sample %i \n', idx);
		sample = x(idx,:);
		for fn = 1:93
			value = sample(fn);
			if value>0
				temp = c{fn};
				temp = temp(temp(:,1)==value,:);
				p(idx,:) = p(idx, : ) + temp(2:end);
			end
		end
	end

end


