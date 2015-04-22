function frequency_table = frequency_matrix(y)
	m = size(y,1);
	frequency_table = zeros(m,9);

	for i=1:9
		frequency_table(:,i) = sum (y==i,2);
	end
end