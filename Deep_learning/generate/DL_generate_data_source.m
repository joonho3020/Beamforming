
%generate test data for aperture radiation with source
function [ data, labels_ab_source] = DL_generate_data_source(data_size, lamda, num)
    

    %k=2*pi()/lamda;

    D_matrix = zeros(num*num, data_size);
    labels_ab_source = zeros(data_size, 6);
    
    max_ab = 25;
    min_ab = 5;
    max_d = 25;
    min_d = 5;
    
    processbar = waitbar(0, 'processing output');

    for iter = 1:1:data_size
           a = (max_ab - min_ab) * rand + min_ab;
           b = (max_ab - min_ab) * rand + min_ab;
           
           x0 = a/2;
           y01 = 4*b*rand - 2* b;
           d1 = (max_d - min_d) * rand + min_d;
           %y02 = 4*b*rand - 2* b;
           %d2 = (max_d - min_d) * rand + min_d;
           %x02 = a*rand;
           %y02 = b*rand;
           %d2 = (max_d - min_d) * rand + min_d;
           
           [Exa, Eya, Hxa, Hya] = Aperture_field_from_point_source(x0, y01, d1, a, b, lamda, num);
           %[Exa2, Eya2, Hxa2, Hya2] = Aperture_field_from_point_source(x0, y02, d2, a, b, lamda, num);

            %D = Get_Directivity_General(Exa + Exa2, Eya + Eya2, Hxa + Hxa2, Hya + Hya2, a, b, lamda, num);
            D = Get_Directivity_General(Exa, Eya, Hxa, Hya, a, b, lamda, num);
            %plot_single_beam(D);
           
    
            D_matrix(:,iter) = reshape(D, [], 1);
            labels_ab_source(iter, 1) = a;
            labels_ab_source(iter, 2) = b;
            %labels_ab_source(iter, 3) = x01;
            labels_ab_source(iter, 3) = y01;
            labels_ab_source(iter, 4) = d1;
            %labels_ab_source(iter, 6) = x02;
            %labels_ab_source(iter, 5) = y02;
            %labels_ab_source(iter, 6) = d2;
            waitbar(iter/data_size)

    end
    
     data = reshape(D_matrix, num*num, data_size);
     data = data.';
     close(processbar)

end