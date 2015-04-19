function [X Y Xmean Xrange] = features_set_6(X_in, xm, xr)

    X = X_in;
    Y = X(:,end);
    X(:, end) = [];
    initX = X;
    X = log(X+1);

    if ~exist('xm', 'var') || isempty(xm)    
        Xmean = mean(X);
        Xrange = range(X);
    else
        Xmean = xm;
        Xrange = xr;
    end

    X = (X.-Xmean)./Xrange;

    v = sum(X>0);
    [i ix] = sort(v, "descend");

    X2 = X.^2;

    [g_means g_vars] = group_stats();

    % The method below takes the absolute distance for each feature with the
    % expected (average) value for that feature for each class.

    % for idx=1:9
    %     avg_feature_vector = avg_features(idx,:);
    %     dt = abs(initX.-avg_feature_vector).*(initX~=0);
    %     X = [X dt];
    % end

    % The method below calculates a distance between the vector formed by all
    % expected (average) feature values. Taking into account only those features for
    % which the record has non-zero value features.

    distances = [];
    for idx=1:9
        avg_feature_vector = g_means(idx,:);
        var_feature_vector = g_vars(idx,:);
        var_feature_vector = max(var_feature_vector, 1e-14);
        dt = bsxfun(@minus,initX, avg_feature_vector);
        dt = (dt.^2);
        dt = bsxfun(@rdivide,dt,2*var_feature_vector);
        % dt = sum(dt,2);
        dt = exp(-dt);
        dt = dt.*(initX~=0);
        X = [X dt];
        distances = [ distances dt];
    end

    for i=1:9
        for j=(i+1):10
            X = [X X(:,ix(i)).*X(:,ix(j))];
            X = [X X(:,ix(i))./(1+X(:,ix(j)))];
        end
    end

    % %% power3-products

    for i=1:10
        for j=i:10
            for k=j:10    
                X = [X X(:,ix(i)).*X(:,ix(j)).*X(:,ix(k))];
            end
        end
    end

    % %% power4-products

    % for i=1:4
    %     for j=i:4
    %         for k=j:4
    %             for l=k:4    
    %                 X = [X X(:,ix(i)).*X(:,ix(j)).*X(:,ix(k)).*X(:,ix(l))];
    %         end
    %     end
    % end


    X = [X X2];
end