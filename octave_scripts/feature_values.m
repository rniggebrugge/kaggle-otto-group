function c = feature_values()

		[x y] =  get_raw_data(-1);

		dt = [x y];

		for fn=1:93

			u = unique(dt(:,fn));
			u(1)=[];
			v = [];
			for cl=1:9
				res = arrayfun(@(t)length(dt(dt(:,fn)==t & dt(:,94)==cl)), u);
				v = [v res];
			end

			v = bsxfun(@rdivide,v, sum(v,2));
			v = [u v];

			c{fn} = v;

		end

	end

	
