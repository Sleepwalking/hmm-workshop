function [h] = hmm_init(h, O, s)
  N = size(h.A, 1);
  T = length(s);
  K = size(h.B, 2);

  for i = 1:N
    iidx = find(s == i);
    iidx_o = O(iidx);
    for k = 1:K
      h.B(i, k) = sum(iidx_o == k) / length(iidx);
    end
    iidx = iidx(1:end - 1);
    for j = 1:N
      h.A(i, j) = sum(s(iidx + 1) == j) / length(iidx);
    end
  end
end

