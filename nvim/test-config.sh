#!/bin/bash
# Test the new Neovim configuration

set -e

echo "🚀 Testing new Neovim configuration..."
echo ""

# Check Neovim version
echo "📋 Neovim version:"
nvim --version | head -1
echo ""

# Check if config exists
if [ ! -f "$HOME/.config/nvim/init.lua" ]; then
    echo "❌ Config not found at ~/.config/nvim/init.lua"
    echo "   Make sure you've stowed the nvim directory"
    exit 1
fi

echo "✅ Config found at ~/.config/nvim/init.lua"
echo ""

# Launch Neovim with a test file
echo "🎯 Launching Neovim..."
echo "   On first launch, lazy.nvim will install all plugins automatically."
echo "   This may take 1-2 minutes."
echo ""
echo "   After plugins install:"
echo "   - Press :Lazy to check plugin status"
echo "   - Press :checkhealth to verify installation"
echo "   - Press :TSUpdate to update Treesitter parsers"
echo ""
echo "Press Enter to continue..."
read

nvim

echo ""
echo "✨ Test complete!"
