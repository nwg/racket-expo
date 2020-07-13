#include <string.h>
#include <stddef.h>
#include <stdio.h>
#include <assert.h>

#include "server.h"
#include <Racket/chezscheme.h>
#include <Racket/racketcs.h>
#include "data.c"

int main(int argc, char **argv) {
    racket_boot_arguments_t ba;
    memset(&ba, 0, sizeof(ba));
    ba.boot1_path = "boot/petite.boot";
    ba.boot2_path = "boot/scheme.boot";
    ba.boot3_path = "boot/racket.boot";

    ba.exec_file = argv[0];
    ba.collects_dir = "/Applications/Racket v7.7/collects";
    ba.config_dir = "./env/etc";

    ba.argc = 5;
    char *custom_argv[] = {
        "-n",
        "-A",
        "./env/addon",
        "-W",
        "debug@ffi-lib",
    };
    ba.argv = custom_argv;

    racket_boot(&ba);

    declare_modules();

    ptr mod = Scons(Sstring_to_symbol("quote"),
                    Scons(Sstring_to_symbol("test"),
                          Snil));
    racket_dynamic_require(mod, Sfalse);

    return 0;
}
