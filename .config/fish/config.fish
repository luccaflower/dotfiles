if status is-interactive
    # Commands to run in interactive sessions can go here
    # set BASE16_SHELL "$HOME/.config/base16-shell/"
    # source "$BASE16_SHELL/profile_helper.fish"
end
set fish_function_path $fish_function_path "/usr/share/powerline/bindings/fish"
source /usr/share/powerline/bindings/fish/powerline-setup.fish
powerline-setup

if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

fish_add_path /home/lucca/.cargo/bin:/usr/local/bin:/usr/bin:/var/lib/snapd/snap/bin:/usr/local/sbin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/snap/bin:/home/lucca/.fzf/bin
alias ls "exa --icons" 
alias lsa "ls -a"
alias lsg "ls --git"
alias watch-test "fswatch -xol 1000 --event Created --event Updated --event Removed"
alias :q "exit"

set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux MOZ_DBUS_REMOTE "1"
set -Ux MOZ_ENABLE_WAYLAND "1"
set -Ux JDTLS_HOME "/home/lucca/.local/share/nvim/lsp_servers/jdtls"

# opam configuration
source /home/lucca/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
alias config='/usr/bin/git --git-dir=/home/lucca/.cfg/ --work-tree=/home/lucca'
