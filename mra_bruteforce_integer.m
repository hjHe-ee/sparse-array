function pos_best = mra_bruteforce_integer(N, Lmax)
    % Brute-force MRA-like search on integer grid:
    % maximize consecutive difference coverage (1..K), then minimize redundancy, then minimize aperture L.
    if N < 3
        error('N must be >= 3 for MRA search.');
    end

    bestK = -inf;
    bestRed = inf;
    bestL = inf;
    pos_best = [];

    for L = (N-1):Lmax
        % choose N-2 inner positions from 1..L-1
        inner = nchoosek(1:(L-1), N-2);  % manageable for small N/L
        for r = 1:size(inner,1)
            pos = [0, inner(r,:), L];

            dd = pairwise_positive_diffs(pos);      % all positive lags (integer)
            u  = unique(dd);

            % consecutive coverage length K: lags 1..K all present
            K = 0;
            while any(u == (K+1))
                K = K + 1;
            end

            redundancy = numel(dd) - numel(u);      % how many repeated lags

            % score: max K, then min redundancy, then min L
            if (K > bestK) || (K == bestK && redundancy < bestRed) || ...
               (K == bestK && redundancy == bestRed && L < bestL)
                bestK = K; bestRed = redundancy; bestL = L;
                pos_best = pos;
            end
        end
    end

    if isempty(pos_best)
        error('No MRA candidate found. Try increasing Lmax or adjusting N.');
    end
end