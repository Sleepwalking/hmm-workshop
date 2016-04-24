function [h total a b] = hmm_baumwelch(h, O)
  N = size(h.A, 1);
  T = size(O, 1);
  [a b total] = hmm_forwardbackward(h, O);
  pstate = a + b - total;
  ptrans = @(t, i, j) a(t, i) + log(h.A(i, j) .* h.B(j, O(t + 1))') + b(t + 1, j) - total;

  for i = 1:N
    base = sum(exp(pstate(1:T-1, i)));
    for j = 1:N
      part = sum(exp(ptrans(1:T-1, i, j)));
      h.A(i, j) = part / base;
    end
  end
  h.P = exp(pstate(1, 1:N));

  for j = 1:N
    base = sum(exp(pstate(1:T, j)));
    for k = 1:size(h.B, 2)
      h.B(j, k) = sum(exp(pstate(find(O == k), j))) / base;
    end
  end
end

