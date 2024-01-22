LM_OFFCENTER = 54;  // centering looks very close

module centered_lens_mount() {
    translate([-0.5, 0.5, 0] * LM_OFFCENTER)
    rotate([90, 0, 0])
    import("u43 lens mount.STL")
        ;
}


module rot_stopper() {
    for (i=[0:100])
    rotate([0, 0, -i * 0.5])
    translate([20, 0, 0])
    translate([-0.5, -0.5, 0])
    cube([1, 1, 0.4 * (i < 90 ? 1 : 1 - ((i-90)/10)) + 0.8 + exp(-i / 20)])
        ;
}


color("red")
for (theta=[9.5, 116, 235])
rotate([0, 0, theta])
rot_stopper()
    ;

translate([0, 0, 20])
centered_lens_mount()
    ;
