function h = hmm_create(P, A, B)
  h.P = P ./ sum(P);
  h.A = A ./ repmat(sum(A')', 1, size(A, 2));
  h.B = B ./ repmat(sum(B')', 1, size(B, 2));
end

