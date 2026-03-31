// schlegelflaschen too tall to store vertically?

H = 350; // can be 330
H_BODY = 130;
H_SHOULDER = 130;
D_BASE = 75;
D_NECK = 29;

SHELF_Z = 328;
TARGET_Z = SHELF_Z;

SHELL_OUTER = 7;
SHELL_THICK = 4;

module schlegelflaschen(expand_r=0)
rotate_extrude()
polygon([
    [0, 0],
    [D_BASE / 2 + expand_r, 0],
    [D_BASE / 2 + expand_r, H_BODY],
    [D_NECK / 2 + expand_r, H_BODY + H_SHOULDER],
    [D_NECK / 2 + expand_r, H],
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
echo(ANGLE);

module angled_schlegelflaschen(expand_r=0)
translate([0, 0, D_BASE * sin(ANGLE) / 2])
rotate([0, ANGLE, 0])
schlegelflaschen(expand_r=expand_r)
    ;

module schlegelflaschen_holder()
difference() {
    union() {
        intersection() {
            angled_schlegelflaschen(expand_r=SHELL_OUTER)
                ;
            linear_extrude(H * cos(ANGLE) / 2 * 0.85)
            square(999, center=true)
                ;
            rotate([0, -25, 0])
            linear_extrude(H * cos(ANGLE) / 2 * 0.9, center=true)
            square(999, center=true)
                ;
        }
            ;
        intersection() {
            translate([0, 0, 20])  // magic number, should be angle-dep
            sphere(d=D_BASE + SHELL_OUTER * 2)
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
    angled_schlegelflaschen(expand_r=SHELL_OUTER - SHELL_THICK)
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

