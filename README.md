# AmigaRemote

A two-part tool for cross-developing Amiga (m68k) software from a modern host.
The host pushes files and shell commands to a running Amiga over TCP; the Amiga
writes the files to disk and runs the commands (typically a cross-compiler build
followed by running the result). Both sides talk on **port 20202**.

- **`ACS`** — the server, runs on the Amiga (`amigaServer.c`).
- **`amigaCompile`** — the client, runs on the host (`amigaRemote.cpp`).

## Build

`make` builds both binaries:

```
make               # ACS (Amiga) + amigaCompile (host)
make ACS           # server only  — needs m68k-amigaos-gcc (ApolloCrossDev) in PATH
make amigaCompile  # client only  — host gcc
```

## Run

1. On the Amiga, start the server (it waits on port 20202):

   ```
   ACS
   ```

2. On the host, point `AMIGAHOST` at the Amiga and run a script:

   ```
   AMIGAHOST=<address> amigaCompile <script.txt>
   ```

## Script commands

Lines starting with `#` or `;` are comments; blank lines are ignored.

| Command | Description |
| --- | --- |
| `send <file>` | Send a binary file to the Amiga (CRC32-verified). |
| `sendtxt <file>` | Send a text file; opened in text mode to normalize CR/LF. |
| `run <cmd + args>` | Run a command on the Amiga; output stays on the Amiga console. |
| `runout <cmd + args>` | Run a command and stream its output back to the host, ending with `[exit <rc>]`. |
| `recv <file>` | Pull a file back from the Amiga (CRC32-verified). |
| `close` | End the session. |

`runout` captures output via `RAM:` on the Amiga, so the RAM Disk must be available.

## Example

```
# send main.c, compile it on the Amiga, and run the result,
# streaming compiler and program output back to the host
sendtxt main.c
runout gcc main.c
runout a.out
```
