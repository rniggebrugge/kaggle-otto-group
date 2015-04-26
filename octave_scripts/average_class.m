function avg_c = average_class()

	[x y] = get_raw_data(-1);
	n = length(y);
	non_sparse = sum(x~=0,2);
	[v idx] = sort(non_sparse, "descend");

	avg_c = [];

	for i=0:(ceil(n/100)-2);
		start = i*100+1;
		eind  = start+99;
		avg = sum(y(idx(start:eind)))/100;
		avg_c = [avg_c ; [0 avg]];
		for j=1:9
			avg = sum(y(idx(start:eind))==j)/100;
			avg_c = [avg_c ; [j avg]];
		end			
	end

end
