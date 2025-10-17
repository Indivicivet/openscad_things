PITCH = 50;
BORDER = 10;
N = 20;

difference() {
    square(PITCH * N + BORDER)
        ;
    translate([BORDER, BORDER])
    for (i = [0:N - 1])
    for (j = [0:N - 1])
    translate([i, j] * PITCH)
    square(PITCH - BORDER)
        ;
}
