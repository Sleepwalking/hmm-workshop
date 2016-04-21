function [s a optim] = hmm_viterbi(h, O)
  T = size(O, 1);
  N = size(h.A, 1);
  a = zeros(T, N);
  p = zeros(T, N);
  a(1, :) = log(h.P) + log(h.B(:, O(1))');
  for t = 1:T - 1
    for j = 1:N
      [opt idx] = max(a(t, :) + log(h.A(:, j)'));
      a(t + 1, j) = opt + log(h.B(j, O(t + 1)));
      p(t + 1, j) = idx;
    end
  end
  [optim idx] = max(a(T, :));
  
  % back tracing
  s = zeros(T, 1);
  s(end) = idx;
  for t = T - 1:-1:1
    s(t) = p(t + 1, s(t + 1));
  end
end

