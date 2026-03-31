// schlegelflaschen too tall to store vertically?

H = 330;
H_BODY = 130;
H_SHOULDER = 130;
D_BASE = 75;
D_NECK = 29;

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

schlegelflaschen()
    ;
