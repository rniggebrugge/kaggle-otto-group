function visualize_digit(x, y, idx)
	
	yv = y(idx);
	fprintf('The selected image has classification: %i \n', yv);
	img = x(idx,:);
	img = reshape(img, 28, 28);
	imagesc(img');

end