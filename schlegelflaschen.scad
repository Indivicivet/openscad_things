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

CAN_D = 59;

CAN_CYLINDER = true;
CAN_RIM_H = 15;

PRONGS = false;

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

SHOE_H = D_BASE * sin(ANGLE) * 0.9;

CAN_Z = H * cos(ANGLE) / 2 * 0.75;
echo(CAN_Z);

module angled_schlegelflaschen(expand_r=0)
translate([0, 0, D_BASE * sin(ANGLE) / 2])
rotate([0, ANGLE, 0])
schlegelflaschen(expand_r=expand_r)
    ;

module can_330(expand_r=0)
linear_extrude(115.2)
circle(d=CAN_D + expand_r * 2)
    ;

module can_440(expand_r=0)
linear_extrude(150)
circle(d=CAN_D + expand_r * 2)
    ;

module can_pos_xy()
// completely eyeballed can balance pos
translate([-50 * sin(ANGLE), 0])
children()
    ;

module schlegelflaschen_holder()
difference() {
    union() {
        intersection() {
            intersection() {
                angled_schlegelflaschen(expand_r=SHELL_OUTER)
                    ;
                // rotated AND expanded schlegelflaschen will go z<0
                // (this is fine, we want the normal rotated one to hit z=0)
                linear_extrude(999)
                square(999, center=true)
                    ;
            }
            // angular cutoff to support bottle, kinda arbitrary
            rotate([0, -22, 0])
            linear_extrude(H * cos(ANGLE) / 2 * 0.9, center=true)
            square(999, center=true)
                ;
        }
            ;
        hull() {
            intersection() {
                angled_schlegelflaschen(expand_r=SHELL_OUTER)
                    ;
                linear_extrude(SHOE_H)
                square(999, center=true)
                    ;
            }
                ;
            linear_extrude(5)
            translate([H * sin(ANGLE) * 0.35, 0])
            circle(d=D_BASE)
                ;
            if (CAN_CYLINDER)
            linear_extrude(SHOE_H)
            can_pos_xy()
            circle(d=CAN_D + 10)
                ;
            if (!CAN_CYLINDER)
            linear_extrude(10)
            circle(d=D_BASE * 0.4)
                ;
        }
            ;
        if(CAN_CYLINDER)
        can_pos_xy()
        difference() {
            linear_extrude(CAN_Z + CAN_RIM_H)
            circle(d=CAN_D + 10)
                ;
            translate([0, 0, CAN_Z])
            can_440(expand_r=2)
                ;
        }
            ;
    }
        ;
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

if (CAN_CYLINDER)
color("blue", alpha=0.5)
translate([0, 0, CAN_Z])
can_pos_xy()
can_440()
    ;

color(alpha=0.5)
schlegelflaschen_holder()
    ;
