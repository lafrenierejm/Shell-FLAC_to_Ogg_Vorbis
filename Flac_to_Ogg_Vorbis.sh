# Original script provided by will177 on LinuxQuestions.org
# www.linuxquestions.org/questions/linux-general-1/bash-script-to-convert-flac-album-to-ogg-vorbis-preserving-tags-772235/

if [ $# -lt 2 ]; then
	echo "Please supply the source of the FLAC files (e.g. ~/Music/FLAC/Artist_Name/Album/) followed by the desired destination (e.g. ~/Music/ogg/Artist_Name/Album/)."
else
	SRC_DIR=$1	# First argument is the source directory
	DST_DIR=$2	# Second argument is the destination directory

	if [ -d "$SRC_DIR" ]; then
		if [ -d "$DST_DIR" ]; then	# Prompt if DST_DIR already exists
			echo "The directory $DST_DIR already exists. Write to it anyway? (Y/N)"
			read -n 1 writeExisting
			if [ $writeExisting != "Y" ] && [ $writeExisting != "y" ]; then
				echo ""
				exit 1	# If user input something other than 'Y' or 'y', exit script
			fi
		fi
		echo ""	# Print empty line
		echo "Will Ogg encode the files in ${SRC_DIR} to ${DST_DIR}\n"
		mkdir -p "$DST_DIR"	# Make the destination directory
		cd "$SRC_DIR"		# Loop through the source directory
		for i in *.flac; do oggenc -q6 -o "${DST_DIR}${i%%flac}ogg" "$i"; done
	else
		echo "Source directory $SRC_DIR does not exist."
	fi
fi

exit 0
