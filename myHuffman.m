function [CodeWord, dict] = myHuffman(string)
    chars = unique(string);
    p = sum(bsxfun(@eq, string.', chars)) / strlength(string);
    [p, indices] = sort(p);
    chars = chars(indices);

    n = length(p);
    code = cell(1,n);   %Where the codewords are going to be stored
    X = zeros(n,n);   %This matrix helps us track which elemnts we have worked on
    temp = p;   %We will work on temp not to temper with original p

%Building the relationship matrix X.This matrix has all elements zero
%except for few entries which are substituted with 10 or 11.Number 10 denotes this
%entry is the minimum in the column and 11 indicates this is the second
%minimum.the minimum is replaced by 20 and second minimum is replaced by
%sum of the minimum and the second minimum.And processing for the next
%column progresses
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
% creating the dict of Huffman coding in order of alphabet
    [~, charIndex] = sort(chars);
    dict = code(charIndex); % final huffman dictionary

    CodeWord = ''; % final Huffman code
    for i = 1:strlength(string)
        CodeWord = [CodeWord, cell2mat(code(string(i) == chars))];
    end
end