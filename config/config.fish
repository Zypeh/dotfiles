# Go environment
set -x GOPATH ~/Go
set PATH $PATH ~/Go/bin

# Rust environment
set -x RUST_SRC_PATH ~/Projects/Rust/rust/src
set PATH $PATH ~/.cargo/bin/

set fisher_home ~/.local/share/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish
