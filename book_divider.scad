
BFORMAT_W = 129;
BFORMAT_H = 198;
DIVIDER_PAGE_EQUIV = 300;

PAPER_THICK = 0.16;  // estimated

function thick(pages) = pages / 2 * PAPER_THICK;

module book(pages=DIVIDER_PAGE_EQUIV) {
    cube([thick(pages), BFORMAT_W, BFORMAT_H])
        ;
}

module divider() {
    book()
        ;
}


module shelf_preview() {
    BOOK_ALPHA = 0.7;
    
    // shelf
    color([0.7, 0.4, 0.2])
    translate([-250, -200+BFORMAT_W, -10])
    cube([500, 200, 10])
        ;

    // wall
    color([1, 1, 0.8])
    translate([-250, BFORMAT_W, -80])
    cube([500, 10, 400])
        ;

    // books
    color([0.3, 0.3, 0.2, BOOK_ALPHA])
    translate([thick(-300 - 200 - 400), 0, 0])
    book(400)
        ;
    
    color([1, 0.2, 0.7, BOOK_ALPHA])
    translate([thick(-300 - 200), 0, 0])
    book(200)
        ;

    color([0.5, 0.2, 1, BOOK_ALPHA])
    translate([thick(-300), 0, 0])
    book(300)
        ;

    divider()
        ;

    color([0.3, 0.5, 0.2, BOOK_ALPHA])
    translate([thick(DIVIDER_PAGE_EQUIV), 0, 0])
    book(200)
        ;

    color([0, 1, 0.6, BOOK_ALPHA])
    translate([thick(DIVIDER_PAGE_EQUIV + 200), 0, 0])
    book(400)
        ;

    color([1, 0.2, 0, BOOK_ALPHA])
    translate([thick(DIVIDER_PAGE_EQUIV + 200 + 400), 0, 0])
    book(350)
        ;
}


shelf_preview()
    ;
