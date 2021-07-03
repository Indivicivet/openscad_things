width = 50;
$fn = 30;
mink = 5;
text_indent = 2;
base_text_size = 10;

texts = [
    [
        ["hello", 1],
        ["world", 1],
    ],
    [
        ["good", 1],
        ["dice", 1],
    ],
    [
        ["roll", 1],
        ["6", 2],
    ],
];

difference() {
    minkowski() {
        cube(width - mink * 2, center=true)
            ;
        sphere(mink)
            ;
    }
        ;
    for (axis = [0, 1, 2]) {
        for (side = [0, 1]) {
            t = side * 2 - 1;
            translate([
                axis == 0 ? t * width / 2 : 0,
                axis == 1 ? t * width / 2 : 0,
                axis == 2 ? t * width / 2 : 0,
            ])
            rotate([
                axis == 1 ? 90: 0,
                axis == 0 ? 90 : 0,
                0,
            ])
            rotate([
                0,
                (axis + side) % 2 == 0 ? 180 : 0,
                0,
            ])
            translate([0, 0, -text_indent])
            linear_extrude(text_indent + 0.01)
            text(
                texts[axis][side][0],
                halign="center", valign="center",
                size=base_text_size * texts[axis][side][1]
            )
                ;
        }
            ;
    }
        ;
}
    ;
