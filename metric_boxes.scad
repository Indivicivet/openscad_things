module metric_box(n) {
    cube(
        1000 * [
            pow(2, (1 - n) / 3),
            pow(2, -n/3),
            pow(2, (-1-n)/3)
        ]
    )
        ;
}

module metric_box_holder(n, thick=2, tol=1) {
    difference() {
        cube(
            1000 * [
                pow(2, (1 - n) / 3),
                pow(2, -n/3),
                pow(2, (-1-n)/3)
            ] + [2, 2, 0.99] * thick
        )
            ;
        translate([thick + tol, thick + tol, thick])
        cube(
            1000 * [
                pow(2, (1 - n) / 3),
                pow(2, -n/3),
                pow(2, (-1-n)/3)
            ] - [2, 2, 0] * tol
        )
            ;
    }
}

metric_box_holder(12)
    ;

translate([0, 80, 0])
metric_box(13)
    ;

translate([100, 0, 0])
metric_box(15)
    ;

translate([100, 40, 0])
metric_box(15)
    ;

translate([100, 80, 0])
metric_box(15)
    ;

translate([150, 0, 0])
metric_box(16)
    ;

translate([150, 40, 0])
metric_box(17)
    ;

translate([150, 80, 0])
metric_box(17)
    ;

