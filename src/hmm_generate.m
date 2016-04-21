function [O s] = hmm_generate(h, T)
  s = zeros(T, 1);
  O = zeros(T, 1);
  s(1) = randchoose(h.P);
  O(1) = randchoose(h.B(s(1), :));
  for i = 2:T
    s(i) = randchoose(h.A(s(i - 1), :));
    O(i) = randchoose(h.B(s(i), :));
  end
end

function n = randchoose(pmf)
  n = [find(cumsum(pmf) > rand) 1];
  n = n(1);
end

