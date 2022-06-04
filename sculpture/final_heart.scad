$fn = 20;

module heart() {
    rotate([90, 0, 0])
    minkowski() {
        linear_extrude(0.01)
        scale([1, 1.2])
        for (rot = [-45, 45])
        rotate(rot)
        hull() {
            translate([0, 2.5])
            circle(r=1)
                ;
            square(2, center=true)
                ;
        }
            ;
        sphere(r=1.5)
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
    vals,
    sides=4,
    down=true,
) {
    rotate([0, 0, 360 / (sides * 2)])
    for (i = [0:len(vals) - 2]) {
        translate([0, 0, (down ? -1 : 1) * accumulate(vals, i)])
        hull() {
            linear_extrude(0.01)
            circle(d=vals[i][0], $fn=sides)
                ;
            translate([0, 0, (down ? - 1 : 1) * vals[i][1]])
            linear_extrude(0.01)
            circle(d=vals[i + 1][0], $fn=sides)
                ;
        }
            ;
    }
        ;
}


translate([0, 0, 2])
heart()
    ;

tier_prism(
    [[6, 1], [7, 1], [6, 1], [8, 1], [7, 1], [5, 0]]
)
    ;
