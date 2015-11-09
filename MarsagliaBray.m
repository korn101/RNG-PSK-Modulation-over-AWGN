% marsaglia-bray
function R1 = MarsagliaBray()
    s = 1;
    while ( s >= 1 )
        v1 = 2 * rand - 1;
        v2 = 2 * rand - 1;
        s = v1*v1 + v2*v2;
    end
    L = sqrt(-2 * log(s) / s);    
    R1 = v1 * L;

end