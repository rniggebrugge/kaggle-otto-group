function view_400_digits(x,y,d)
	x=x(y==d,:);
	x(x~=0)=1;
	m=size(x,1);
	showm=min(m,100);
	x=x(randperm(m)(1:showm),:);

	img=[];
	row=[];
	count=1;
	for ix=1:showm
		dig=reshape(x(ix,:),28,28);
		dig=dig';
		row=[row dig zeros(28,6)];
		% size(row)
		if count==10
			img=[img; row; zeros(6,size(row,2))];
			count=0;
			row=[];
		end
		count++;
		ix++;
	end

	imagesc(img);
end
