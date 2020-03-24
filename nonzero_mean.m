function [rowmean,rowstdev] = nonzero_mean(data_nz)
%mean and std of data in a sparsely populated or nan-corrupted matrix,
%ignoring nan and identically zero entries

if ~isvector(data_nz)

for ii = 1:size(data_nz,1)
    total_vec = 0;
    denom = 0;
    for jj = 1:size(data_nz,2)
        if data_nz(ii,jj) ~= 0 && ~isnan(data_nz(ii,jj))
            denom = denom + 1;
            total_vec(denom) = data_nz(ii,jj);
        end
    end
    rowmean(ii) = mean(total_vec);
    rowstdev(ii) = std(total_vec);
end

else
    total_vec = 0;
    denom = 0;
    for jj = 1:length(data_nz)
        if data_nz(jj) ~= 0 && ~isnan(data_nz(jj))
            denom = denom + 1;
            total_vec(denom) = data_nz(jj);
        end
    end
    rowmean = mean(total_vec);
    rowstdev = std(total_vec);
end