function xout = pixel_correlate(x)

	step = 5;
	x(x~=0)=1;
	x(x==0)=-1;
	xout = [];

	for iy=0:27-step
		for ix=0:27-step
			my_col = ix+28*iy+1;
			col_dx = my_col+step;
			col_dy = my_col+step*28;
			col_dyx =col_dy+step;
			xout = [xout x(:,my_col).*x(:,col_dx) x(:,my_col).*x(:,col_dy) x(:,my_col).*x(:,col_dyx)];
		end
	end
end


