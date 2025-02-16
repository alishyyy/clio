# 🎲 Clio - Your Time Machine to Computing History

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Bash](https://img.shields.io/badge/Shell-Bash-green.svg)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-blue.svg)

> "Those who don't know history are destined to `rm -rf` it." - Not Edmund Burke

## 🚀 What is Clio?

Clio is your personal time machine into the fascinating world of computing history! Like the ancient Greek muse of history it's named after, Clio brings the past to life through an engaging collection of facts about the pioneers, innovations, and moments that shaped our digital world.

Think of it as `fortune` but for tech history – perfect for your terminal startup, random inspiration, or those "Hey, did you know...?" moments!

![Clio Demo](https://raw.githubusercontent.com/yourusername/clio/main/demo.gif)

## ✨ Features

- 🎯 **Random Facts**: Dive into a curated collection of computing history facts
- 🔍 **Search Mode**: Find specific historical events or personalities
- 📝 **History Tracking**: Keep track of facts you've seen
- 🎨 **Beautiful Display**: Enjoy ASCII art and smooth animations
- ⚡ **Fast & Lightweight**: Written in pure Bash for maximum compatibility
- 🛠️ **Configurable**: Customize colors, animation speed, and more
- 📱 **Interactive**: User-friendly interface with keyboard commands

## 🚀 Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/clio.git

# Navigate to the directory
cd clio

# Run the installer
sudo ./install.sh
```

### Usage

```bash
# Show a random fact
clio

# Search for facts about Linux
clio -s "Linux"

# Show help
clio -h

# Show version
clio -v

# Clear history
clio -c
```

## 🎮 Interactive Commands

Once Clio is running:
- Press `Enter` for a new fact
- Press `s` to search facts
- Press `h` to view history
- Press `q` to quit

## ⚙️ Configuration

Clio creates a configuration directory at `~/.config/clio` with the following files:

```
~/.config/clio/
├── config    # User configuration
└── history   # Fact viewing history
```

Edit `config` to customize:
- Typing speed
- Animation settings
- Color theme

## 🎨 Command Line Options

```bash
Usage: clio [OPTION]
Display random computing history facts.

Options:
  -s TERM     Search for facts containing TERM
  -h          Display this help message
  -v          Display version information
  -c          Clear history
  --no-color  Disable colored output
  --no-animation  Disable animations
```

## 🔧 Requirements

- Bash 4.0 or later
- Basic Unix utilities (tput, sed, grep)
- A terminal that supports ASCII colors

## 🤝 Contributing

Found a bug? Want to add more features? Contributions are welcome!

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Add your changes
4. Commit (`git commit -m 'Add AmazingFeature'`)
5. Push (`git push origin feature/AmazingFeature`)
6. Open a Pull Request

### Adding New Facts

Facts can be added to `facts.txt`. Please ensure:
- Historical accuracy (with sources if possible)
- Clear, concise writing
- One fact per line
- No duplicate facts

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 💖 Acknowledgments

- Inspired by the classic `fortune` command
- Thanks to all the computing pioneers who made these facts possible
- Special thanks to the open-source community

## 🔮 Coming Soon

- [ ] Integration with system notifications
- [ ] Category-based fact filtering
- [ ] Fact submission web interface
- [ ] API for retrieving facts
- [ ] Mobile companion app

---

<div align="center">
Made with ❤️ by [Your Name]

If you find Clio useful, consider giving it a ⭐️!
</div>
