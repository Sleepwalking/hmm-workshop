h_truth = hmm_create([0.1 0.2 0.7], ...
  [0.98 0.01 0.01; ...
   0.02 0.95 0.03; ...
   0.02 0.08 0.90], ...
  [0.7 0.15 0.15; ...
   0.04 0.9 0.06; ...
   0.03 0.17 0.8]);

[O s] = hmm_generate(h_truth, 2000);

h = hmm_create(h_truth.P, ones(3) / 3, ones(3) / 3);
h = hmm_init(h, O, s);
h.A = ones(3) / 3;
h.B = h.B + rand(3) / 3;
h.B = h.B ./ repmat(sum(h.B, 2), 1, 3);
h2 = h;

T = zeros(10, 1);
for i = 1:10
  %[h2 t] = hmm_viterbitrain(h2, O);
  [h2 t] = hmm_baumwelch(h2, O);
  T(i) = t;
end
%}

[s_ a opt] = hmm_viterbi(h, O);
mean(s == s_)
[s_ a opt] = hmm_viterbi(h2, O);
mean(s == s_)

