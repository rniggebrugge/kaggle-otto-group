function weights = combine_nn(x,y, xv, yv, xt, yt)

	x(x~=0)=1;
	xv(xv~=0)=1;
	xt(xt~=0)=1;

	[m n] = size(x);

	nmodels = 500;
	nfeats  = 100;
	niters  = 150;
	lambda  = 4;
	nhl     = 150;

	niters_2 = 150;

	th1_collection = [];
	th2_collection = [];
	permutations   = [];
	h_collection = [];
	h = [];
	weights = ones(nmodels*10,1);

	for ix=1:nmodels
		fprintf('----------------------------------------\n %i / %i \n', [ix,nmodels]);
		p = randperm(n)(1:nfeats);
		permutations(:,ix) = p;
		[th1 th2] = kaggle_run(x(:,p), y, nhl, lambda, niters);
		th1_collection(:,:,ix) = th1;
		th2_collection(:,:,ix) = th2;
		[p_ h_] = predict(th1,th2,xv(:,p));
		fprintf('Accuracy on validation: %.2f \n'  , mean(p_==yv));
		if ix==1
			h = h_;
		else
			h = h + h_;
		end
		h_collection(:,:,ix) = h_;
	end

	[vv p_] = max(h,[],2);
	acc_optimal = mean(p_==yv);
	fprintf('\n\nFirst naieve accuracy (no weighting): %.2f \n', acc_optimal);

	% input("Please press enter to continue");

	for ix=1:niters_2
		fprintf('Iteration %i / %i \n', [ix niters_2]);
		r = randperm(nmodels*10);
		count_changes = 0;
		for ix2=r
			mdl = idivide(ix2-1,10)+1;
			val = mod(ix2,10);
			if val == 0
				val=10; 
			end
			h_sub = bsxfun(@times,h_collection(:,:,mdl) , (yv==val));
			% h_up = h + .1*h_sub;
			% h_down = h - .1*h_sub;
			% [vv p_up] = max(h_up,[],2);
			% [vv p_down] = max(h_down, [], 2);
			% acc_up = mean(yv==p_up);
			% acc_down = mean(yv==p_down);
			% [vv index] = max([acc_up acc_down acc_optimal]);
			% if  index==1
			% 	h = h_up;
			% 	acc_optimal = acc_up;
			% 	weights(ix2) += .1;
			% fprintf('Adding weight to model %i, class %i. New accuracy: %.4f \n', [mdl, val, acc_up]);
			% 	count_changes += 1;
			% 	fflush(stdout);
			% end
			% if  index==2
			% 	h = h_down;
			% 	acc_optimal = acc_down;
			% 	weights(ix2) -= .1;
			% 	count_changes += 1;
			% 	fprintf('Lowering weight to model %i, class %i. New accuracy: %.4f \n', [mdl, val, acc_down]);
			% 	fflush(stdout);
			% end
			h_temp = h;
			h_step = .1*h_sub;
			steps = 0;
			do 
				h_temp += h_step;
				[vv pp] = max(h_temp,[],2);
				acc = mean(yv==pp);
				if acc>=acc_optimal
					steps++;
					acc_optimal = acc;
					get_out = 0;
					h = h_temp;
				else
					get_out = 1;
				end
			until (get_out==1);
			if steps>0
				weights(ix2) += steps*.1;
				fprintf('Adding weight %.1f to model %i, class %i. New accuracy: %.4f \n', [steps*.1, mdl, val, acc]);
			else
				do 
					h_temp -= h_step;
					[vv pp] = max(h_temp,[],2);
					acc = mean(yv==pp);
					if acc>=acc_optimal
						steps++;
						acc_optimal = acc;
						get_out = 0;
						h = h_temp;
					else
						get_out = 1;
					end
				until (get_out==1);
				if steps>0
					weights(ix2) += steps*.1;
					fprintf('Lowering weight %.1f to model %i, class %i. New accuracy: %.4f \n', [steps*.1, mdl, val, acc]);
				end
			end
				

			fflush(stdout);
		end
		% if count_changes==0
		% 	fprintf('\n\nNo more changes found');
		% 	break;
		% end
	end

	% weights
	fprintf('\n\nFinal accuracy: %.2f\n', acc_optimal);



end



