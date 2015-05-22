function visualize_digit(x, y, idx)
	
	yv = y(idx);
	fprintf('The selected image has classification: %i \n', yv);
	img = x(idx,:);
	n = sqrt(length(img));
	img = reshape(img, n, n);
	imagesc(img');

end