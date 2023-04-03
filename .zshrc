# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

for f in ~/.zsh/include/*; do
    source $f;
done

QAICASH_SECRET_KEY=***REMOVED***
QAICASH_SECRET_KEY_LIVE=***REMOVED***
AW_WAR_DIR=/home/lucca/IdeaProjects/accountweb/target
EDITOR=/sbin/nvim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source $HOME/.zsh/theme/powerlevel10k.zsh-theme
export JIRA_API_TOKEN=***REMOVED***
export PATH="$PATH:/home/lucca/.local/share/coursier/bin"
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
source $HOME/.rvm/scripts/rvm
