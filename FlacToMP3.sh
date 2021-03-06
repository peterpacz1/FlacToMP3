#!/bin/bash

# Variables
QUALITY=0 # Lower is better.
CODEC="a libmp3lame" # Codec for converting flac to MP3. (This worked on my Mac)
OUTPUTDIR="." # Default set as current folder.
INPUTTYPE="flac" # Input type is flac as default.
OUTPUTTYPE="mp3" # Output type is MP3 as default.

function dependencies_check () {
    command -v ffmpeg -version >/dev/null 2>&1 ||
    	{ echo >&2 "Error: ffmpeg is needed to run this script."
    		echo "To install mktorrent, visit https://www.ffmpeg.org/"
            echo "or run \"apt-get install ffmpeg\" as root."
    		echo; exit 1
    	}
}

# Main program function
function FlacToMP3 () {
  # First makes sure that input type and output type are flac and mp3, respectively
  if [ $INPUTTYPE == "flac" ] && [ $OUTPUTTYPE == "mp3" ]; then
      # Iterates over all .flac files in directory
      for FILE in *.flac; do
        # Summons ffmpeg command with current file as input, and uses the libmp3lame codec.
        ffmpeg -i "$FILE" -codec:$CODEC -q:a $QUALITY "$OUTPUTDIR/${FILE%.*}.mp3";
      done

  # If input file format and output file format doesn't make sense, then
  else

    # Exits with error value of 1 in case something bad happens.
    echo "Error, $INPUTTYPE and $OUTPUTTYPE mismatch: doesn't make sense!"
    exit 1;
  fi
}

# Startup message.
echo "Starting FlacToMP3, version 1.1.0."
FlacToMP3

# Exits with success as default exit value.
echo "All done, exiting!"
exit 0
