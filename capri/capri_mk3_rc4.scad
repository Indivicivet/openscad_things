
axle_mount_width = 5;

r_axle = 3 - 0.4;
r_add_nobble = 0.35;  // was 0.4 (too tight)
r_add_entrance = 0.45;  // was also 0.4 :p (in too-tight combo)
r_add_interior = 0.8;  // was 0.9

fn_axle = 25;

// base / body
module body() {
    difference() {
        union() {
            color([1, 0.3, 0.3, 0.7])
            hull() {
                rotate([90, 0, 0])
                linear_extrude(49.8 * 2, center=true) // 56 * 2 to sides
                polygon([
                    [-62, 0],
                    [65, 0],  // start wheelarch
                    [118, 0], // end wheelarch
                    // was:
                    /*[137, 0],
                    [137, 1.5],
                    [136, 2.8],*/
                    [134.5, 0],
                    [134.5, 1.5],
                    [134.5, 2.8],
                    [135.5, 4],
                    [135.5, 6],
                    [136, 8],
                    [137, 9.5],
                    [139, 11],
                    [142, 18],
                    [143, 22],
                    //[143.7, 32],
                    [144, 32],
                    [141.8, 34],
                    [139, 35],
                    [135, 36],
                    [130, 37.1],
                    [124, 38.2],
                    [118, 39.4],
                    [112, 40.5],
                    [100, 42],
                    [88, 43],
                    [70, 43.9],
                    [55, 44.8],
                    [30, 45],
                    [-120, 45],
                    [-130, 44],
                    [-135, 43],
                    //[-140, 42],
                    [-142.3, 42],
                    //[-143.3, 39.8],
                    //[-144.3, 38],
                    //[-144.8, 37],
                    // WAS: [-146.5, 33], AND: [-145.5, 27],
                    [-146.5, 32.5],
                    //olddd[-147, 32],
                    //olddd[-145.8, 33],
                    //[-144.8, 23],
                    [-145, 20],
                    [-142.5, 15],
                    [-141, 11.5],
                    [-138, 8],
                    [-136, 7],
                    [-136 + 7 * 1.6, 0],  // was *1.7
                    //[-62, 10], // just for testing
                ])
                    ;
                // outer part of loft
                for (sgn = [-1, 1]) {
                    translate([0, sgn * 56, 0])
                    // TODO :: figure out if I like this slight slant
                    // and if I want more
                    translate([0, sgn * (-3), 0]) // without slant: -0
                    rotate([-5 * sgn, 0, 0]) // the slant
                    // :: end
                    rotate([90, 0, 0])
                    linear_extrude(0.01, center=true)
                    polygon([
                        [105, 15], // end wheelarch
                        [108, 17],
                        [108, 20],
                        [100, 28],

                        [-105, 32],
                        [-115, 30],
                        [-120, 27],
                        [-117, 17],
                        [-110, 12],
                    ])
                        ;
                }
                    ;
            }
                ;
            // ford + grille
            translate([142.5, 0, 26])
            union() {
                rotate([0, 90 + 5, 0])
                scale([1, 2, 1])
                cylinder(r=2.5, h=2, $fn=15)
                    ;
                rotate([0, 5, 0])
                for (i = [-2:2]) {
                    translate([1, 0, i * 2])
                    scale([0.7, 1, 1])
                    rotate([90, 0, 0])
                    cylinder(r=1, h=30*2, center=true, $fn=3)
                        ;
                }
            }
                ;
            // front+back bumper
            color([0.2, 1, 0.5, 0.7])
            for (xzoffs = [[-120, 15], [118, 13]]) {
                translate([xzoffs[0], 0, xzoffs[1]])
                linear_extrude(6)
                minkowski() {
                    square([50, (55 - 4) * 2], center=true)
                        ;
                    circle(r=4)
                        ;
                }
                    ;
            }
                ;
            // the middle bit between bumpers
            color([0.2, 1, 0.5, 0.7])
            for (sgn = [-1, 1]) {
                translate([0, sgn * 53.5, 14])
                difference() {
                    rotate([0, 90, 0])
                    cylinder(h=180, r=2.5, $fn=8, center=true)
                        ;
                    translate([30, sgn * 3.5, 0])
                    cube([6, 4, 99], center=true)
                        ;
                    for (xoffs = [-45, 33]) {
                        translate([xoffs, sgn * 3, 0])
                        cube([1.5, 99, 99], center=true)
                            ;
                    }
                        ;
                }
                    ;
            }
                ;
            // rear headlights
            for (sgn = [-1, 1]) {
                translate([-145, 34 * sgn, 27])
                rotate([0, -5, 0])
                cube([3, 30, 9], center=true)
                    ;
            }
                ;
            // exhaust
            translate([-137, 33, 2])
            rotate([0, 90, 0])
            cylinder(r=2, h=30, $fn=15)
                ;
            // spoiler!!
            rotate([90, 0, 0])
            linear_extrude(47 * 2, center=true)
            translate([-1, 1])  // initially was a slightly diff shell :)
            polygon([
                [-145, 43],
                [-145, 42],
                [-143, 40],
                [-143.5, 37],
                [-135, 30], // bonus internal for better back shape
                [-135, 42.5],
                [-137, 43],
            
                // idk?
                //[-135, 45],
            ])
                ;
            // wheel arch tops
            /*
            for (sgn = [-1, 1]) {
                for (xoffs = [-86, 91]) {
                    translate([xoffs, sgn * 46, 8.5])
                    sphere(r=25, $fn=60)
                        ;
                }
            }
                ;
            */
        }
            ;
        // nonconvexity front
        rotate([90, 0, 0])
        linear_extrude(999, center=true)
        polygon([
            [137, 0],
            [137, 1.5],
            [136, 2.8],
            [135.5, 4],  // TODO :: SORT OUT NONCONVEX AROUND HERE
            [135.5, 6],
            [136, 8],
            [137, 9.5],
            [139, 11],
            //[142, 18],
        
            [150, 12], // directionality
        ])
            ;
        // nonconvexity/nonextrusion hood
        difference() {
            translate([0, 0, -1.2]) // without tilt: -1.2
            rotate([0, -0.2 , 0])
            rotate([90, 0, 0])
            linear_extrude(23 * 2, center=true)
            polygon([
                [144, 32.5],
                [141.5, 34],
                [139, 35],
                [135, 36],
                [130, 37.1],
                [124, 38.2],
                [118, 39.4],
                [112, 40.5],
                [100, 42],
                [88, 43],
                [70, 43.9],
                [55, 44.8],
                [49.5, 45],
                //[20, 45],
                
                [50, 100], // directionality
                [154, 32.5], // out the front??
            ])
                ;
            translate([0, 0, 42])
            linear_extrude(3, center=true)
            minkowski() {
                polygon([
                    [20, 7],
                    [20, -7],
                    [88, -7],
                    [92, 0],
                    [88, 7],
                ])
                    ;
                circle(r=8)
                    ;
            }
                ;
        }
            ;
        // bonnet lines -- copied from above nonconvexity hood
        // TODO :: undecided if I like these or not, probs overkill
        /*
        for (sgn = [-1, 1]) {
            translate([0, sgn * 44, -1.2])
            rotate([90, 0, 0])
            linear_extrude(1.2, center=true)
            polygon([
                [144, 32.5],
                [141.5, 34],
                [139, 35],
                [135, 36],
                [130, 37.1],
                [124, 38.2],
                [118, 39.4],
                [112, 40.5],
                [100, 42],
                [88, 43],
                [70, 43.9],
                [55, 44.8],
                [49.5, 45],
                
                //[20, 45],
                
                [50, 100], // directionality
                [154, 32.5], // out the front??
            ])
                ;
        }
            ;
        */
        // wheel arches
        for (sgn = [-1, 1]) {
            for (xoffs = [-86, 91]) {
                translate([xoffs, 56 * sgn, 1.5])
                rotate([90, 0, 0])
                cylinder(r=24 + 2 - 0.75, h=21 * 2, center=true)
                    ;
            }
        }
            ;
        // headlights
        for (sgn = [-1, 1]) {
            translate([145, 38 * sgn, 26])
            rotate([0, 5, 0])
            cube([5, 22, 10], center=true)
                ;
        }
        // rear number plate
        translate([-147, 0, 28])
        difference() {
            cube([5, 36, 8], center=true)
                ;
            translate([0, 0, 7])
            rotate([0, 45, 0])
            cube([99, 99, 4], center=true)
                ;
        }
        // axles?!
        for (xoffs = [-86, 91]) {
            for (radwidth = [
                [r_axle + r_add_entrance, 999],
                [r_axle + r_add_interior, (56-21-axle_mount_width) * 2],
            ]) {
                translate([xoffs, 0, 4])
                rotate([90, 0, 0])
                linear_extrude(radwidth[1], center=true)
                // semi-teardrop
                union() {
                    circle(r=radwidth[0], $fn=fn_axle)
                        ;
                    translate([0, 0.55])
                    scale([1, 0.75])
                    rotate(45)
                    square(radwidth[0])
                        ;
                }
                    ;
            }
        }
            ;
        // model number etc
        translate([0, 0, -0.01])
        rotate([0, 180, 0])
        linear_extrude(0.2, center=true)
        rotate(180)
        union() {
            translate([0, 7, 0])
            text(
                "Capri 280",
                size=5,
                valign="center", halign="center"
            )
                ;
            translate([0, -7, 0])
            text(
                "\"Brooklands\"",
                size=5,
                valign="center", halign="center"
            )
                ;
        }
            ;
    }
        ;

    color([1, 0.6, 0.1, 0.75])
    difference() {
        hull() {
            // baseplate, gives min of windscreen
            translate([-48, 0, 44.5])
            cube([152, 50 * 2, 0.1], center=true)
                ;
            // far back
            translate([-132, 0, 43])
            cube([0.1, 48 * 2, 0.1], center=true)
                ;
            // top of roof
            translate([-85, 0, 65])
            cube([0.1, 32 * 2, 0.1], center=true)
                ;
            translate([-70, 0, 70])
            cube([0.1, 33 * 2, 0.1], center=true)
                ;
            translate([-60, 0, 72])
            cube([0.1, 34 * 2, 0.1], center=true)
                ;
            translate([-18, 0, 73])
            cube([0.1, 36 * 2, 0.1], center=true)
                ;
            translate([-5, 0, 73])
            cube([0.1, 36 * 2, 0.1], center=true)
                ;
            translate([5, 0, 72])
            cube([0.1, 37 * 2, 0.1], center=true)
                ;
            translate([11, 0, 70])
            cube([0.1, 38 * 2, 0.1], center=true)
                ;
            // windscreen stuff
            translate([39, 0, 43])
            cube([0.1, 45 * 2, 0.1], center=true)
                ;
            translate([44, 0, 43])
            cube([0.1, 39 * 2, 0.1], center=true)
                ;
            translate([48, 0, 43])
            cube([0.1, 26 * 2, 0.1], center=true)
                ;
            // just for ref
            //translate([35, 0, 50])
            //cube([0.1, 40 * 2, 0.1], center=true)
                //;
        }
            ;
        hull() {
            // far back
            translate([-135, 0, 42])
            cube([0.1, 50 * 2, 0.1], center=true)
                ;
            translate([-125, 0, 45.5])
            cube([0.1, 50 * 2, 0.1], center=true)
                ;
            translate([-120, 0, 48])
            cube([0.1, 50 * 2, 0.1], center=true)
                ;
            translate([-110, 0, 52])
            cube([0.1, 50 * 2, 0.1], center=true)
                ;
            translate([-100, 0, 58])
            cube([0.1, 50 * 2, 0.1], center=true)
                ;
            translate([-90, 0, 63])
            cube([0.1, 50 * 2, 0.1], center=true)
                ;
            // orientation
            translate([-80, 0, 100])
            cube([0.1, 50 * 2, 0.1], center=true)
                ;
        }
            ;
        
    }
        ;
}

wheel_inner_r = 3;

// wheel time
module wheel() {
    difference() {
        minkowski() {
            cylinder(r=21 - 3, h=16 - 3 * 2, center=true)
                ;
            sphere(r=3)
                ;
        }
            ;
        translate([0, 0, 5])
        cylinder(r1=12, r2=16, h=8, center=true, $fn=30)
            ;
        //cylinder(r=wheel_inner_r, h=99, center=true)
        //    ;
        // treads
        for (i = [1:15]) {
            rotate(i * 360 / 15)
            translate([21, 0, 0])
            rotate([20, 0, 0])
            linear_extrude(99, center=true)
            circle(r=0.5, $fn=12)
                ;
        }
            ;
        // treads part 2
        for (z = [-3, 0, 3]) {
            translate([0, 0, z])
            linear_extrude(1, center=true)
            difference() {
                circle(r=50)
                    ;
                circle(r=21 - 0.4)
                    ;
            }
        }
            ;
    }
        ;
    translate([0, 0, -5])
    difference() {
        linear_extrude(12.85)
        difference() {
            circle(r=17)
                ;
            //circle(r=wheel_inner_r, $fn=20)
            //    ;
        }
            ;
        //linear_extrude(13)
        for (i = [1:7]) {
            rotate(i * 360 / 7)
            translate([15, 0, 17])
            scale([1.9, 1.2, 2.3])
            sphere(4, $fn=30)
                ;
        }
            ;
        // ford again
        translate([0, 0, 15])
        linear_extrude(5, center=true)
        difference() {
            scale([2, 1])
            circle(r=2, $fn=20)
                ;
            scale([1.8, 0.85])
            circle(r=2, $fn=20)
                ;
        }
    }
        ;
    translate([0, 0, -8])
    rotate([0, 180, 0])  // shift to positive space :)
    union() {
        cylinder(r=r_axle, h=32, $fn=fn_axle)
            ;
        translate([0, 0, 32])
        hull() {
            sphere(r=r_axle, $fn=fn_axle)
                ;
            translate([0, 0, r_axle * 1.2])
            sphere(r=r_axle * 0.4, $fn=fn_axle)
                ;
        }
            ;
        translate([0, 0, 0.5])
        cylinder(r1=r_axle, r2=r_axle + r_add_nobble + 0.2, h=2, $fn=fn_axle)
            ;
        translate([0, 0, 2.5])
        cylinder(r1=r_axle + r_add_nobble + 0.2, r2=r_axle, h=1, $fn=fn_axle)
            ;
        translate([0, 0, 4 + axle_mount_width])
        cylinder(r1=r_axle, r2=r_axle + r_add_nobble, h=1, $fn=fn_axle)
            ;
        translate([0, 0, 4 + axle_mount_width + 1])
        cylinder(r1=r_axle + r_add_nobble, r2=r_axle, h=2, $fn=fn_axle)
            ;
        // bonus sheath (overlaps above) for connection stability
        cylinder(r1 = r_axle*2.25, r2=r_axle * 2, h=1.5, $fn=fn_axle)
            ;
        translate([0, 0, 1.5])
        cylinder(r1=r_axle * 2, r2 = r_axle + r_add_nobble + 0.2, h=1, $fn=fn_axle)
            ;
    }
}

module test_arch(shift_y=5, max_y=35) {
    intersection() {
        body()
            ;
        translate([82, shift_y, -5])
        cube([18, 999, max_y + 5])
            ;
    }
        ;
}



module assembled_wheels() {
    color([1, 0.2, 1, 0.7])
    for (sgn = [-1, 1]) {
        for (xoffs = [-86, 91]) {
            translate([xoffs, 47 * sgn, 4])
            rotate([90 * (1 + sgn), 0, 0])
            rotate([90, 0, 0])
            wheel()
                ;
        }
    }
        ;
}

FULL_CAR = 1;
BODY = 2;
WHEEL = 30;
ALL_WHEELS = 31;
TEST_ARCH_MATCHES = 40;
TEST_ARCH_SOLO = 41;

ASSEMBLY = FULL_CAR;

if (ASSEMBLY == FULL_CAR) {
    body()
        ;
    assembled_wheels()
        ;
}
if (ASSEMBLY == BODY) {
    body()
        ;
}
if (ASSEMBLY == WHEEL) {
    translate([0, 0, 8])
    rotate([0, 180, 0])
    wheel()
        ;
}
if (ASSEMBLY == ALL_WHEELS) {
    assembled_wheels()
        ;
}
if (ASSEMBLY == TEST_ARCH_MATCHES) {
    test_arch(shift_y=30)
        ;
    assembled_wheels()
        ;
}
if (ASSEMBLY == TEST_ARCH_SOLO) {
    test_arch(max_y=10)
        ;
}
