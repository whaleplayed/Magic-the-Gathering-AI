function [X, y] = formatAllTheData(data)

%this function is supposed to
% 1. split the quantitative and qualitative data
% 2. create the binary part of the qualitative data
% 3. transition the quantitative data into values
% 4. zip it back up?

%variables we want
%number of examples -- row
n = size(data, 1);
%number of features -- cols
m = size(data, 2);

%indesOfQualitativeData represents a 1 if it is qualitative and a 0 if
%the column is quantitative
indexOfQualitativeData = zeros(1, m);
numberOfQuantitativeColumns = 0;
numberOfQualitativeColumns = 0;
%find all the quantitative columns
for col = 1:m
  %if first data point is NOT a number,
  %need to create an index of qualitative data columns
  if !(data(1, col, 1) >= 48 && data(1, col, 1) <= 57)
    indexOfQualitativeData(col) = 1;
    numberOfQualitativeColumns++;
  else
    numberOfQuantitativeColumns++;
  endif
endfor


Xquan = zeros(numberOfQuantitativeColumns, n);

lookUpTableForPlacingQualData = [];
quanIndexing = 0;
for col = 1:m
  collectedMatrix = "";
  quantitativeIndexingValue = 1;
  isQuantitativeCol = 0;
  for row = 1:n
    matString = "";
    inMatrix = false;
    %this for loop is taking the k dimension and putting it into a single string
    %variable which is going into matString
    for k = 1:length(data(row, col, :))
      if data(row, col, k) ~= 0
        matString = strcat(matString, data(row, col, k));
      endif
    endfor
    
    
    %if the current column is a qualitative column
    %else then find unique strings
    if indexOfQualitativeData(col) == 0
      if isQuantitativeCol == 0
        isQuantitativeCol = 1;
        quanIndexing++;
      endif
      Xquan(quantitativeIndexingValue, quanIndexing) = str2num(matString);
      quantitativeIndexingValue++;
      if (quantitativeIndexingValue >= 2855)
        fprintf("%d\n", quantitativeIndexingValue);
        fprintf("%s\n", matString);
        size(Xquan)
        %look above at what might be the thing that is being tested
      endif
    else
      [collectedMatrix, index] = numberPlacing(collectedMatrix, matString);
    endif
  endfor

  lookUpTableForPlacingQualData = [lookUpTableForPlacingQualData; collectedMatrix];
endfor

%this creates the qualitative x matrix
Xqual = zeros(n, size(lookUpTableForPlacingQualData));


for row = 1:n
  for col = 1:m
    matString = "";
    %this for loop is taking the k dimension and putting it into a single string
    %variable which is going into matString
    if indexOfQualitativeData(col) == 1
      for k = 1:length(data(row, col, :))
        if data(row, col, k) ~= 0
          matString = strcat(matString, data(row, col, k));
        endif      
      endfor
      for index = 1:size(lookUpTableForPlacingQualData, 1)
        if strcmp(matString, strtrim(lookUpTableForPlacingQualData(index, :)));
          Xqual(row, index) = 1;
        endif
      endfor
     endif
  endfor
endfor


y = Xquan(:, 5);
Xquan = Xquan(:, [1:4, 6]);
X = [Xqual Xquan];



##%this for loop is supposed to tokenize the string variables
##for row = 1:m
##  collectedMatrix = "";
##  for col = 1:n
##    matString = "";
##    inMatrix = false;
##    %this for loop is taking the k dimension and putting it into a single string
##    %variable which is going into matString
##    for k = 1:length(data(col, row, :))
##      if data(col, row, k) ~= 0
##        matString = strcat(matString, data(col, row, k));
##      end
##    endfor
####    matString = data(col, row, :);
##    %this is turning the ascii back to numbers if they are meant to be numbers
##    %if not then they are tokenized
##    %the collectedMatrix is all of the tokens
##    %ascii 48 to 57 are numbers 0-9 in ascii
##    
##    %if it is a number:
##    if data(1, row, 1) >= 48 && data(1, row, 1) <= 57
##      %make the data a number and keep it in the same col and row
##      formattedData(col, row) = str2num(matString);
##    else
##      %if the data point is not a number
##      %
##      [collectedMatrix, index] = numberPlacing(collectedMatrix, matString);
##      formattedData(col, row) = index;
##      
##    endif
##  endfor
##end