%
% Copyright (c) 2023, 
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: ABELLY
% Project Title: Implementation of CONVOLUTION Group Method of Data Handling in MATLAB
% Publisher: ABELLY
% 
% Developer: ELIENEZA NICODEMUS ABELLY
% 
% Contact Info: ellysengy@cug.edu.cn
%
%

function PlotResults(Targets, Outputs, Title)

    Errors = Targets - Outputs;
    MSE = mean(Errors.^2);
    RMSE = sqrt(MSE);
    ErrorMean = mean(Errors);
    ErrorStd = std(Errors);
    
    subplot(2,2,[1 2]);
    plot(Targets);
    hold on;
    plot(Outputs);
    legend('Targets','Outputs');
    ylabel('Targets and Outputs');
    grid on;
    title(Title);
    
    subplot(2,2,3);
    plot(Errors);
    title(['MSE = ' num2str(MSE) ', RMSE = ' num2str(RMSE)]);
    ylabel('Errors');
    grid on;
    
    subplot(2,2,4);
    histfit(Errors, 50);
    title(['Error Mean = ' num2str(ErrorMean) ', Error StD = ' num2str(ErrorStd)]);

end