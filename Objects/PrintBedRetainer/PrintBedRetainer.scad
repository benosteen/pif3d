// od = Outside diameter
// id = ionside (hole) diameter
// rt = retainer thickness
// ho = hole offset
// bh = Bevel height
// ll = lever length
// d  = delta
module PrintBedRetainer(od, id, rt, ho, bh, ll, lt, d)
{
	s30 = sin(30);
    c30 = cos(30);
    lfr = (od-lt)/2;		// Lever fillet radius		
    lfp = od/2+lfr;		// Lever fillet pitch radius
    intersection()
    {
	    	difference()
		{
			union()
        		{
				cylinder(r=od/2, h=rt);
				translate([0,-od/4,0]) cube(size=[ll, od/2, rt]);
			}
			translate([ho,0,-d]) cylinder(r=id/2, h=rt+2*d);
			translate([c30*lfp,-s30*lfp,-d])
			{	
				cylinder(r=lfr, h=rt+2*d);
				translate([0,-lfr,0]) cube(size=[ll, lfr*2, rt+2*d] );
			}
			translate([c30*lfp,+s30*lfp,-d])
			{	
				cylinder(r=lfr, h=rt+2*d);
				translate([0,-lfr,0]) cube(size=[ll, lfr*2, rt+2*d] );
			}
    		}
		union()
        {
			translate([0,0,rt-bh]) cylinder(r1=od/2, r2=od/2-bh*2, h=bh);
        		translate([0,0,-bh]) cylinder(r=ll+d, h=rt);
      	}
	}
}

// Actual objects here

ll = 10;
for (xo = [-ll, ll])
{
	for ( yo = [-ll, ll])
	{
		translate([xo, yo, 0])
			PrintBedRetainer(10, 4, 4, 1, 1, ll, 3, 1);
	}
}

