$fn = 40;

module half_circle(r) {
    intersection() {
        circle(r)
            ;
        translate([0, -r * 1.5])
        square(r * 3)
            ;
    }
        ;
}

module pawn_curve_poly() {
    scale([1.2, 0.9])
    polygon([
        [0, 0],
        [10, 0],
        [10, 3],
        [9.5, 5],
        [8, 8],
        [6.5, 12],
        [5, 20],
        [4, 30],
        [4, 35],
        [5.5, 40],
        [4, 44],
        [0, 50],
    ])
        ;
}

module pawn() {
    rotate_extrude()
    union() {
        pawn_curve_poly()
            ;
        translate([0, 44.5])
        half_circle(9)
            ;
    }
        ;
}

module bishop() {
    difference() {
        rotate_extrude()
        union() {
            scale([1.2, 1.2])
            pawn_curve_poly()
                ;
            hull() {
                translate([0, 51])
                half_circle(9)
                    ;
                translate([0, 75])
                square([3, 0.01])
                //translate([0, 76])
                //half_circle(3)
                    ;
            }
                ;
        }
            ;
        translate([7, 0, 71])
        rotate([0, 30, 0])
        cube([3, 50, 32], center=true)
            ;
    }
        ;
}

module knight() {
    rotate_extrude()
    scale([1.2, 1.2])
    pawn_curve_poly()
        ;
    translate([0, 0, 51])
    union() {
        hull() {
            sphere(r=9)
                ;
            translate([0, 0, 7.5])
            sphere(r=10)
                ;
        }
            ;
        hull() {
            translate([0, 0, 7.5])
            sphere(r=10)
                ;
            translate([12, 0, 17])
            rotate([0, 55, 0])
            cube([10, 7, 0.01], center=true)
                ;
        }
            ;
        translate([-1.8, 0, 8])
        scale([1, 1, 1.15])
        rotate([90, 0, 0])
        cylinder(r=11, h=5, center=true)
            ;
    }
        ;
}

module rook() {
    rotate_extrude()
    union() {
        scale([1.2, 1.2])
        pawn_curve_poly()
            ;
        hull() {
            translate([0, 51])
            half_circle(9)
                ;
            translate([0, 60])
            square([10, 0.01])
            //translate([0, 76])
            //half_circle(3)
                ;
        }
            ;
    }
        ;
    translate([0, 0, 60])
    linear_extrude(5)
    difference() {
        circle(10)
            ;
        circle(7)
            ;
        for (angle = [0, 90]) {
            rotate(angle)
            square([4, 99], center=true)
                ;
        }
            ;
    }
}

module queen() {
    rotate_extrude()
    union() {
        scale([1.2, 1.4])
        pawn_curve_poly()
            ;
        hull() {
            translate([0, 62.5])
            half_circle(12)
                ;
            translate([0, 67.5])
            square([11, 3])
                ;
        }
            ;
    }
        ;
    translate([0, 0, 65])
    for (i = [0:7]) {
        rotate(i * 360 / 8)
        translate([9, 0, 0])
        rotate([0, 20, 0])
        union() {
            cylinder(r1=3, r2=1.5, h=14, $fn=6)
                ;
            translate([0, 0, 14])
            sphere(r=3)
                ;
        }
    }
}

module king() {
    rotate_extrude()
    union() {
        scale([1.2, 1.4])
        pawn_curve_poly()
            ;
        hull() {
            translate([0, 62.5])
            half_circle(12)
                ;
            translate([0, 67.5 + 5])
            square([9.5, 3])
                ;
            translate([0, 70])
            half_circle(8)
                ;
        }
            ;
    }
        ;
    //translate([0, 0, 77])
    //cylinder(r=10, h=6, center=true)
    //        ;
    //translate([0, 0, 84])
    translate([0, 0, 73.5 + 7])
    rotate([90, 0, 0])
    cylinder(r=3.5, h=3, center=true)
        ;
    /*rotate([0, 90, 0])
    union() {
        cube([5, 4, 21], center=true)
            ;
        cube([5, 21, 4], center=true)
            ;
    }
        ;*/
    //translate([0, 0, 72.5])
    //cylinder(r=7, h=3, center=true)
        //;
    //translate([0, 0, 76])
    //sphere(r=2)
        //;
}

module board_layout_1side(square_size=40) {
    for (i = [1, 8]) {
        translate([square_size * (i - 1), 0, 0])
        rook()
            ;
    }
        ;
    for (i = [2, 7]) {
        translate([square_size * (i - 1), 0, 0])
        knight()
            ;
    }
        ;
    for (i = [3, 6]) {
        translate([square_size * (i - 1), 0, 0])
        bishop()
            ;
    }
        ;
    translate([square_size * (4 - 1), 0, 0])
    queen()
        ;
    translate([square_size * (5 - 1), 0, 0])
    king()
        ;
    for (i = [1:8]) {
        translate([square_size * (i - 1), square_size, 0])
        pawn()
            ;
    }
}

module board_layout(square_size=40) {
    color([1, 1, 1])
    board_layout_1side(square_size=square_size)
        ;
    color([0.2, 0.2, 0.2])
    translate([0, square_size * 7, 0])
    mirror([0, 1, 0])
    board_layout_1side(square_size=square_size)
        ;
}

PAWN = 1;
BISHOP = 2;
ROOK = 3;
QUEEN = 4;
KING = 5;
KNIGHT = 6;

ASSORTED = 91;
BOARD_LAYOUT = 92;
BOARD_LAYOUT_1SIDE = 93;

RENDER = BOARD_LAYOUT;

if (RENDER == PAWN) {
    pawn()
        ;
}
if (RENDER == BISHOP) {
    bishop()
        ;
}
if (RENDER == ROOK) {
    rook()
        ;
}

if (RENDER == QUEEN) {
    queen()
        ;
}
if (RENDER == KING) {
    king()
        ;
}
if (RENDER == KNIGHT) {
    knight()
        ;
}
if (RENDER == ASSORTED) {
    translate([0, 40, 0])
    pawn()
        ;    
    translate([-40, 0, 0])
    bishop()
        ;
    rook()
        ;
    translate([-40, 40, 0])
    queen()
        ;
    translate([40, 40, 0])
    king()
        ;
    translate([40, 0, 0])
    knight()
        ;
}
if (RENDER == BOARD_LAYOUT_1SIDE) {
    board_layout_1side()
        ;
}
if (RENDER == BOARD_LAYOUT) {
    board_layout()
        ;
}
