clear; clc; close all
% creating symbols
Num_Symbols = 10^4;
symbols = randsrc(1, Num_Symbols, [[-1, 1]; [5/13, 8/13]]);
G_k = zeros([1, 10]);
Huff_mean = zeros([1, 10]);
Coding_efficiency = zeros([1, 10]);
H_X = 0.8930492673;
for k = 1:10
    %determining probabilities vector for Xk
    n = numel(symbols);
    symbols_k = nan(k, ceil(n/k));
    symbols_k(1:n) = symbols;
    symbols_k = symbols_k.';
    Unq_syms_k = unique(symbols_k, 'rows');
    row_rpt = zeros([1, length(Unq_syms_k)]);
    for i = 1:size(Unq_syms_k, 1)
        row = Unq_syms_k(i, :);
        row_rpt(i) = sum(ismember(symbols_k, row, "rows"));
    end
    p = row_rpt(:)/sum(row_rpt);
    p = p.';

    % calculating G_k
    G_k(k) = sum(-p .* mylog2(p)) / k;

    %calculating Huffman mean codeword length
    Huffman_code = myHuffman_k(p, symbols_k, Unq_syms_k);
    Huff_mean(k) = strlength(Huffman_code) / Num_Symbols; % the mean length of binary code of characters in huffman coding.

    %calculating Coding gain
    Coding_efficiency(k) = H_X / Huff_mean(k);
end

k = 1:10;
figure
subplot(3,1,1)
plot(k, G_k, LineWidth=2, Color='b')
title('The entropy rate $G_k = \frac{H(X_1,X_2,\cdots,X_k)}{k}$ for different $k$s', 'Interpreter','latex', FontSize=25)
ylabel('$G_k$', 'Interpreter','latex', FontSize=20)
xlabel('$k$', 'Interpreter','latex', FontSize=20)
ylim([0.8, 1])
grid minor

subplot(3,1,2)
plot(k, Huff_mean, LineWidth=2, Color='g')
title('The mean length of $Huffman$ code words for different $k$s', 'Interpreter','latex', FontSize=25)
ylabel('$\bar{R}$', 'Interpreter','latex', FontSize=20)
xlabel('$k$', 'Interpreter','latex', FontSize=20)
ylim([0.8, 1])
grid minor

subplot(3,1,3)
plot(k, Coding_efficiency, LineWidth=2, Color='r')
title('The Coding Efficiency $\eta_N = \frac{H(X)}{\tilde{H}_N}$ for different $k$s', 'Interpreter','latex', FontSize=25)
ylabel('$\eta_N$', 'Interpreter','latex', FontSize=20)
xlabel('$k$', 'Interpreter','latex', FontSize=20)
ylim([0.8, inf])
grid minor


%% functions
function [CodeWord] = myHuffman_k(p, symbols_k, Unq_syms_k)
    n = length(p);
    code = cell(1,n);   %Where the codewords are going to be stored
    X = zeros(n,n);   %This matrix helps us track which elemnts we have worked on
    temp = p;   %We will work on temp not to temper with original p

    for i = 1:n-1
        [~ ,index] = sort(temp);
        X(index(1),i) = 10;
        X(index(2),i) = 11;
        temp(index(2)) = temp(index(2)) + temp(index(1));
        temp(index(1)) = 20;
    end

%Filling in codewords.The key is the relationship between the 11 marked
%entry in each columnThis ties the column with the next one.
    i = n-1;
    rows = find(X(:,i) == 10);
    code(rows) = strcat(code(rows),'1');
    rows = find(X(:,i) == 11);
    code(rows) = strcat(code(rows),'0');
    for i = n-2:-1:1
        row11 = X(:,i) == 11;
        row10 = X(:,i) == 10;
        code(row10) = strcat(code(row11),'1');
        code(row11) = strcat(code(row11),'0');
    end

    CodeWord = []; % final Huffman code
    for i = 1:size(symbols_k, 1)
        CodeWord = [CodeWord, cell2mat(code(ismember(Unq_syms_k, symbols_k(i, :), "rows")))];
    end
end

% returns zero if the input is zero(to solve the MATLAB problem of 0 * log2(0) =
% -Inf)
function out = mylog2(in)
    out = log2(in);
    out(~in) = 0;
end


