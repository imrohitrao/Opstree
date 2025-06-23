#!/bin/bash
COMMAND=$1      # Options: addDir, deleteDir, listFiles, listDirs, listAll
PATH_DIR=$2
DIR_NAME=$3
VALUE=$4
VALUE2=$5

if [ "$COMMAND" = "addDir" ]; then
  mkdir -p "$PATH_DIR/$DIR_NAME"
  echo "✅ Directory '$DIR_NAME' created in $PATH_DIR"

elif [ "$COMMAND" = "deleteDir" ]; then
  if [ -d "$PATH_DIR/$DIR_NAME" ]; then
    rm -r "$PATH_DIR/$DIR_NAME"
    echo "🗑️ Directory '$DIR_NAME' deleted from $PATH_DIR"
  else
    echo "⚠️ Directory '$DIR_NAME' does not exist in $PATH_DIR"
  fi

elif [ "$COMMAND" = "listFiles" ]; then
  echo "📄 Files in $PATH_DIR:"
  find "$PATH_DIR" -maxdepth 1 -type f

elif [ "$COMMAND" = "listDirs" ]; then
  echo "📁 Directories in $PATH_DIR:"
  find "$PATH_DIR" -maxdepth 1 -type d

elif [ "$COMMAND" = "listAll" ]; then
  echo "📦 All contents in $PATH_DIR:"
  ls -l "$PATH_DIR"

elif [ "$COMMAND" = "addFile" ]; then
  mkdir -p "$PATH_DIR"  
  if [ -z "$VALUE" ]; then
     touch "$PATH_DIR/$DIR_NAME"  
     echo "📄 File '$DIR_NAME' created"
  elif [ -n "$VALUE" ]; then
     echo "$VALUE" > "$PATH_DIR/$DIR_NAME"  
     echo "📄 File '$DIR_NAME' created Addition Text Added"
  fi

elif [ "$COMMAND" = "addContentToFile" ]; then
  if [ -f "$PATH_DIR/$DIR_NAME" ]; then
     echo "$VALUE" >> "$PATH_DIR/$DIR_NAME" 
     echo "📄 Addtional content added in $DIR_NAME"
  else
     echo "❌ Invalid command: $COMMAND"
  fi

elif [ "$COMMAND" = "addContentToFileBegining" ]; then
  if [ -f "$PATH_DIR/$DIR_NAME" ]; then
     echo "$VALUE" | cat - "$PATH_DIR/$DIR_NAME" > temp && mv temp "$PATH_DIR/$DIR_NAME" 
     echo "📄 Addtional content added at the begining of the $DIR_NAME"
  else
     echo "❌ Invalid command: $COMMAND"
  fi

elif [ "$COMMAND" = "showFileBeginingContent" ]; then
  if [ -f "$PATH_DIR/$DIR_NAME" ]; then
     head -n  "$VALUE" "$PATH_DIR/$DIR_NAME" 
  else
     echo "❌ Invalid command: $COMMAND"
  fi

elif [ "$COMMAND" = "showFileEndContent" ]; then
  if [ -f "$PATH_DIR/$DIR_NAME" ]; then
     tail -n  "$VALUE" "$PATH_DIR/$DIR_NAME" 
  else
     echo "❌ Invalid command: $COMMAND"
  fi

elif [ "$COMMAND" = "showFileContentAtLine" ]; then
  if [ -f "$PATH_DIR/$DIR_NAME" ]; then
     #awk 'NR="$VALUE"' "$PATH_DIR/$DIR_NAME" 
     sed -n  "${VALUE}p" "$PATH_DIR/$DIR_NAME"
  else
     echo "❌ Invalid command: $COMMAND"
  fi


elif [ "$COMMAND" = "showFileContentForLineRange" ]; then
  if [ -f "$PATH_DIR/$DIR_NAME" ]; then
     #awk 'NR="$VALUE"' "$PATH_DIR/$DIR_NAME" 
     sed -n  "${VALUE},${VALUE2}p" "$PATH_DIR/$DIR_NAME"
  else
     echo "❌ Invalid command: $COMMAND"
  fi


elif [ "$COMMAND" = "moveFile" ]; then
  
  if [ ! -f "$PATH_DIR" ]; then
     echo "❌ Source file does not exist"
  else
     if [ -f "$DIR_NAME" ]; then
        mv "$PATH_DIR" "$DIR_NAME"
        echo " File '$PATH_DIR' renamed and moved to directory '$SIR_NAME'"
     else
        if [ ! -d "$DIR_NAME" ]; then
          echo "📂 Destination directory does not exist"
        else  
          mv "$PATH_DIR" "$DIR_NAME"
          echo "📂 File '$PATH_DIR' moved to '$DIR_NAME'"
        fi
     fi
  fi

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


elif [ "$COMMAND" = "clearFileContent" ]; then
  if [ -f "$PATH_DIR/$DIR_NAME" ]; then
     > "$PATH_DIR/$DIR_NAME"
     echo "🧹 File '$DIR_NAME' content cleared"
  else
     echo "❌ File does not exist: $PATH_DIR/$DIR_NAME"
  fi

elif [ "$COMMAND" = "deleteFile" ]; then
  if [ -f "$PATH_DIR/$DIR_NAME" ]; then
     rm "$PATH_DIR/$DIR_NAME"
     echo "🗑️ File '$DIR_NAME' deleted"
  else
     echo "❌ File does not exist: $PATH_DIR/$DIR_NAME"
  fi

else
  echo "❌ Invalid command: $COMMAND"
  echo "Valid options: addDir, deleteDir, listFiles, listDirs, listAll"
fi
