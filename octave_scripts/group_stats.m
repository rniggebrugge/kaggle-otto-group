function [means vars] = group_stats()
%{
	[X Y] =  get_raw_data(-1);

	means = [];
	vars = [];

	for c=1:9

		x = X(Y==c,:);
		ms = sum(x)./sum(x~=0);
		vs =  sum((bsxfun(@minus, x, ms).*(x~=0)).^2)./sum(x~=0);
		means = [means; ms ];
		vars = [vars; vs];
	end
%}
	vars  = csvread("../data_all/vars.csv");
	means = csvread("../data_all/means.csv"); 
end

