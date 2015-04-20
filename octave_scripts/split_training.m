function [train test] = split_training()

	ds = csvread("../data/train.csv");
	ds(1,:)= [];
	[m n]=size(ds);
	smallest_set=m;

	train = [];
	test  = [];

	for i=1:9
		s = sum(ds(:,95)==i)
		if s<smallest_set
		 smallest_set=s;
		end
	end

	m_per_class = round(0.9*smallest_set);

	for i=1:9
		subset=ds(ds(:,95)==i,:);
		m = size(subset,1);
		v = randperm(m);
		train = [train; subset(1:m_per_class,:)];
		test  = [test;  subset(m_per_class+1:m,:)];
	end

end