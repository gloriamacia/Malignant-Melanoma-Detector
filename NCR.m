function [ feature ] = NCR ( BW )
feature = sum(sum(BW))/(size(BW,1)*size(BW,2));
end

