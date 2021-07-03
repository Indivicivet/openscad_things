translate([15 * i, 15 * j, 0])
scale(0.5)
difference() {
    cylinder(r=12, h=2, $fn=50, center=true);
        ;

    translate([-7, 0])
    {
        linear_extrude(height=2)
        {
            translate([0, 1, 0])
            text("+1", font="Corbel:style=Bold")
                ;
            
            translate([0, -7, 0])
            text("+1", font="Corbel:style=Bold")
                ;
        }
    }
        ;
}
