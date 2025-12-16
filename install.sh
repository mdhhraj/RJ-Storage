#!/data/data/com.termux/files/usr/bin/bash
echo "🚀 Installing RJ-Storage v1.0.0..."
pkg install coreutils findutils -y
mkdir -p ~/bin
cp rj-storage.sh ~/bin/rj-storage
chmod +x ~/bin/rj-storage
echo 'alias rj="$HOME/bin/rj-storage"' >> ~/.bashrc
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc

# Reload properly
source ~/.bashrc
export PATH="$HOME/bin:$PATH"

# Test
if command -v rj >/dev/null 2>&1; then
    rj rj-help
    echo "✅ Installed! Use: rj qck-hlt"
else
    echo "❌ Install failed. Run manually:"
    echo "cp rj-storage.sh ~/bin/ && chmod +x ~/bin/rj-storage"
fi
