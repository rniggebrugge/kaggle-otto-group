function [x y] = rotate_matrix()

	x = csvread("train_digits.csv");
	x(1,:)=[];
	y = x(:,1);
	y(y==0)=10;
	x(:,1)=[];

#{	
	n=size(x,1);
	for idx=1:n
		m = reshape( x(idx,:),28,28);
		temp = rot9(m,1);
		x = [x; temp(:)'];
		temp = rot90(m,-1);
		x = [x; temp(:)'];
		y = [y; y(idx)];
		y = [y; y(idx)];
	end
#}


end
