clear; clc;

%% part a
alphabets = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
p = [8.4966, 2.0720, 4.5388, 3.3844, 11.1607, 1.8121, 2.4705, 3.0034, 7.5448, 0.1965, 1.1016, 5.4893, 3.0129, 6.6544, 7.1635, 3.1671, 0.1962, 7.5809, 5.7351, 6.9509, 3.6308, 1.0074, 1.2899, 0.2902, 1.7779, 0.2722];
Num_chars = 5000;
p = p(:).'/sum(p); % normalising the probabilities
index = randsrc(Num_chars, 1, [1:numel(alphabets); p]);
string = alphabets(index);

%% part b
[Huff_CodeWord, dict] = myHuffman(string);
[Lemp_CodeWord, BinaryCode] = myLempelziv(string);
Huff_length = strlength(Huff_CodeWord);
Lemp_length = strlength(BinaryCode);
ASCII_Bits = 5; % number of bits needed to make each symbol to its ASCII binary form

output1 = sprintf('The Compression Ratio for Huffman encoding is %f', (Num_chars * ASCII_Bits) / Huff_length);
disp(output1);
output2 = sprintf('The Compression Ratio for Lempelziv encoding is %f', (Num_chars * ASCII_Bits) / Lemp_length);
disp(output2);

%% part c
Num_UniqueSymbols = strlength(unique(string));  % number of unique symbols in the English text
% Huffman
Huff_dict_length = sum(cellfun(@length, dict));

% Lempleziv
Numbers = regexp(Lemp_CodeWord, '\d*', 'match'); % all the numbers in the lempleziv CodeWord
Numbers = unique(str2double(Numbers)); % unique numbers in double
c = 0; % the minimum length of bits needed to save the binary form of each unique number
for i = 1:length(Numbers)
    c = c + strlength(dec2bin(Numbers(i)));
end
LempDictLength1 = c + Num_UniqueSymbols*5; % adding the memory needed to save dictionary of numbers to dictionary of alphabets in method1
LempDictLength2 = Num_UniqueSymbols*5; % memory of saving the dict of alphabets

% without coding
WithoutComp_dict_length = Num_UniqueSymbols*5;

output1 = sprintf('The space needed to save the dictionary of Huffman Code is %d bits', Huff_dict_length);
disp(output1);
output2 = sprintf('The space needed to save the dictionary of Lempleziv Code in the fisrt method of decoding is %d bits and in the second is %d', LempDictLength1, LempDictLength2);
disp(output2);
output3 = sprintf('The space needed to save the dictionary of Coding without compression is %d bits', WithoutComp_dict_length);
disp(output3);

%% part d
Source_Entropy = sum(-p .* log2(p));
Huff_mean = Huff_length / Num_chars; % the mean length of binary code of characters in huffman coding.
Lemp_mean = Lemp_length / Num_chars; % the mean length of binary code of characters in Lempelziv coding.

output1 = sprintf('The Source Entropy is %f bits/symbol', Source_Entropy);
disp(output1);
output2 = sprintf('The mean length of code for each symbols in Huffman coding is %f bits/symbol', Huff_mean);
disp(output2);
output3 = sprintf('The mean length of code for each symbols in Lempelziv coding is %f bits/symbol', Lemp_mean);
disp(output3);


%% functions
function code = Arithmetic_Coder(string, p)
    low = 0;
    high = 1;
    range = 1;
    % Encode each symbol in source
    for i = 1:length(string)
        % Find range for current symbol
        symbol = string(i);
        symbolRange = [0, 0];
        for j = 1:symbol-1
            symbolRange(1) = symbolRange(2);
            symbolRange(2) = symbolRange(2) + p(j);
        end
        symbolRange(1) = symbolRange(2);
        symbolRange(2) = symbolRange(2) + p(symbol);
    
        % Update encoder range
        width = high - low;
        high = low + width*symbolRange(2)/range;
        low = low + width*symbolRange(1)/range;
        range = high - low;
    end
    code = (low + high)/2;
end
