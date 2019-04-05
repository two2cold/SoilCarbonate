%% GaussNewton method for finding out the optimal parameters
function estimate = GaussNewton_func(xaxis,yaxis,parameters)
    estimate = GN(xaxis',parameters,yaxis');
end

%% Set up a function
function functionOut = MyFunc(input,params)
    % Assumes input is a single row matrix
	% Assumes params is a single row matrix
    functionOut = params(1)*input + params(2);
%     functionOut = params(1)*input.^2 + params(2)*input + params(3);
end
    
%% Set up a jacobian
function jaco = Jacobian(input,params)
    DERIV_STEP = 1e-3;
    if size(input,1)~=1
        error("Input must be one row");
    end
    if size(params,1)~=1
        error("Parameters must be one row");
    end
    jaco = zeros(length(input),length(params));
    change = zeros(1,length(params));
    for i=1:length(params)
        change(i) = DERIV_STEP;
        jaco(:,i) = (MyFunc(input,params+change) - MyFunc(input,params-change))'/2/DERIV_STEP;
    end
end

%% Calculate the residual sum of squares
function resi = RSS(output1,output2)
    resi = 0;
    if size(output1,1)~=1
        error("Error calculating RSS, output1 must be one row");
    end
    if size(output2,1)~=1
        error("Error calculating RSS, output2 must be one row");
    end
    if size(output1,2)~=size(output2,2)
        error("Error calculating RSS, the length of the two outputs must be consistent");
    end
    for i=1:length(output1)
        resi = resi + (output2(i) - output1(i))^2;
    end
    resi = resi/length(output1);
end

%% GaussNewton 
function finalParams = GN(input,params,data)
    last_resi = 0;
    MAX_ITER = 1000;
    finalParams = params;
    initParams = params;
    for i=1:MAX_ITER
        jaco = Jacobian(input,params);
        resi = RSS(MyFunc(input,params),data);
        if abs(last_resi-resi)<1e-2
            finalParams = params;
            break;
        end
        delta = (jaco'*jaco)\jaco'*(data - MyFunc(input,params))';
        params = params + delta';
        last_resi = resi;
    end
    if finalParams==initParams
        error("No convergence for the GaussNewton, take another guess");
    end
end
    