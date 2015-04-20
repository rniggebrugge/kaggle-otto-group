function c_merge = merge_ensembles(c_in)

	n = size(c_in,2);
	c_merge = c_in{1};
	index = size(c_merge{1},2)+1;
	for i=2:n
		c = c_in{ i};
		m = size(c{1},2);
		for k=1:m
			c_merge{1}{index}=c{1}{k};
			c_merge{2}{index}=c{2}{k};
			c_merge{3}{index}=c{3}{k};
			c_merge{4}{index}=c{4}{k};
			c_merge{5}{index}=c{5}{k};
			c_merge{6}{index}=c{6}{k};
			index++;
		end
	end

end

