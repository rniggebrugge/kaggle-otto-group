function f1_tot = f1score(y, ypred)

	tp_tot = 0;
	fn_tot = 0;
	fp_tot = 0;
	f1_tot = zeros(9,1);

	for i=1:9
		tp = sum(ypred(y==i)==i);
		fp = sum(ypred(y~=i)==i);
		fn = sum(ypred(y==i)~=i);

		precision = tp/(tp+fp);
		recall = tp/(tp+fn);

		f1 = 2*precision*recall/(precision+recall);
		% f1 = f1*length(y==i)/length(y);
		fprintf('Class %i, f1-score %.2f \n', [i, f1]);
		f1_tot(i)=f1;

	end

end




