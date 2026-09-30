#!/bin/bash

TARGET_DIR="${1:-/etc}"
EXT="$2"

# Перевірка існування директорії
if [ ! -d "$TARGET_DIR" ]; then
    echo "Помилка: директорія $TARGET_DIR не існує"
    exit 1
fi

if [ -n "$EXT" ]; then
    file_count=$(find "$TARGET_DIR" -type f -name "*.$EXT" | wc -l)
    total_size=$(find "$TARGET_DIR" -type f -name "*.$EXT" -printf '%s\n' | awk '{s+=$1} END {print s+0}')
    echo "Directory: $TARGET_DIR"
    echo "Extension filter: *.$EXT"
else
    file_count=$(find "$TARGET_DIR" -type f | wc -l)
    total_size=$(find "$TARGET_DIR" -type f -printf '%s\n' | awk '{s+=$1} END {print s+0}')
    echo "Directory: $TARGET_DIR"
    echo "Extension filter: (all files)"
fi

echo "File count: $file_count"
echo "Total size: $total_size bytes ($(numfmt --to=iec $total_size))"
exit 0