gap_h = 70;
top_h = 10;
gap_w = 70;
side_w = 10;
total_w = gap_w + side_w * 2;
total_h = gap_h + top_h;
thick = 6;
holder_pos = gap_w * 0.5;
holder_w = 10;
holder_vdist = 30;
holder_out = 50;
holder_t = 4;

linear_extrude(thick)
union() {
    difference() {
        square([total_w, total_h])
            ;
        translate([side_w, -0.01])
        square([gap_w, gap_h])
            ;
    }
        ;
    translate([side_w + holder_pos - holder_w / 2, total_h])
    square([holder_w, holder_vdist])
        ;
}
    ;

translate([side_w + holder_pos - holder_w / 2, total_h + holder_vdist])
union() {
    cube([holder_w, holder_t, holder_out])
        ;
    translate([0, holder_t, holder_out])
    for (v = [0, 15]) {
        translate([holder_w / 2, 0, -v])
        rotate([45, 0, 0])
        cube([holder_w, holder_t, holder_t], center=true)
            ;
    }
        ;
}
    ;
