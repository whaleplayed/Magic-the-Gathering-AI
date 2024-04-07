function [columnHeaders data] = grabData2(filename, delimeter)
  
  %open the file: filename
  fid = fopen(filename);
  %get the current line of the file
  currentLine = fgetl(fid);
  
  %get the list of comma indices
  indexOfCommas = strfind(currentLine, ",");
  
  %create rawData with the current number of columns expected by counting
  %the amount of commas and then adding one because there is a column after
  %the last comma, and another one because we are splitting creature types and
  %the subtypes which is the numOfArtificialColumns
  numOfArtificialColumns = 1;
  additionalColumns = numOfArtificialColumns + 1;
  maxCols = size(indexOfCommas, 2)+additionalColumns;
  
  %create the column header array and rawData matrix
  columnHeaders(1, 1:maxCols, 1) = 0;
  rawData(1, 1:maxCols, 1) = 0;
  
  row = 1;
  while true
    
    indexOfCommas = strfind(currentLine, ",");
    currCSVDataPoint = 1;
    currRawDataCol = 1;
    currentWord = "";
    first = 1;
    %minus one to remove the comma
    second = indexOfCommas(1)-1;
    %minus here because the same algorithm doesnt work on the word after
    %the last comma
    for currCSVDataPoint = 1:length(indexOfCommas)
      currentWord = currentLine(first:second);
      %check to see if there is a subtype in the "card type" data point
      if !isempty(strfind(currentWord, "—")) && currRawDataCol == 1
        %find where the "card type" ends and where the "subtype" begins
        %by finding the first two spaces which should surround
        %the "em dash": � or —
        indexOfSpaces = strfind(currentWord, " ");
        %place the "card type" into the first column of rawData
        rawData(row, currRawDataCol, 1:indexOfSpaces(1)) = currentWord(1:indexOfSpaces(1));
        %go to the second column
        currRawDataCol++;
        %place the "subtype" into the second column of rawData
        rawData(row, currRawDataCol, indexOfSpaces(2):length(currentWord)) = currentWord(indexOfSpaces(2):length(currentWord));
        %if the first data point doesnt have a "subtype" then we still
        %need to care about the "subtype" column and to do so, we skip it
      elseif currRawDataCol == 1
        %put the "cardtype" into the first col
        rawData(row, currRawDataCol, 1:length(currentWord)) = currentWord;
        %skip the second col because there isnt a "subtype"
        currRawDataCol++;
        rawData(row, currRawDataCol, 1:4) = "None";
      else
        %place the data into the row
        rawData(row, currRawDataCol, 1:length(currentWord)) = currentWord;
      endif
      %go to next row
      currRawDataCol++;
      
      %this is moving to the next row for the currentWord
      if currCSVDataPoint < length(indexOfCommas)
        first = indexOfCommas(currCSVDataPoint)+1;
        second = indexOfCommas(currCSVDataPoint+1)-1;
      end
      
    endfor
    lastComma = indexOfCommas(length(indexOfCommas));
    currentWord = currentLine(lastComma+1:length(currentLine));
    rawData(row, maxCols, 1:length(currentWord)) = currentWord;
    row++;
    %get the next line of the file
    currentLine = fgetl(fid);
    
    %break if there are no lines left
    if currentLine == -1
      break;
    endif
    rawData(row, 1:maxCols, 1) = 0;
    

endwhile
  
  columnHeaders(1, 1:maxCols, 1:length(rawData(1, :, :))) = rawData(1, 1:maxCols, :);
  data(:, 1:maxCols, :) = rawData(2:end, 1:maxCols, :);
  
end