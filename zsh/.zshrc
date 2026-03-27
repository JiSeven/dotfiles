# 1. Colors & Environment
# Ensure 24-bit color support for WezTerm and Neovim 0.12
export COLORTERM=truecolor
export TERM=xterm-256color

# 2. History Settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY       # Append to history file instead of overwriting
setopt SHARE_HISTORY        # Share history between different terminal sessions
setopt HIST_IGNORE_DUPS     # Don't record a line if it was the previous one

# 3. Navigation & Completion
setopt AUTO_CD              # Just type the directory name to 'cd' into it
setopt MENU_COMPLETE        # Highlight the first completion in the menu
zstyle ':completion:*' menu select # Use arrow keys to navigate completions

# 4. Aliases (Fast workflow)
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias ls='ls -G'            # Colored output for macOS ls
alias ll='ls -alF'
alias g='git'
alias dot='cd ~/dotfiles'   # Quick access to your config

# 5. Plugins (Manual loading for speed)
# Use 'brew --prefix' to find the correct path on Apple Silicon or Intel
if [ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [ -f $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# 6. Prompt (Starship)
# Must be at the very end to properly override the prompt
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# --- CLEAN HOME DIRECTORY ---

# Move Zsh history to .config/zsh/
# This keeps your $HOME clean
HISTFILE="$HOME/.config/zsh/.zsh_history"

# --- FILE EXPLORER (EZA) ---

# Check if eza is installed before setting aliases
if command -v eza &> /dev/null; then
    # Base alias for 'ls'
    # --icons: show filetype icons (requires Nerd Font)
    # --group-directories-first: keep folders at the top
    # --color=always: force colors for better contrast
    alias ls='eza --icons --group-directories-first --color=always'
    
    # Detailed list (replaces 'll')
    # -l: long format (permissions, size, date)
    # -a: show hidden files (dotfiles)
    # -h: human-readable file sizes
    alias ll='eza -lah --icons --group-directories-first'
    
    # Tree view (very handy for project structure)
    alias lt='eza --tree --level=2 --icons'
else
    # Fallback to standard ls if eza is missing
    alias ls='ls -G'
    alias ll='ls -alF'
fi
