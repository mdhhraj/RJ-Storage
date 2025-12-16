#!/data/data/com.termux/files/usr/bin/bash
SD_PATH="/storage/5F34-6C6B"
INTERNAL="/storage/emulated/0"
SUCCESS="✅ Successful"
FAILED="❌ Oh... Failed"

show_animation(){
 echo -ne "
🔄 Processing"
 for i in 1 2 3 4; do
  echo -ne "
🔄 Processing."
  sleep 0.3
  echo -ne "
🔄 Processing.."
  sleep 0.3
  echo -ne "
🔄 Processing..."
  sleep 0.3
 done
 echo -e "
\u001B[K"
}

move_files(){
 local src="$1" dest="$2" desc="$3"
 echo "📁 Moving $desc..."
 show_animation
 if [[ -e "$src" ]]; then
  mkdir -p "$dest"
  if mv "$src" "$dest/" 2>/dev/null; then
   echo "✅ $desc moved!"
   echo "$SUCCESS"
  else
   echo "❌ Failed to move $desc"
   echo "$FAILED"
  fi
 else
  echo "⚠️  $src not found"
  echo "$FAILED"
 fi
}

storage_health(){
 echo "📊 Storage Health Check"
 echo "======================"
 df -h /storage/emulated/0 | tail -1
 df -h "$SD_PATH" 2>/dev/null | tail -1 || echo "SD not accessible"
 du -sh "$INTERNAL"/* 2>/dev/null | sort -hr | head -5
 echo "$SUCCESS"
}

show_help(){
 cat << 'HELP_EOF'
🎯 RJ-Storage v1.0.0 Commands:

MOVE TO SD:
• mv-app.package  - Move app data
• mv-down         - Downloads to SD
• mv-filename     - Specific file
• mv-foldername   - Any folder
• mv-media        - Music/Pics/Videos
• mv-DCIM         - Camera folder

CLEANUP:
• del-tmp-int     - Internal temp
• del-tmp-sd      - SD temp files

ANALYSIS:
• qck-hlt         - Health check

HELP:
• rj-help         - This menu
• rj-commands     - Short list
HELP_EOF
 echo "$SUCCESS"
}

case "${1,,}" in
 "mv-app"|"mv-app.package")
  read -p "Enter package: " pkg
  move_files "/data/data/$pkg" "$SD_PATH/Android/data" "App $pkg"
  ;;
 "mv-down")
  move_files "$INTERNAL/Download" "$SD_PATH/Download" "Downloads"
  ;;
 "mv-filename")
  read -p "Enter file: " file
  move_files "$file" "$SD_PATH" "File"
  ;;
 "mv-foldername")
  read -p "Enter folder: " folder
  move_files "$folder" "$SD_PATH" "Folder"
  ;;
 "mv-media")
  move_files "$INTERNAL/Music" "$SD_PATH/Music" "Music"
  move_files "$INTERNAL/Pictures" "$SD_PATH/Pictures" "Pictures"
  ;;
 "mv-dcim")
  move_files "$INTERNAL/DCIM" "$SD_PATH/DCIM" "Camera"
  ;;
 "del-tmp-int")
  echo "🧹 Cleaning internal temp..."
  show_animation
  find /data/data/com.termux/files/usr/tmp -name "*.tmp" -delete 2>/dev/null
  echo "$SUCCESS"
  ;;
 "del-tmp-sd")
  echo "🧹 Cleaning SD temp..."
  show_animation
  find "$SD_PATH" -name "*.tmp" -delete 2>/dev/null
  echo "$SUCCESS"
  ;;
 "qck-hlt")
  storage_health
  ;;
 "rj-help")
  show_help
  ;;
 "rj-commands")
  echo "📋 Short commands: mv-down, mv-media, qck-hlt, rj-help"
  echo "$SUCCESS"
  ;;
 *)
  show_help
  ;;
esac

echo -e "
✨ RJ-Storage v1.0.0 by Hasibul Hasan"
echo "🌐 https://hasibulhasan.holeiholo.com"
