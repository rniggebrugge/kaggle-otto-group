function [x y] = rotate_matrix()

	x = csvread("train_digits.csv");
	x(1,:)=[];
	y = x(:,1);
	y(y==0)=10;
	x(:,1)=[];


end
