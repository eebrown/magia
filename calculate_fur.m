function furs = calculate_fur(input,tacs,frames)

I = calculate_fur_integral(input,frames);
furs = mean(tacs,2)./I;
if(max(furs)>10)
    furs = furs*0.001;
elseif(max(furs)<1e-3)
    furs = furs*1000;
end

end