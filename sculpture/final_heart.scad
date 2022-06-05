
module heart(
    core_size = 30,
    rel_translate = 0.8,
    rel_spherize = 1,
    rel_spherize_bot = 0.6,
    top_thick_scale = 0.95,
    rel_translate_botz = 0.6 ,
    rel_extrude = 0.4,
    y_scale = 1.2,
    fn_sphere = 70,
    fn_circ = 50,
) {
    rotate([90, 0, 0])
    for (rot = [-45, 45])
    hull() {
        rotate(rot)
        scale([1, 1, top_thick_scale])
        translate([0, core_size * rel_translate, 0])
        minkowski() {
            scale([1, y_scale])
            sphere(r=core_size * rel_spherize, $fn=fn_sphere)
                ;
        }
            ;
        translate([0, -core_size * rel_translate_botz, 0])
        sphere(r=core_size * rel_spherize_bot, $fn=fn_sphere)
            ;
    }
        ;
}


function accumulate(vals, i) =
    [
        for (
            j = 0, x = 0;
            j <= i;
            x = x + (vals[j][1] == undef ? 0 : vals[j][1]),
            j = j+1
        )
        x
    ][i]
        ;


module nice_ngon(
    d,
    sides,
    mink,
    fn_mink = 30,
){
    linear_extrude(0.01)
    minkowski() {
        circle(d=d - 2 * mink, $fn=sides)
            ;
        circle(r=mink, $fn=fn_mink)
            ;
    }
        ;
}


module tier_prism(
    diam_dzs,
    sides = 5,
    down = true,
    mink = 5,
) {
    rotate([0, 0, - 90 + 360 / (sides * 2)])
    for (i = [0:len(diam_dzs) - 2]) {
        translate([0, 0, (down ? -1 : 1) * accumulate(diam_dzs, i)])
        hull() {
            nice_ngon(diam_dzs[i][0], sides=sides, mink=mink)
                ;
            translate([0, 0, (down ? - 1 : 1) * diam_dzs[i][1]])
            nice_ngon(diam_dzs[i + 1][0], sides=sides, mink=mink)
                ;
            
        }
            ;
    }
        ;
}


FONT = "Adobe Gothic Std";


module word_cutter(
    words,
    r = 28,
    size = 6,
) {
    for (i = [0:len(words) - 1])
    rotate([0, 0, 360 * i / len(words)])
    rotate([90, 0, 0])
    translate([0, 0, r])
    linear_extrude(99)
    text(words[i], halign="center", size=size, font=FONT)
        ;
}


translate([0, 0, 32])
heart()
    ;

PRISM_VALS = [
    [72, 3],
    [78, 4],
    [78, 2],
    [75, 2],
    [80, 2],
    [80, 3],
    [70, 11],
    [70, 3],
    [75, 2],
    [75, 3],
    [70, 2],
    [72, 4],
    [72, 5],
    [58, 0]
]
    ;

difference() {
    tier_prism(PRISM_VALS)
        ;
    translate([0, 0, -7.5 - accumulate(PRISM_VALS, 6)])
    word_cutter([
        "as strong",
        "as death,",
        "as hard",
        "as hell.",
        "Love is",
    ])
        ;
    translate([0, 0, -accumulate(PRISM_VALS, len(PRISM_VALS)) + 1])
    rotate([0, 0, 180])
    mirror([0, 0, 1])
    linear_extrude(99)
    mirror([1, 0])
    text(
        "by Indi",
        halign="center",
        valign="center",
        size=6,
        font=FONT
    )
        ;
}
    ;
