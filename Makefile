CFILES := server.c
OFILES := server.o

CFLAGS := -F.
LDFLAGS := -framework Racket -Wl,-rpath,.

.PHONY: all
all: server

.PHONY: clean
clean:
	rm -f $(OFILES) server data.c

server: $(OFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o server $(OFILES)

server: data.c

data.c: test.rkt
	raco ctool --c-mods data.c ++lib racket/base test.rkt

server.c: data.c
