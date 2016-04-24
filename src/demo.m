% create a 3-state dicrete HMM with 4 kinds of output
h_truth = hmm_create([0.1 0.2 0.7], ...
  [0.98 0.01 0.01; ...
   0.02 0.95 0.03; ...
   0.02 0.08 0.90], ...
  [0.7  0.15 0.10  0.05; ...
   0.04 0.90 0.03  0.03; ...
   0.03 0.10 0.40  0.47]);

% generate a sequence of length 2000
[O s] = hmm_generate(h_truth, 2000);

% create a new model of same topology
h = hmm_create(ones(1, 3) / 3, ones(3) / 3, ones(3, 4) / 4);
h = hmm_init(h, O(1:100), s(1:100)); % initialize the new model from a small portion of data

% add some randomness to its transition & output matrices because we don't want zero probabilities
h.A = h.A + rand(3) / 3;
h.B = h.B + rand(3, 4) / 4;
h.A = h.A ./ repmat(sum(h.A, 2), 1, 3); % renormalize transition probability
h.B = h.B ./ repmat(sum(h.B, 2), 1, 4); % renormalize output probability
h2 = h; % create a copy

% create a vector for total likelihood in each iteration
T = zeros(10, 1);
for i = 1:10 % training
  %[a b t] = hmm_forwardbackward(h2, O);
  %h2 = hmm_viterbitrain(h2, O);
  [h2 t a b] = hmm_baumwelch(h2, O);
  T(i) = t;

  plot(exp(a + b - t), 'linewidth', 1);
  title(sprintf('State occupancy probability at iteration %d', i));
  xlim([1 500]);
  ylim([-0.5 1.5]);
  sleep(0.01);
end

% align and compare
[s_ a opt] = hmm_viterbi(h, O);
disp(sprintf('Identification rate of HMM before training: %f%%', 100 * mean(s == s_)));
[s_ a opt] = hmm_viterbi(h2, O);
disp(sprintf('Identification rate of HMM after training: %f%%', 100 * mean(s == s_)));

plot(T, '-o', 'linewidth', 1);
xlim([1 10]);
title('HMM Parameter Estimation');
xlabel('Iteration');
ylabel('Log Likelihood');

