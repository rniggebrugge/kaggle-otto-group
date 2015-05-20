function xavg = image_average(x, reach)

	[m,n] = size(x);
	xavg = zeros(m,n);

	for dx=0:reach
		for dy=0:reach
			xshift=[x(:,1+dx+dy*28:n) zeros(m,dx+dy*28)];
			xavg = xavg + xshift;
		end
	end

	xavg = xavg / (reach+1)^2;

end