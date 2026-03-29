# 1. Environment & Paths
export COLORTERM=truecolor
export TERM=xterm-256color
export EDITOR='nvim'

# 2. History (Сгруппировано в одном месте)
HISTFILE="$HOME/.config/zsh/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")" # Создаем папку, если её нет
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS

# 3. Completion & Navigation
setopt AUTO_CD
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Регистронезависимый поиск

# 4. FZF & Navigation (Инженерный блок)
if command -v fzf &> /dev/null; then
    source <(fzf --zsh) # Официальный способ инициализации
    
    # Чтобы fzf не тормозил на тяжелых папках (node_modules, .git)
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
    
    # Красивое превью для папок через eza (Alt+C)
    export FZF_ALT_C_OPTS="--preview 'eza -T -L 2 --icons --color=always {} | head -20'"
    
    # Фикс твоего cdf (теперь он реально работает)
    fcd() {
      local dir=$(fd --type d --hidden --exclude .git | fzf --preview 'eza -T -L 2 --icons --color=always {}')
      [ -n "$dir" ] && cd "$dir"
    }
    alias cdf='fcd'
fi

# Zoxide (умный cd) — мастхэв для Mac
command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"

# 5. Aliases (EZA & Tools)
if command -v eza &> /dev/null; then
    alias ls='eza -1 --icons --group-directories-first'
    alias ll='eza -lha --icons --group-directories-first --git' # Добавил статус гита
    alias lt='eza --tree --level=2 --icons'
    # Превью файла в fzf через eza
    alias fe='fzf --preview "eza -ld --color=always --icons {}"'
else
    alias ls='ls -G'
    alias ll='ls -alF'
fi

alias vi='nvim'
alias g='git'
alias dot='cd ~/dotfiles'

# 6. Plugins (Загружаем один раз через Brew пути)
BREW_PREFIX=$(brew --prefix)
[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# 7. Prompt (Starship в самом конце)
command -v starship &> /dev/null && eval "$(starship init zsh)"

