function [X Y Xmax ] = read_and_preprocess(filename)
	X = csvread(filename);
	X(1,:) = []; 	%% remove first row (labels)
	Y = X(:,end);	%% Y := class
	X(:,end) = []; 	%% remove last colum (class)
	X(:,1) = []; 	%% remove first column (ids)
	[m n] = size(X);

	%% squared values for all features
	X2 = X.^2;

	%% get the number of non-zero values, and sort to be able
	%% to create new features based on the most non-zero features.
	%% my idea is that these probably have the highest predictive
	%% power

	v = sum(X>0);
	[i ix] = sort(v, "descend");

	%% power2-products (except quadratic)

	Xpower2 = zeros(m, 90);
	for row=1:m
		column = 1;
		for i=1:9
			for j=(i+1):10
				Xpower2(row, column) = X(row,ix(i))*X(row,ix(j));
				column = column+1;
			end
		end
	end

	%% power3-products

	Xpower3 = zeros(m, 64);
	for row=1:m
		column = 1;
		for i=1:4
			for j=1:4
				for k=1:4
					Xpower3(row, column) = X(row,ix(i))*X(row,ix(j))*X(row,ix(k));
					column = column+1;
				end
			end
		end
	end

	X = [X X2 Xpower2 Xpower3];
	Xmax = max(X);
	X = X./Xmax;

end