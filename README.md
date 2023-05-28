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

To build the disassembly, run the following command:

```bash
make
```

Any changings to the disassembly will require you to run the above command again.

If you want to build from your own copy of the game, you'll need to place the place it in the root of this repository and re-name it to `original.nes`.  Then run the following command `make extract` to extract the PRG and CHR roms.  You can then run `make program` to create a new **program.s** file you can hack at.

## Included Tools

- [NES-Extract](https://github.com/X-death25/Nes-Extract)
- [Sengo](https://github.com/drpaneas/sengo)