// schlegelflaschen too tall to store vertically?

H = 330;
H_BODY = 130;
H_SHOULDER = 130;
D_BASE = 75;
D_NECK = 29;

SHELF_Z = 310;
TARGET_Z = SHELF_Z;

SHELL_PLUS_D = 10;

module schlegelflaschen(expand_d=0)
rotate_extrude()
polygon([
    [0, 0],
    [(D_BASE + expand_d) / 2, 0],
    [(D_BASE + expand_d) / 2, H_BODY],
    [(D_NECK + expand_d) / 2, H_BODY + H_SHOULDER],
    [(D_NECK + expand_d) / 2, H],
    [0, H]
])
    ;

// exact angle to fit a section of a cone in
// (i.e. we solve `H cos(x) + [average]W sin(x) = T` for x)
function angle_fit(h, w, t) = 2 * atan(
    (w + sqrt(h * h + w * w - t * t))
    / (h + t)
)
    ;

ANGLE = angle_fit(H, (D_BASE + D_NECK) / 2, TARGET_Z);

module angled_schlegelflaschen(expand_d=0)
translate([0, 0, D_BASE * sin(ANGLE) / 2])
rotate([0, ANGLE, 0])
schlegelflaschen(expand_d=expand_d)
    ;

module schlegelflaschen_holder()
difference() {
    union() {
        intersection() {
            angled_schlegelflaschen(expand_d=SHELL_PLUS_D)
                ;
            linear_extrude(H * cos(ANGLE) / 2 * 0.85)
            square(999, center=true)
                ;
        }
            ;
        intersection() {
            translate([0, 0, 20])  // magic number, should be angle-dep
            sphere(d=D_BASE + SHELL_PLUS_D)
                ;
            linear_extrude(999)
            square(999, center=true)
                ;
        }
        linear_extrude(10)
        hull() {
            circle(d=(D_BASE + SHELL_PLUS_D) * 0.95)
                ;
            translate([H * sin(ANGLE) * 0.6, 0])
            circle(d=D_BASE)
                ;
        }
            ;
    }
    angled_schlegelflaschen(expand_d=5)
        ;
}
    ;

color("red", alpha=0.3)
translate([0, 0, SHELF_Z])
linear_extrude(2)
square(500, center=true)
    ;

color("green", alpha=0.5)
angled_schlegelflaschen()
    ;

schlegelflaschen_holder()
    ;

