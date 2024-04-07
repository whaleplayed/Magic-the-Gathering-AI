function plotAll(formattedData, m)
  
figure;
index = 1;
tz = formattedData(:, 8);
for i = 1:m
  tx = formattedData(:, i);
  for j = 1:m
    ty = formattedData(:, j);
    subplot(10, 10, index);
    plot3(tx, ty, tz, ".", "Markersize", 10);
    index++;
  endfor
endfor
  
end