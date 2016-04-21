function [a b total] = hmm_forwardbackward(h, O)
  T = size(O, 1);
  N = size(h.A, 1);
  a = zeros(T, N);
  b = zeros(T, N);
  a(1, :) = log(h.P .* h.B(:, O(1))');
  b(end, :) = 0;
  for t = 1:T - 1
    t_ = T - t;
    for j = 1:N
      a(t + 1, j) = lsume(a(t, :) + log(h.A(:, j)')) + log(h.B(j, O(t + 1)));
      b(t_, j) = lsume(b(t_ + 1, :) + log(h.A(j, :) .* h.B(:, O(t_ + 1))'));
    end
  end
  total = lsume(a(T, :));
end

function y = lsume(x)
  u = max(x);
  y = log(sum(exp(x - u))) + u;
end

