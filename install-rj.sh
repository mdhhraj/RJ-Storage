cat > ~/install-rj.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "🚀 Installing RJ-Storage v1.0.0 (Single Click)..."
mkdir -p ~/bin
curl -sSL https://raw.githubusercontent.com/mdhhraj/RJ-Storage/main/rj-storage.sh -o ~/bin/rj-storage
chmod +x ~/bin/rj-storage
echo "✅ RJ-Storage installed! Run: rj help"
source ~/bin/rj-storage help
EOF
chmod +x ~/install-rj.sh
