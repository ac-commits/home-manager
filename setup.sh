# Exit the script if any command fails
set -e

# Step 1: Link Home Manager configuration to NixOS configuration
echo "Linking Home Manager configuration..."
sudo ln -sf ~/.config/home-manager/configuration.nix /etc/nixos/configuration.nix

# Step 2: Set up fonts directory
echo "Setting up fonts directory..."
mkdir -p ~/.local/share
ln -sf ~/.config/home-manager/fonts ~/.local/share/fonts

# Step 3: Add Home Manager channel and update
echo "Adding and updating Home Manager channel..."
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update

# Step 4: Install Home Manager
echo "Installing Home Manager..."
sudo nix-shell '<home-manager>' -A install

# Step 5: Run home-manager switch
echo "Switching Home Manager configuration..."
home-manager switch

# Step 7: Rebuild NixOS and reboot
echo "Rebuilding NixOS and rebooting..."
sudo nixos-rebuild switch
sudo reboot
