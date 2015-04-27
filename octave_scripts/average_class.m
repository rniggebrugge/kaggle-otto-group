function avg_c = average_class()

	[x y] = get_raw_data(-1);
	n = length(y);
	ndim = ceil(n/100)-2;

	non_sparse = sum(x~=0,2);
	tots = sum(x,2);
	totssq = sumsq(x,2);

	[v idx] = sort(non_sparse, "descend");
	[v idx2] = sort(tots, "descend");
	[v idx3] = sort(totssq, "descend");

	avg_c = zeros(10,ndim,3);

	for i=0:ndim
		start = i*100+1;
		eind  = start+99;
		avg = sum(y(idx(start:eind)))/100;
		avg_c(10,i+1,1) = avg;
		avg = sum(y(idx2(start:eind)))/100;
		avg_c(10,i+1,2) = avg;
		avg = sum(y(idx3(start:eind)))/100;
		avg_c(10,i+1,3) = avg;

		for j=1:9
			avg = sum(y(idx(start:eind))==j)/100;
			avg_c(j, i+1, 1) = avg;
			avg = sum(y(idx2(start:eind))==j)/100;
			avg_c(j, i+1, 2) = avg;
			avg = sum(y(idx3(start:eind))==j)/100;
			avg_c(j, i+1, 3) = avg;
		end			
	end

end
