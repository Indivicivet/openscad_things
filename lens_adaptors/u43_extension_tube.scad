CM_OFFCENTER = 53;  // centering looks exact?
LM_OFFCENTER = 54;  // centering looks very clclose

SLICE_THICK = 0.05;
SLICE_FROM_H = 2;
TUBE_EXT_NOT_INCLUDING_MOUNTS = 20;


module centered_camera_mount() {
    translate([-0.5, 0.5, 0] * CM_OFFCENTER)
    rotate([90, 0, 0])
    import("u43 camera mount.STL")
        ;
}


module camera_mount_top_slice(thick=1) {
    scale([1, 1, thick / SLICE_THICK])
    intersection() {
        translate([0, 0, -SLICE_FROM_H])
        centered_camera_mount()
            ;
        cylinder(r=999, h=SLICE_THICK)
            ;
    }
        ;
}


module centered_lens_mount() {
    translate([-0.5, 0.5, 0] * LM_OFFCENTER)
    rotate([90, 0, 0])
    import("u43 lens mount.STL")
        ;
}


// stick the lens in here
centered_camera_mount()
    ;

translate([0, 0, SLICE_FROM_H])
camera_mount_top_slice(thick=TUBE_EXT_NOT_INCLUDING_MOUNTS - SLICE_FROM_H)
    ;

translate([0, 0, TUBE_EXT_NOT_INCLUDING_MOUNTS])
centered_lens_mount()
    ;