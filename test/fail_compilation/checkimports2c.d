// REQUIRED_ARGS: -transition=checkimports -transition=import -de
/*
TEST_OUTPUT:
---
fail_compilation/checkimports2c.d(22): Deprecation: local import search method found variable imports.imp2.X instead of variable checkimports2c.X
fail_compilation/checkimports2c.d(28): Deprecation: local import search method found variable imports.imp2.X instead of nothing
fail_compilation/checkimports2c.d(29): Deprecation: local import search method found variable imports.imp2.Y instead of nothing
fail_compilation/checkimports2c.d(31): Deprecation: local import search method found variable imports.imp2.X instead of variable checkimports2c.X
fail_compilation/checkimports2c.d(32): Deprecation: local import search method found variable imports.imp2.Y instead of variable imports.imp1.Y
---
*/

// old lookup + information (the order of switches is reverse)

import imports.imp1;

enum X = 0;

class B
{
    import imports.imp2;
    static assert(X == 2);      // imp2.X --> .X (information)
    int[Y] aa;                  // imp2.Y
}

class C : B
{
    static assert(B.X == 2);    // imp2.X --> error (keep old lookup rule)
    static assert(B.Y == 2);    // imp2.Y --> error (keep old lookup rule)

    static assert(X == 2);      // imp2.X --> .X (information)
    static assert(Y == 2);      // imp2.Y --> imp1.Y (information)
}
