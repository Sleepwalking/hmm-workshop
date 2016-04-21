function [h optim] = hmm_viterbitrain(h, O)
    [s a optim] = hmm_viterbi(h, O);
    h = hmm_init(h, O, s);
end

