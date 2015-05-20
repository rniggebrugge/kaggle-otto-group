function x_stripped = strip_digit_matrix(x)

	minx = 7;
	maxx = 22;
	miny = 5;
	maxy = 25;

	x_stripped = [];

	for iy = miny:maxy
		for ix = minx:maxx
			x_stripped = [x_stripped x(:,ix+28*iy)];
		end
	end

end
