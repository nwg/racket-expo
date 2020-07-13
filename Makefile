CFILES := server.c
OFILES := server.o

CFLAGS := -F.
LDFLAGS := -framework Racket -Wl,-rpath,.

ZMQMOD := env/addon/7.7/pkgs/zeromq

.PHONY: all
all: server

.PHONY: clean
clean:
	rm -f $(OFILES) server data.c

$(ZMQMOD):
	PLTADDONDIR="$@" raco pkg install zeromq

server: $(OFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o server $(OFILES)

server: data.c $(ZMQMOD)

data.c: test.rkt
	raco ctool --c-mods data.c ++lib racket/base test.rkt

server.c: data.c
