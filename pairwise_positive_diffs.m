function dd = pairwise_positive_diffs(pos)
    pos = sort(pos(:));
    N = numel(pos);
    dd = zeros(N*(N-1)/2,1);
    k = 1;
    for i = 2:N
        for j = 1:(i-1)
            dd(k) = pos(i) - pos(j);
            k = k + 1;
        end
    end
end