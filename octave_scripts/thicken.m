function xthick = thicken(x)

	[m,n] = size(x);
	xthick = x;
	xthick(xthick~=0)=1;

	xleft = [xthick(:, 2:n) zeros(m,1)];
	xright = [zeros(m,1) xthick(:, 1:n-1) ];
	xup = [xthick(:, 29:n) zeros(m,28)];
	xdown = [zeros(m,28) xthick(:,1:n-28)];

	xthick = xthick + xleft + xright + xup + xdown;

	xthick(xthick~=0)=1;

end