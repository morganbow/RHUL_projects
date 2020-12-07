% WRITE HERE YOUR FUNCTION FOR EXERCISE 1 
function [inventory,totals] = waferstore(partNo, quant, cost)
% Returns a strucure array from the three vectors given and also return the
% total costs of each part
if not((length(partNo)==length(quant))&(length(quant)==length(cost)))
    error("The three vectors you gave are of different length")
else
    inventory = struct('Partno',[],'quantity',[],'costper',[]);
    for i = flip(1:length(partNo))
        inventory(i) = struct('Partno',partNo(i),'quantity',quant(i),'costper',cost(i));
    end
    totals = [partNo;quant.*cost]';
end
end

