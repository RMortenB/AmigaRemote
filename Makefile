AS=vasmm68k_mot
CXX=m68k-amigaos-g++
CC=m68k-amigaos-gcc
TARGET=amigaCompileServer

SOURCES=amigaServer.c

CFLAGS=-O3 -fomit-frame-pointer -std=c99 -DAMIGA=1 -m68030 -W -mcrt=nix20
CXXFLAGS= -DAMIGA=1 -O3 -std=c++11 -m68030 -mnoshort -mhard-float
ASFLAGS=-m68080 -quiet -Fhunk

LFLAGS=-mcrt=nix20
LDLIBS=-lamiga -lsocket

# define list of objects
OBJSC=$(SOURCES:.c=.o)
OBJSXX=$(OBJSC:.cpp=.o)
OBJS=$(OBJSXX:.s=.o)

# the target is obtained linking all .o files
all: $(SOURCES) $(TARGET) Makefile

$(TARGET): $(OBJS) Makefile
	$(CC) $(LFLAGS) $(OBJS) $(LDLIBS) -o $(TARGET)

purge: clean
	rm -f $(TARGET)

clean:
	rm -f $(OBJS) ; rm $(TARGET)

################################################################################
################################################################################
