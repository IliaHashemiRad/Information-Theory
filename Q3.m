clear;clc;

CodeWord = randi([0,1], 1, 1000);
N0 = 3.24;
channel_noise = N0/2 * randn(size(CodeWord));
E = 3.5^2;
BPSK_signal = (-sqrt(E)) * CodeWord + sqrt(E) * (~CodeWord) + channel_noise; % creating BPSK-modulated signal
l = length(BPSK_signal);
repeatance = 25;
n_check_nodes = 4;
reconstructed_codeword = Sum_Product_BPSK(BPSK_signal, repeatance, E, N0, n_check_nodes, l);
estimation_accuracy = sum(reconstructed_codeword == CodeWord) / l;

output = sprintf('The estimation accuracy percentage in decoding is %f', estimation_accuracy * 100);
disp(output);

%% functions
function reconstructed_codeword = Sum_Product_BPSK(BPSK_signal, repeatance, E, N0, n_check_nodes, l)
    L = 4 * sqrt(E)/N0 * BPSK_signal; % creating the initial likelihood
    M_matrix = repmat(L', 1, n_check_nodes);  %Lji matrix
    N_matrix = M_matrix.';  % Lij matrix
    
    for i = 1:repeatance
        for k = 1:l
            for j = 1:n_check_nodes
                current_message = M_matrix(:,j);
                current_message(k) = [];  % To remove the message in the current time from the product accordign to formula
                N_matrix(j, k) = 2 * atanh(prod(tanh(current_message / 2))); % Updating from check nodes to variable nodes with the formula for Lji
            end
        end     
        for k = 1:l
            for j = 1:n_check_nodes
                current_message = N_matrix(:,k);
                current_message(j) = []; % To remove the message in the current time from the product accordign to formula
                M_matrix(k, j) =  L(k) + sum(current_message); % Updating from variable nodes to check nodes with the formula for Lij
            end
        end
    end
    L = L + sum(N_matrix, 1); % updating likelihood
    reconstructed_codeword = L < 0;     %detected codeword
end