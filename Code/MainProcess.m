% Load the data.
load('Data.mat')

global train_date;
global W;

[train_date,W,d_mean]=TrainProcess(mat2gray(Train_DAT(:,:,:,1:100)));

t_ans = 0;

wrong = 0;

for i = 1:100
    for j = 1:3
        test = mat2gray(Test_facemask(:,:,j,i));
        test =test';
        o_test = test(:);
        o_test = W'*(o_test - d_mean);
        t_ans = 0;
        for k = 1:6
            t_ans = t_ans+norm(o_test - train_date(:,(i-1)*6+k));
        end
        tmp_min = 1000000;
        for k = 1:100
            tmp = 0;
            for m = 1:6
                tmp = tmp +norm(o_test - train_date(:,(k-1)*6+m));
            end
            if(tmp<tmp_min)
                tmp_min = tmp;
            end
        end
        
        if(tmp_min~=t_ans)
            wrong=wrong+1;
        end
    end
    
    
end
disp("正解する確率：　"+(double(300)-wrong)/300.0);