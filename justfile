# Lists all available commands.
default:
    @just --list --unsorted

# Checks the flake for syntax errors
check:
    nix fmt 
    home-manager build --flake .
    rm result

# Builds the home configuration for the current user.
switch user=`whoami`:
    nix flake update
    home-manager switch --flake .#{{user}}

