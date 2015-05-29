function xout = digit_shape(xin)

	xin(xin~=0)=1;
	m = size(xin,1);

	activated_h = zeros(m,1);
	activated_v = zeros(m,1);
	all_h = [];
	all_v = [];
	sum_h = [];
	sum_v = [];

	for y=1:28
		temp_h = zeros(m,1);
		temp_v = zeros(m,1);
		temp_sum_h = zeros(m,1);
		temp_sum_v = zeros(m,1);
		for x=1:28
			colnumber_h = x+(y-1)*28;
			column_h = xin(:,colnumber_h);
			temp_sum_h += column_h;
			temp_h = temp_h + xor(activated_h, column_h);
			activated_h = column_h;
			colnumber_v = y+(x-1)*28;
			column_v = xin(:,colnumber_v);
			temp_sum_v += column_v;
			temp_v = temp_v + xor(activated_v, column_v);
			activated_v = column_v;
		end
		all_h=[all_h temp_h/2 ];
		all_v=[all_v temp_v/2 ];
		sum_h=[sum_h temp_sum_h];
		sum_v=[sum_v temp_sum_v];
	end


	% for ix=1:m
	% 	v = all_h(ix,:);
	% 	first = find(v,1,'first');
	% 	v = v(first:end);
	% 	all_h(ix,:) = [v zeros(1,first-1)];
	% 	v = all_v(ix,:);
	% 	first = find(v,1,'first');
	% 	v = v(first:end);
	% 	all_v(ix,:) = [v zeros(1,first-1)];
	% end

	xout=[all_h all_v sum_h sum_v];
end


