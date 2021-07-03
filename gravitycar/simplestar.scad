
function xy(r, t) = [r * cos(t), r * sin(t)];

module star(n, rb, ra) {
    circle(ra, $fn=n)
        ;
    dt = 360 / n;
    for (p = [1:n], t = dt * p) {
        polygon([xy(ra, t), xy(rb, t + dt / 2), xy(ra, t + dt)])
            ;
    }
        ;
}

star(12, 30, 25)
    ;
