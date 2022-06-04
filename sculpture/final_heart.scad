
module heart(
    core_size = 20,
    rel_translate = 1.25,
    rel_spherize = 1,
    y_scale = 1.2,
    thick_scale = 0.8,
    fn_sphere = 30,
    fn_circ = 30,
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
    sides=4,
    down=true,
) {
    rotate([0, 0, 360 / (sides * 2)])
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


translate([0, 0, 25])
heart()
    ;

tier_prism([
    [70, 2],
    [80, 5],
    [80, 2],
    [75, 2],
    [85, 1],
    [85, 3],
    [70, 10],
    [70, 3],
    [85, 1],
    [85, 3],
    [75, 2],
    [80, 5],
    [80, 2],
    [75, 10],
    [50, 0]
])
    ;
