function [collectedMatrix, index] = numberPlacing(collectedMatrix, newWord)
  
  inMatrix = false;
  if length(collectedMatrix) > 0
    for i = 1:size(collectedMatrix, 1)
      %this checks to see if the collected matrix at this index is the newWord
      if strcmp(strtrim(collectedMatrix(i, :)), newWord)
        index = i;
        inMatrix = true;
      endif
    end
    if inMatrix == false
      collectedMatrix = [collectedMatrix; newWord];
      i++;
      index = i;
    endif
  else
    index = 1;
    collectedMatrix(1, 1:length(newWord)) = newWord;
  end
end