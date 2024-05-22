# Neovim Setup

My latest working files to configure my neovim enviroment using lazy.nvim

### Setup Requirements (Windows)

- [Windows Terminal](https://github.com/microsoft/terminal) - True color terminal
- [Node](https://nodejs.org) - For typescript/javascript

1. Clone repo into a new `nvim` directory in `~/AppData/Local`
2. Install the following (via chocolatey)

[Nerd Font](https://www.nerdfonts.com/) - I like VictorMono

```bash
choco install nerd-fonts-victormono
```

[Neovim](https://neovim.io/) - Version 0.9 or Later

```bash
choco install neovim
```

[Ripgrep](https://github.com/BurntSushi/ripgrep) - For Telescope Fuzzy Finder

```bash
choco install neovim
```

Other neovim dependency:

```bash
choco install mingw
```

```bash
choco install gcc
```

[Lazygit](https://github.com/jesseduffield/lazygit) - Terminal Git UI

```bash
choco install lazygit
```

3. Open neovim via `nvim` command and run the lazy installer with `:Lazy`.
