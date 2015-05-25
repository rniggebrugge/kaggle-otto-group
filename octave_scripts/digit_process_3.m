function [xout perm] = digit_process_3(xin, perm)
	temp = xin;
	% temp(temp~=0)=1;
	[m n] = size(xin);
	if ~exist('perm', 'var') || isempty(perm)
		perm = zeros(n,4);
		perm(:,1)= randperm(n);
		perm(:,2)= randperm(n);
		perm(:,3)= randperm(n);
		perm(:,4)= randperm(n);
	end
	
	xout = xin(:,perm(:,1)) + xin(:,perm(:,2)) + xin(:,perm(:,3)) + xin(:,perm(:,4));	
end



