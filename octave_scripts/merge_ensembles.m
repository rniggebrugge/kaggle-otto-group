function c_merge = merge_ensembles(c_in)

	n = size(c_in);
	c_merge = c_in(1);
	index = size(c_merge,2)+1;
	for i=2:n
		fprintf('%i', i);
		c = c_in(i);
		m = size(c{1},2);
		c_merge{1}{index}=c{1};
		c_merge{2}{index}=c{2};
		c_merge{3}{index}=c{3};
		c_merge{4}{index}=c{4};
		c_merge{5}{index}=c{5};
		c_merge{6}{index}=c{6};
		index++;
	end

end

