function [data] = grabData(filename, delimeter)
  
  
  fid = fopen(filename);
  %get the current line of the file
  currentLine = fgetl(fid);
  
  maxCols = sum(currentLine == ',') + 1;
  
  %create data with the corrent number of columns expected by counting
  %the amount of commas and then adding one
  data = strings(1, maxCols);
  size(data)
  data
  
  row = 1;
  while true
    
    %get the current line of the file
    currentLine = fgetl(fid);
    
    %break if there are no lines left
    if currentLine == -1
      break;
    endif
    
    i = 1;
    delCount = 1;
    currentWord = "";
    while i <= length(currentLine)
      
      currentChar = currentLine(i);
      
      if currentChar == delimeter
        data(row, delCount) = currentWord;
        delCount++;
        currentWord = "";
      else
        currentWord += currentChar;
      endif
      i++;
    endwhile
    data = {data; [1, maxCols]};
    
    row++;
  endwhile
  
end