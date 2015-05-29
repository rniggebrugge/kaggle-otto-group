function h = rapid_fire(x,y, xt,yt)

     iterations = 50;
     x(x~=0)=1;
     xt(xt~=0)=1;

     [m n] = size(x);
     h = zeros(size(xt,1), 10);
     max_acc = 0;
     progress = [];
     D = ones(size(xt,1),1);
     D = D/sum(D);

     for ix=1:iterations
     	fprintf('Iterations %i / %i \n', [ix, iterations]);
     	rr = randperm(m)(1:500);
     	rc = randperm(n)(1:70);
     	x_ = x(rr,rc);
     	y_ = y(rr);
     	xt_= xt(:,rc);
     	[th1 th2] = kaggle_run(x_, y_, 55, 0, 100);
     	[pred h_] = predict(th1, th2, xt_);
     	weighted_error = D' * (pred~=yt);
     	alpha = 0.5*log((1-weighted_error)/max([1e-16 weighted_error]));
     	expon = alpha*((pred~=yt)*2-1);
     	D = D.*exp(expon);
     	D = D/sum(D);
        acc = mean(pred==yt);
        if acc>max_acc
        	max_acc=acc;
        end
     %   h += alpha*h_;
     	h_ = h_ ./sum(h_,2);
     	h += h_ * alpha;
	    [pp sum_pred] = max(h,[],2);
    	sum_acc = mean(sum_pred == yt);
        fprintf('Accuracy on test %.3f / weighted error %.3f / accumelated accuracy %.3f \n', ...
         [acc weighted_error sum_acc]);
        progress = [progress sum_acc];
    end

    [pp final_pred] = max(h,[],2);
    final_acc = mean(final_pred == yt);
    fprintf(['\n\n------------------------\n', ...
    	'Max single accuracy: %.4f \n', ...
    	'Final accuracy: %.4f \n'], [max_acc final_acc]);
    plot(progress);

end
