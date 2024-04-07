function [asciiTable] = loadAsciiLookUpTable()
  
  lookUpTable = fopen("asciiConvertLookupTable.csv");
  
  i = 1;
  while true
    currentLine = fgetl(lookUpTable);
    
    %break if there are no lines left
    if currentLine == -1
      break;
    endif
    
    asciiTable(i, 1:length(currentLine)) = currentLine;
    i++;
  endwhile
  
  fclose(lookUpTable);
  
end