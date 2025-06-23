#!/bin/bash

# ------------------ Argument Variables ------------------
COMMAND=$1       # Command to execute
PATH_DIR=$2      # Directory path
DIR_NAME=$3      # Directory or file name (depending on command)
VALUE=$4         # Additional value (content or line number)
VALUE2=$5        # Additional value 2 (end of line range, etc.)
# ------------------ Command Handling ------------------

# Create a directory
if [ "$COMMAND" = "addDir" ]; then
  mkdir -p "$PATH_DIR/$DIR_NAME"
  echo "✅ Directory '$DIR_NAME' created in $PATH_DIR"

# Delete a directory
elif [ "$COMMAND" = "deleteDir" ]; then
  if [ -d "$PATH_DIR/$DIR_NAME" ]; then
    rm -r "$PATH_DIR/$DIR_NAME"
    echo "🗑️ Directory '$DIR_NAME' deleted from $PATH_DIR"
  else
    echo "⚠️ Directory '$DIR_NAME' does not exist in $PATH_DIR"
  fi

# List only files in a directory
elif [ "$COMMAND" = "listFiles" ]; then
  echo "📄 Files in $PATH_DIR:"
  find "$PATH_DIR" -maxdepth 1 -type f

# List only directories in a path
elif [ "$COMMAND" = "listDirs" ]; then
  echo "📁 Directories in $PATH_DIR:"
  find "$PATH_DIR" -maxdepth 1 -type d

# List all contents of a directory
elif [ "$COMMAND" = "listAll" ]; then
  echo "📦 All contents in $PATH_DIR:"
  ls -l "$PATH_DIR"

# Create a file with optional content
elif [ "$COMMAND" = "addFile" ]; then
  mkdir -p "$PATH_DIR"
  if [ -z "$VALUE" ]; then
    touch "$PATH_DIR/$DIR_NAME"
    echo "📄 File '$DIR_NAME' created"
  else
    echo "$VALUE" > "$PATH_DIR/$DIR_NAME"
    echo "📄 File '$DIR_NAME' created with content"
  fi

# Append content to end of file
elif [ "$COMMAND" = "addContentToFile" ]; then
  if [ -f "$PATH_DIR/$DIR_NAME" ]; then
    echo "$VALUE" >> "$PATH_DIR/$DIR_NAME"
    echo "📄 Additional content added to '$DIR_NAME'"
  else
    echo "❌ File does not exist: $PATH_DIR/$DIR_NAME"
  fi

# Add content at the beginning of a file
elif [ "$COMMAND" = "addContentToFileBegining" ]; then
  if [ -f "$PATH_DIR/$DIR_NAME" ]; then
    echo "$VALUE" | cat - "$PATH_DIR/$DIR_NAME" > temp && mv temp "$PATH_DIR/$DIR_NAME"
    echo "📄 Content added at the beginning of '$DIR_NAME'"
  else
    echo "❌ File does not exist: $PATH_DIR/$DIR_NAME"
  fi

# Show top N lines of file
elif [ "$COMMAND" = "showFileBeginingContent" ]; then
  if [ -f "$PATH_DIR/$DIR_NAME" ]; then
    head -n "$VALUE" "$PATH_DIR/$DIR_NAME"
  else
    echo "❌ File does not exist: $PATH_DIR/$DIR_NAME"
  fi

# Show last N lines of file
elif [ "$COMMAND" = "showFileEndContent" ]; then
  if [ -f "$PATH_DIR/$DIR_NAME" ]; then
    tail -n "$VALUE" "$PATH_DIR/$DIR_NAME"
  else
    echo "❌ File does not exist: $PATH_DIR/$DIR_NAME"
  fi

# Show content at a specific line number
elif [ "$COMMAND" = "showFileContentAtLine" ]; then
  if [ -f "$PATH_DIR/$DIR_NAME" ]; then
    sed -n "${VALUE}p" "$PATH_DIR/$DIR_NAME"
  else
    echo "❌ File does not exist: $PATH_DIR/$DIR_NAME"
  fi

# Show content from line X to line Y
elif [ "$COMMAND" = "showFileContentForLineRange" ]; then
  if [ -f "$PATH_DIR/$DIR_NAME" ]; then
    sed -n "${VALUE},${VALUE2}p" "$PATH_DIR/$DIR_NAME"
  else
    echo "❌ File does not exist: $PATH_DIR/$DIR_NAME"
  fi

# Move file to destination or rename it
elif [ "$COMMAND" = "moveFile" ]; then
  if [ ! -f "$PATH_DIR" ]; then
    echo "❌ Source file does not exist: $PATH_DIR"
  else
    if [ -f "$DIR_NAME" ]; then
      mv "$PATH_DIR" "$DIR_NAME"
      echo "📂 File '$PATH_DIR' renamed and moved to '$DIR_NAME'"
    elif [ -d "$DIR_NAME" ]; then
      mv "$PATH_DIR" "$DIR_NAME"
      echo "📂 File '$PATH_DIR' moved to directory '$DIR_NAME'"
    else
      echo "📂 Destination directory does not exist: $DIR_NAME"
    fi
  fi

# Copy file to another location
elif [ "$COMMAND" = "copyFile" ]; then
  SOURCE="$PATH_DIR"
  DEST="$DIR_NAME"

  if [ ! -f "$SOURCE" ]; then
    echo "❌ Source file does not exist: $SOURCE"
  else
    if [ -d "$DEST" ]; then
      cp "$SOURCE" "$DEST/"
      echo "📄 File '$SOURCE' copied to directory '$DEST/'"
    else
      cp "$SOURCE" "$DEST"
      echo "📄 File '$SOURCE' copied to '$DEST'"
    fi
  fi

# Clear all content in a file
elif [ "$COMMAND" = "clearFileContent" ]; then
  if [ -f "$PATH_DIR/$DIR_NAME" ]; then
    > "$PATH_DIR/$DIR_NAME"
    echo "🧹 File '$DIR_NAME' content cleared"
  else
    echo "❌ File does not exist: $PATH_DIR/$DIR_NAME"
  fi

# Delete a file
elif [ "$COMMAND" = "deleteFile" ]; then
  if [ -f "$PATH_DIR/$DIR_NAME" ]; then
    rm "$PATH_DIR/$DIR_NAME"
    echo "🗑️ File '$DIR_NAME' deleted"
  else
    echo "❌ File does not exist: $PATH_DIR/$DIR_NAME"
  fi

# Invalid command handler
else
  echo "❌ Invalid command: $COMMAND"
fi