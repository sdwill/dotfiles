# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="refined-conda"
# ZSH_THEME="tjkirch"
# ZSH_THEME="bira"
# ZSH_THEME="robbyrussell"
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs newline anaconda)
# POWERLEVEL9K_COLOR_SCHEME="dark"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  # themes
  colored-man-pages
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# source /usr/share/powerlevel9k/powerlevel9k.zsh-theme
# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Hide the username from prompt- this line has to come AFTER loading powerline since it is also a
# powerline setting
# prompt_context() {}

# Fix tilix VTE script
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

# Custom aliases
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
alias vi="nvim"

# alias kitty="~/.local/kitty.app/bin/kitty"

# Add Julia to path
# export PATH="$PATH:/home/scott/Documents/julia-1.5.3/bin"
# export PATH="$PATH:$HOME/Downloads/julia/julia-1.6.4/bin"

# Set true color inside Neovim so that bat works properly.
# See https://github.com/sharkdp/bat/issues/634
if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
  export COLORTERM="truecolor"
fi

# texlive path, see http://www.tug.org/texlive/quickinstall.html
export PATH="/usr/local/texlive/2021/bin/x86_64-linux:$PATH"
alias sutlmgr='sudo /usr/local/texlive/2021/bin/x86_64-linux/tlmgr'
# export NVIM_QT_RUNTIME_PATH="~/Documents/repos/neovim-qt/src/gui/runtime"

# Add ~/bin to PATH
export PATH="$HOME/bin:$PATH"

# Make neovim the default terminal editor
export VISUAL=$(which nvim)
export EDITOR=$(which nvim)

# Add FZF completions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add sphinx to path
export PATH="/usr/local/opt/sphinx-doc/bin:$PATH"

# Add conda to path
# export PATH="$HOME/anaconda3/bin:$PATH"  # commented out by conda initialize

# Modified from the original lines inserted by conda due to slow terminal startup time, see here:
# https://github.com/conda/conda/issues/7855
#
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/swill/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ -f "/Users/swill/opt/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/Users/swill/opt/anaconda3/etc/profile.d/conda.sh"
else
    export PATH="/Users/swill/opt/anaconda3/bin:$PATH"
fi
unset __conda_setup
# <<< conda initialize <<<

conda config --set changeps1 False  # Don't change prompt

alias doom="~/.emacs.d/bin/doom"

# For catkit2, see https://github.com/spacetelescope/catkit2
export FOR_DISABLE_CONSOLE_CTRL_HANDLER=1

# Disable checking for automatic updates to improve startup time, see here:
# https://superuser.com/questions/236953/zsh-starts-incredibly-slowly
export DISABLE_AUTO_UPDATE="true"
