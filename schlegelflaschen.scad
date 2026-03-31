// schlegelflaschen too tall to store vertically?

H = 330;
H_BODY = 130;
H_SHOULDER = 130;
D_BASE = 75;
D_NECK = 29;

SHELF_Z = 310;
TARGET_Z = SHELF_Z;

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
rotate([ANGLE, 0, 0])
schlegelflaschen(expand_d=expand_d)
    ;

color("red", alpha=0.3)
translate([0, 0, SHELF_Z])
linear_extrude(2)
square(500, center=true)
    ;

angled_schlegelflaschen()
    ;
