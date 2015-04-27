function [x xadd xdivide] = features_set_7(X_in, xd)

	xadd=0;
	xdivide=1;

	nz = sum(X_in~=0,2);
	smsq = sqrt(sumsq(X_in,2));

	x = [X_in nz smsq];

end