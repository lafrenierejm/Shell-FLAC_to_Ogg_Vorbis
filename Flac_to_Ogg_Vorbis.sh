# Original script provided by will177 on LinuxQuestions.org
# www.linuxquestions.org/questions/linux-general-1/bash-script-to-convert-flac-album-to-ogg-vorbis-preserving-tags-772235/

# Ensure that oggenc is available
# Exit with code 1 otherwise
command -v oggenc >/dev/null 2>&1 || { echo "This script requires oggenc. Aborting." >&2; exit 1; }

if [ $# -lt 2 ]; then	# Ensure that two arguments were supplied
	printf "%s"\
		"Please supply the source of the FLAC files "\
		"(e.g. ~/Music/FLAC/Artist_Name/Album/) "\
		"followed by the desired destination "\
		"(e.g. ~/Music/ogg/Artist_Name/Album/)."
	printf "\n"
else
	SRC_DIR=$1	# First argument is the source directory
	DST_DIR=$2	# Second argument is the destination directory

	if [ -d "$SRC_DIR" ]; then
		# Prompt if DST_DIR pre-exists
		if [ -d "$DST_DIR" ]; then
			# Print the prompt
			printf "%s"\
				"The directory $DST_DIR already exists. "\
				"Write to it anyway (Y/N)? "

			# Read a single character
			read -n 1 writeExisting

			# If user did not input 'Y' or 'y', then exit script
			if [ $writeExisting != "Y" ] && [ $writeExisting != "y" ]; then
				printf "\n"
				exit 1
			fi
		fi

		# Let user know about ongoning encoding
		printf "\n%s\n"\
			"Will Ogg-encode the files in ${SRC_DIR} to ${DST_DIR}"

		# Make the destination directory
		mkdir -p "$DST_DIR"

		# Go to the source directory
		cd "$SRC_DIR"

		# Loop through the source directory
		for i in *.flac; do oggenc -q6 -o "${DST_DIR}${i%%flac}ogg" "$i"; done

	# If source directory does not exist
	else
		# Print a message to the user
		printf "%sn"\
			"Source directory $SRC_DIR does not exist."
	fi
fi

# Return 0
exit 0
