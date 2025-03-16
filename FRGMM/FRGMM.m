function PARA = FRGMM(PARA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display = 1;
min_impro = 1e-5;
PARA.Inoise = PARA.Inoise;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_n = PARA.ysize*PARA.xsize;
% Intial center and covariance
for i = 1 : PARA.zsize
    x = PARA.Inoise(:,:,i);  X(:,i)= x(:);
end
U = PARA.U0;
[id, IDX] =  max(PARA.U0',[], 2);
for i = 1 : PARA.class_n
    C(i,:) = mean(X(find(IDX==i),:));
end
P = U';
for i=1 : PARA.class_n
    if (PARA.zsize==1)
        dist(:,i)= [(X-repmat(C(i,:),data_n,1)).^2];
    else
        dist(:,i)= sum([(X-repmat(C(i,:),data_n,1)).^2]');
    end
end
[a1,a2] = min(dist');
for i = 1 : PARA.class_n
    Ni = length(find(a2==i));
    Y = X(find(a2==i),:);
    Ri = cov(Y); var(i,:) = Ri(:)';
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h = ones(PARA.win,PARA.win);
h1 = filter2(h, ones(PARA.ysize,PARA.xsize));
beta=PARA.beta; BETA(1) = beta;
W = P;
Wold = (P+W)/2;
for k = 1 : PARA.epochs
    for i = 1 : PARA.class_n
        Rj = reshape(var(i,:),PARA.zsize,PARA.zsize);
        L1(:,i) = -PARA.zsize/2*log(2*pi)-0.5*log(det(Rj));
        L2(:,i) = -0.5*sum(((X-ones(data_n,1)*C(i,:))*inv(Rj)).*(X-ones(data_n,1)*C(i,:)),2);
        pdfs(:,i) = (((2*pi)^(-PARA.zsize/2))*((det(Rj))^-0.5)*exp(L2(:,i)))+ 1E-20;
        w = filter2(h, reshape(Wold(:,i),PARA.ysize,PARA.xsize));
        theta(:,i) = exp(beta.*w(:)./h1(:));    W(:,i) = P(:,i)+(theta(:,i));
    end
    W = W./(sum(W,2)*ones(1,PARA.class_n));
    P = (W.*pdfs)./(sum(W.*pdfs,2)*ones(1,PARA.class_n));
    
    
    obj_fcn(k) = sum(sum(P.*(mylog(W)+ones(data_n,1)*L1+L2)))-sum(sum((theta).*mylog(W)));
    
    % Update Center C and Var
    for i = 1 : PARA.class_n
        C(i,:) = sum((P(:,i)*ones(1,PARA.zsize)).*X)./sum(P(:,i));
        if (PARA.zsize==1)
            var(i,:) = sum((P(:,i).*(X-C(i,:)).^2))./sum(P(:,i));
        else
            y = X-ones(data_n,1)*C(i,:);
            for j = 1 : PARA.zsize
                y1(:,[j j+PARA.zsize j+2*PARA.zsize]) = y; %[1 1 1 2 2 2 3 3 3]
                y2(:,[1+(j-1)*PARA.zsize 2+(j-1)*PARA.zsize 3+(j-1)*PARA.zsize]) = y; %[1 2 3 1 2 3 1 2 3]
            end
            y = (P(:,i)*ones(1,PARA.zsize^2)).*(y1.*y2);
            s = reshape(sum(y),PARA.zsize,PARA.zsize);
            
            Ri = s/sum(P(:,i));  var(i,:) = Ri(:)';
            
        end
        % Add a tiny variance to avoid numerical instability
        %var(i,:) = var(i,:)+1E-5.*diag(ones(PARA.zsize,1));
    end
    Wold = (P+W)/2;
    
    
    % Display
    if display,
        fprintf('Iteration = %d, fcn = %f\n', k, obj_fcn(k));
    end
    % check termination condition
    if k > 10,
        if obj_fcn(k)<obj_fcn(k-2)
            %break;
        end
    end
    
end
PARA.U = P;
fcn = obj_fcn; figure; plot(fcn, 'b.'); hold on; plot(BETA, 'LineWidth', 2); grid on;
xlabel('interations'); ylabel('Likelihood function');
