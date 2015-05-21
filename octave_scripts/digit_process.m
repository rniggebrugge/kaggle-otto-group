function xout = digit_process(x)

	xtemp = x./max(x')';
	xout = [];

	m = size(x,1);
	n = sqrt(size(x,2));

	for ix=1:n-5
		for iy=1:n-5
			temp = zeros(m,1);
			for dx=0:4
				for dy=0:4
					temp = temp + xtemp(:,ix+dx+(iy+dy)*28);
				end
			end
			xout = [xout temp];
		end
	end



end