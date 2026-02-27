function pos = random_sparse_integer(N, L, min_gap, seed)
    rng(seed);
    if N > (L+1)
        error('N cannot exceed L+1 on integer grid.');
    end
    % enforce including 0 for reference
    pos = 0;
    candidates = 1:L;
    candidates = candidates(randperm(numel(candidates)));

    for c = candidates
        if numel(pos) >= N
            break;
        end
        if all(abs(c - pos) >= min_gap)
            pos(end+1) = c; %#ok<AGROW>
        end
    end

    if numel(pos) < N
        % relax by simple fill (still unique)
        rest = setdiff(0:L, pos);
        pos = unique([pos, rest(1:(N-numel(pos)))]);
    end

    pos = sort(pos);
end