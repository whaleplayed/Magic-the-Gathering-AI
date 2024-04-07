function [returnString] = toascii(vector)
  
  returnString = "";
  
  if (exist("asciiTable", "var") == 0)
    asciiTable = loadAsciiLookUpTable();
  endif
  
  for i = 1:length(vector)
    
    returnString = strcat(returnString, asciiTable(vector(i) + 1));
    
  endfor
  
end