function PARA = GMM(PARA)

data = PARA.data; data = data';
[Priors, PARA.Mu, Sigma] = kmean(data, PARA.class_n);
[PARA.Priors, PARA.Mu, PARA.Sigma, PARA.P0EM,  PARA.PEM, Pxi,L] = EM(PARA,data, Priors, PARA.Mu, Sigma);
% for i = 1 : PARA.class_n
% %     PARA.Sigma(i) = sqrt(Sigma(:,:,i));
%     PARA.Sigma(i) = Sigma(:,:,i);
% end
Wij = repmat(PARA.Priors,PARA.data_n,1);
PARA.LogFnc = sum(Wij.*Pxi,2);
PARA.L1 = L;


