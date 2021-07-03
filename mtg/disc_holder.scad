$fn = 50;

base = 2;
tall = 1.1*18;
toply = 2;


difference() {
    union() {
        difference() {
            cylinder(r=9, h=tall + base + toply)
                ;
            {
                translate([0, 0, base])
                cylinder(r=6.5, h=tall + toply + 0.1)
                    ;
            }
                ;
        }
            ;
        translate([16, 0, 0])
        difference() {
            cylinder(r=9, h=tall + base + toply)
                ;
            translate([0, 0, base])
            cylinder(r=6.5, h=tall + toply + 0.1)
                ;
        }
            ;
    }  
        ;
    union() {
        translate([0, 0, tall + base + 1.75])
        rotate([180, 0, 0])
        rotate([0, 90, 0])
        linear_extrude(h=15)
        circle(r=3.5, $fn=3)
            ;
        // nobble
        translate([-7.5, 0, tall + base + 1.75 + 0.8])
        rotate([90, 0, 0])
        cylinder(r=0.9, center=true)
            ;
    }
        ;
}

rotate([180, 0, 0])
translate([0, 20, 0])
difference() {
    translate([0, 0, -(tall + base + toply + 2)])
    {
        translate([0, 0, tall + base + toply])
        cylinder(r=9, h=2)
            ;
        translate([16, 0, 0])
        translate([0, 0, tall + base + toply])
        cylinder(r=9, h=2)
            ;
        // nobble
        translate([-7.5, 0, tall + base + 1.75 + 0.8 + 0.05])
        rotate([90, 0, 0])
        cylinder(r=0.9, center=true)
            ;
        intersection() {
            union() {
                cylinder(r=9, h=tall + base + toply)
                    ;
                translate([16, 0, 0])
                cylinder(r=9, h=tall + base + toply)
                    ;
            }
                ;
            translate([0, 0, 0.25])  // lil tolerance
            translate([-3, 0, 0])
            translate([0, 0, tall + base + 1.75])
            rotate([180, 0, 0])
            rotate([0, 90, 0])
            linear_extrude(h=15)
            circle(r=3.5, $fn=3)
                ;
        }
            ;
    }
        ;
    translate([0, -3, -1])
    linear_extrude(height=2)
    {
        translate([-7.5, 0, 0])
        scale(0.9)
        text("+1", font="Corbel:style=Bold")
            ;
        
        translate([9, 0, 0])
        scale(0.9)
        text("+1", font="Corbel:style=Bold")
            ;
    }
}
    ;
