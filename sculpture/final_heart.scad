
module heart(
    core_size = 20,
    rel_translate = 1,
    rel_spherize = 0.9,
    y_scale = 1.3,
    thick_scale = 0.9,
    fn_sphere = 40,
    fn_circ = 40,
) {
    rotate([90, 0, 0])
    scale([1, 1, thick_scale])
    minkowski() {
        linear_extrude(0.01)
        scale([1, y_scale])
        for (rot = [-45, 45])
        rotate(rot)
        hull() {
            translate([0, core_size * rel_translate])
            circle(d=core_size, $fn=fn_circ)
                ;
            square(core_size, center=true)
                ;
        }
            ;
        sphere(r=core_size * rel_spherize, $fn=fn_sphere)
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



module tier_prism(
    diam_dzs,
    sides=5,
    down=true,
) {
    rotate([0, 0, - 90 + 360 / (sides * 2)])
    for (i = [0:len(diam_dzs) - 2]) {
        translate([0, 0, (down ? -1 : 1) * accumulate(diam_dzs, i)])
        hull() {
            linear_extrude(0.01)
            circle(d=diam_dzs[i][0], $fn=sides)
                ;
            translate([0, 0, (down ? - 1 : 1) * diam_dzs[i][1]])
            linear_extrude(0.01)
            circle(d=diam_dzs[i + 1][0], $fn=sides)
                ;
        }
            ;
    }
        ;
}


module word_cutter(
    words,
    r = 28,
    size = 6.5,
) {
    for (i = [0:len(words) - 1])
    rotate([0, 0, 360 * i / len(words)])
    rotate([90, 0, 0])
    translate([0, 0, r])
    linear_extrude(99)
    text(words[i], halign="center", size=size)
        ;
}


translate([0, 0, 25])
heart()
    ;

PRISM_VALS = [
    [70, 4],
    [80, 5],
    [80, 2],
    [75, 2],
    [82, 1.5],
    [82, 3],
    [70, 10],
    [70, 3],
    [77, 1.5],
    [77, 3],
    [70, 2],
    [72, 5],
    [72, 7],
    [58, 0]
]
    ;

difference() {
    tier_prism(PRISM_VALS)
        ;
    translate([0, 0, -7.2 - accumulate(PRISM_VALS, 6)])
    word_cutter([
        "as strong",
        "as death,",
        "as hard",
        "as hell.",
        "Love is",
    ])
        ;
}
    ;
