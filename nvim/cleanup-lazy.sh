#!/bin/bash
# Clean up lazy.nvim remnants after migration to vim.pack

set -e

echo "🧹 Cleaning up lazy.nvim data..."
echo ""

# Remove lazy.nvim plugin directory
if [ -d "$HOME/.local/share/nvim/lazy" ]; then
    echo "Removing ~/.local/share/nvim/lazy/"
    rm -rf "$HOME/.local/share/nvim/lazy/"
    echo "✓ Removed lazy plugins"
else
    echo "✓ No lazy directory found"
fi

# Remove lazy.nvim cache
if [ -d "$HOME/.cache/nvim" ]; then
    echo "Removing ~/.cache/nvim/"
    rm -rf "$HOME/.cache/nvim/"
    echo "✓ Removed cache"
else
    echo "✓ No cache directory found"
fi

echo ""
echo "✨ Cleanup complete!"
echo ""
echo "Next steps:"
echo "  1. Launch nvim - plugins will auto-install via vim.pack"
echo "  2. Run :PackStatus to verify installation"
echo "  3. Run :TSBootstrap to update Treesitter parsers"
echo ""
