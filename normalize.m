function [Xresult Xmax] = normalize(X)
	Xmax = max(X);
	Xresult = X./Xmax;
end