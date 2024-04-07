clc; close all; clear;

fprintf("Loading Data\n");
[columnHeaders data] = grabData2("ktkAndCoreSetsEditedForOctave.csv", ",");
##[columnHeaders data] = grabData2("ktkEditedForOctave.csv", ",");
##[columnHeaders data] = grabData2("ktkEditedForOctaveSHORT.csv", ",");
%pretty sure the columnheaders are messed up now that I added the
%subtype column

%data comes in as a bunch of numbers that are in ascii 

%this for loop shows you the first 3 examples
fprintf("The first 6 examples are:\n");
example = 0;
for i = 1:6
  for j = 1:11
    for k = 1:length(data(i, j, :))
      if data(i, j, k) ~= 0
        example = strcat(example, data(i, j, k));
      end
    end
    example = strcat(example, ", ");
  end
  example = strtrunc(example, length(example)-1);
  fprintf("%s\n", example)
  example = 0;
end





%split the qualitative and quantitative data
[X, y] = formatAllTheData(data);
[notUsed, width] = size(X);
theta = zeros(width, 1);

% Some gradient descent settings
iterations = 100;
alpha = 0.01;

theta = gradientDescent(X, y, theta, alpha, iterations);

##right now this just picks a card that is already in the dataset
##at some point you need to randomly choose a percentage of the dataset
##to be the X and a percent to be the y and make your decisions based on that

testCard = X(3, :);

priceOfTest = testCard * theta;


%move the correct columns to X and y, so populate them
%this is also where the price is pulled out, and it is hard coded,
%it does not find the price

##X = [data(:, 1:8) data(:, 10:11)];
##y = data(:, 9);

%feature scale the data
%you can't just normalize all of the columns because some are values and some
%are strings, idiot
