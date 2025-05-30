Clio is a lightweight bash script that shows interesting facts about Unix, Linux, and computer history. 
## Installation

```bash
git clone https://github.com/alishyyy/clio.git
cd clio
sudo ./install.sh
```

## Usage

Simply run:

```bash
clio
```

### Options

- `-h` - Display help information
- `-v` - Show version information
- `-n` - Disable colored output

## Uninstall

```bash
sudo ./uninstall.sh
```

## Adding Custom Facts

The facts database is located at `/usr/share/clio/facts.txt`. Each line in this file represents a separate fact.

To add your own facts:

```bash
sudo nano /usr/share/clio/facts.txt
```

## License

MIT

## Contributing

Contributions are welcome! Feel free to submit pull requests with new facts or improvements.
