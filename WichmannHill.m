function [r , x, y, z] = WichmannHill(x,y,z)

    x = 171 * mod(x, 177) - 2 * (x / 177);
    if ( x < 0 )
       x = x + 30269; 
    end
    
    y = 172 * mod(y, 176) - 35 * (y /176);
    if (y < 0 )
        y = y + 30307;
    end
    
    z = 170 * mod(z, 178) - 63 * (z / 178);
    if ( z < 0 )
        z = z+30323;
    end
    
    temp = x/30269.0 + y/30307.0 + z/30323.0;
    
    r = mod( temp , 1.0 );

end