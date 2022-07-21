
BFORMAT_W = 129;
BFORMAT_H = 198;
DIVIDER_PAGE_EQUIV = 300;

PAPER_THICK = 0.16;  // estimated

function thick(pages) = pages / 2 * PAPER_THICK;

module book(pages=DIVIDER_PAGE_EQUIV) {
    cube([thick(pages), BFORMAT_W, BFORMAT_H])
        ;
}


book()
    ;
