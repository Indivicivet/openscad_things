
base_h = 8;
base_r = 45;
model_scale = 0.5;

cylinder(r=base_r, h=base_h, $fn=50)
    ;

translate([0, 0, base_h])
scale(model_scale)
// preview vs render
//import("generate_tree_test_v2_awesome_out[fullsize].stl")
include <generate_tree_test_v2_awesome_out.scad>
    ;
