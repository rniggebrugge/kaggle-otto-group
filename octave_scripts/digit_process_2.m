function xout = digit_process_2(x)

	% spliting the image in 49 (7x7) blocks
	% and calculate average number of pixels per block
	% or average value per block

	[m n] = size(x);
	xout = x;

	for blocky=0:6
		for blockx=0:6
			temp = zeros(m,1);
			for stepx=0:3
				for stepy=0:3
					pix=blockx*7+stepx+(blocky+stepy)*28 +1;
					temp = temp + x(:,pix);
				end
			end
			xout=[xout temp/16];
		end
	end

end