module mirror_copy(vec=[1, 0, 0])
{
    children();
    mirror(vec) children();
}

$fn = 20;

orig_height = 144.7;
orig_width = 70.4;
orig_depth = 8;

space_tol = 1;
space_tol_z = 0.5;
height = orig_height * 0.6;
width = orig_width + 2 * space_tol;
depth = orig_depth + 2 * space_tol_z;

thickness = 3;
eps = 0.01;
big = 99;

angle = 20;

show(false)
color("red")
translate([0, (height - orig_height) / 2, 0])
cube([orig_width, orig_height, orig_depth], center=true)
    ;

// backplane
//show(false)
translate([0, space_tol, 0])
{
    difference() {
        // main surrounding
        translate([0, thickness / 2, 0])
        cube(
            [
                width + thickness * 2,
                height + thickness,
                depth + 2 * thickness
            ],
            center=true
        )
            ;
        // cut out phone and phone jack
        {
            translate([0, 0, thickness/2])
            cube(
                [width, height + eps, depth + thickness + eps],
                center=true
            )
                ;
            translate([0, height/2 + thickness, 0])
            cylinder(r=10, h=100, center=true)
                ;
        }
            ;
    }
        ;
    // add bits to keep phone in
    mirror_copy()
    intersection() {
        translate([width / 2, height / 2, depth / 2 + thickness / 2])
        cylinder(h=thickness, r=15, center=true, $fn=50)
            ;
        cube([width / 2 + thickness, height / 2, 100])
            ;
    }
        ;
}
    ;

stem_length = 95;
stem_radius = 3.5;

stem_count = 4;
stem_spacing = 0.9 * width / stem_count;

stem_offset = height * 0.2 - 20;

base_thickness = 5;
base_behind = 15 + 0.75 * height;
base_front = 15;

cutout_size = 0.7;

// stand stem and base
difference() {
    translate([0, stem_offset, space_tol_z])
    rotate([-angle, 0, 0])
    union() {
        // stems
        for (i = [1:stem_count]) {
            translate([
                stem_spacing * (i - 1/2 - stem_count / 2),
                stem_length/2,
                0
            ])
            rotate([90, 0, 0])
            cylinder(h=stem_length, r=stem_radius, center=true)
                ;
        }
            ;
        // base with cutout
        difference() {
            minkowski() {
                translate(
                    [-width/2, stem_length, -base_behind]
                )
                cube([
                    width,
                    base_thickness,
                    base_behind + base_front
                ])
                    ;
                rotate([90, 0, 0])
                cylinder(r=5, h=eps);
            }
                ;
            translate([
                -width * cutout_size / 2,
                stem_length - big/2,
                -base_behind * (0.5 + 0.5 * cutout_size)
            ])
            cube([
                width * cutout_size,
                big,
                base_behind * cutout_size
            ])
                ;
        }
            ;
    }
        ;
    translate([0, big, big])
    cube(
        [
            width,
            height + 2 * thickness * 2 * big,
            depth + 2 * thickness + 2 * big
        ],
        center=true
    )
        ;
}
    ;