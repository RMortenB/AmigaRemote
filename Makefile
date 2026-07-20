all: ACS amigaCompile

ACS: amigaServer.c
	m68k-amigaos-gcc -O3 -mcrt=nix20 $< -lamiga -lsocket -o $@

amigaCompile: amigaRemote.cpp
	gcc -O3 $< -lstdc++ -o $@
