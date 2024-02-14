function [CodeWord, BinaryCode] = myLempelziv(input_string)
    str='';
    SubStrHolder = string(input_string(1)); % the array that holds the seen substrings in the main string
    CodeWord = int2str(0) + string(input_string(1));
    BinaryCode = int2str(0) + string(dec2bin(input_string(1)-65, 5));
    SeenIndex = 0; % holds the index of the seen substring in the main string
    for k = 2:strlength(input_string)
        str = [str, input_string(k)];
        tempIndex = ismember(SubStrHolder,str);
        if(sum(tempIndex))
            SeenIndex = find(tempIndex);
        else
            SubStrHolder = [SubStrHolder, string(str)];            
            CodeWord = CodeWord + int2str(SeenIndex) + string(input_string(k));
            BinaryCode = BinaryCode + string(dec2bin(SeenIndex)) + string(dec2bin(input_string(k)-65, 5));
            SeenIndex = 0;
            str = '';
        end
    end
    if(SeenIndex)       
        CodeWord = CodeWord + int2str(SeenIndex);
        BinaryCode = BinaryCode + string(dec2bin(SeenIndex));
    end
end