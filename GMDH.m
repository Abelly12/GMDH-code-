
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

function gmdh = GMDH(params, X, Y)

M = xlsread('data1.xlsx');
X = M(:,1:5);
Y = M(:,6);
X=X';
Y=Y';
params.alpha = 0.7; 
params.MaxLayerNeurons = 40; 
params.MaxLayers = 20; 
params.pTrain = 0.7;
    disp('Training GMDH:');

    MaxLayerNeurons = params.MaxLayerNeurons;
    MaxLayers = params.MaxLayers;
    alpha = params.alpha;

    nData = size(X,2);
    
    % Shuffle Data
    Permutation = randperm(nData)
    X = X(:,Permutation)
    Y = Y(:,Permutation)
    
    % Divide Data
    pTrainData = params.pTrain;
    nTrainData = round(pTrainData*nData);
    X1 = X(:,1:nTrainData);
    Y1 = Y(:,1:nTrainData);
    pTestData = 1-pTrainData;
    nTestData = nData - nTrainData;
    X2 = X(:,nTrainData+1:end);
    Y2 = Y(:,nTrainData+1:end);
    
    Layers = cell(MaxLayers, 1);

    Z1 = X1;
    Z2 = X2;

    for l = 1:MaxLayers

        L = GetPolynomialLayer(Z1, Y1, Z2, Y2);
        
        if l>1
            if L(1).RMSE2 > Layers{l-1}(1).RMSE2
                break;
            end
        end
        
        ec = alpha*L(1).RMSE2 + (1-alpha)*L(end).RMSE2;
        ec = max(ec, L(1).RMSE2);
        L = L([L.RMSE2] <= ec);
        
        if numel(L) > MaxLayerNeurons
            L = L(1:MaxLayerNeurons);
        end
        
        if l==MaxLayers && numel(L)>1
            L = L(1);
        end

        Layers{l} = L;

        Z1 = reshape([L.Y1hat],nTrainData,[])';
        Z2 = reshape([L.Y2hat],nTestData,[])';

        disp(['Layer ' num2str(l) ': Neurons = ' num2str(numel(L)) ', Min Error = ' num2str(L(1).RMSE2)]);

        if numel(L)==1
            break;
        end

    end

    Layers = Layers(1:l);
    
    gmdh.Layers = Layers;
    
    disp(' ');
    
end
