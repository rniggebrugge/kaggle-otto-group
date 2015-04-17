function [x y] = get_raw_data(m)

	ds = csvread("../data/train.csv");
	ds(1,:)=[];
	ds(:,1)=[];

	mmax=size(ds,1);
	if m>mmax
		m=mmax;
	end

	if m<0
		m=mmax;
	end
	
	v = randperm(mmax);
	ds = ds(v,:);
	x = ds(1:m,:);
	y = x(:, end);
	x(:,end) = [];

end