# !Work-In-Progress! - Ice Hockey Disassembly

A disassembly of the Famicom/NES game Ice Hockey.  The code structure of this disassembly (main.s and nes.cfg with slight tweaks) should work for most mappper 0,1, and 2 roms.  Any pull requests are welcomed.

I'll be adding some comments in the future with the assistance of Chat-GPT.

## How to build

### Requirements

On a Ubuntu based system, you'll need to install the following packages, including [cc65](https://cc65.github.io/):

```bash
sudo apt install build-essential cc65
```

### Building

To build the disassembly, you'll need to place the place a rom of the original game in the root of this repository (renamed as "original.nes") and then run the following commands:

```bash
make extract && make
```

To execute the built binary, `make run` will do if you have the **DEBUGGER** variable in the Makefile set to a emulator on your system.

Any changings to the disassembly will require you to run the `make` command again.

## Included Tools

- [NES-Extract](https://github.com/X-death25/Nes-Extract)
- [Sengo](https://github.com/drpaneas/sengo)
