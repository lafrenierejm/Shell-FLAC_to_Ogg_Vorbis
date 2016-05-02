#!/bin/sh

# Original script provided by will177 on LinuxQuestions.org
# www.linuxquestions.org/questions/linux-general-1/bash-script-to-convert-flac-album-to-ogg-vorbis-preserving-tags-772235/

#ISC License
#
#Copyright (c) 2016, Joseph LaFreniere <joseph@lafreniere.xyz>
#
#Permission to use, copy, modify, and/or distribute this software for any
#purpose with or without fee is hereby granted, provided that the above
#copyright notice and this permission notice appear in all copies.
#
#THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
#WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
#MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
#ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
#WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
#ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
#OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

# Ensure that oggenc is available
## Exit -1 otherwise
command -v oggenc >/dev/null 2>&1 || {
	printf "This script requires oggenc. Aborting.\n" >&2
	exit -1
}

# Ensure that two arguments were supplied
## Exit 1 otherwise
if [ $# -lt 2 ]; then
	printf "Usage: %s <source directory> <destination directory>\n"\
		"$0"
	exit 1
fi

src_dir=$1	# First argument is the source directory
dst_dir=$2	# Second argument is the destination directory

# Ensure that $src_dir exists
## Exit 1 otherwise
if [ ! -d "$src_dir" ]; then
	printf "Source directory \`%s\` does not exist\n"
		"$src_dir"
	exit 1
fi

# Prompt if $dst_dir already exists
if [ -d "$dst_dir" ]; then
	# Print the prompt
	printf "The directory \`%s\` already exists. Write to it anyway (y/N)? "\
		"$dst_dir"

	# Get user input
	read -r write_existing_dst
	case "$write_existing_dst" in
		# Break if input began with 'y' or 'Y'
		[yY]*)
			;;
		# Else exit 0
		*)
			printf "Exiting without writing\n"
			exit 0
	esac
fi

# Make the destination directory
mkdir -p "$dst_dir"

# Loop through the source directory
for i in "$src_dir"/*.flac; do
	oggenc -q6 -o "${dst_dir}/{i%%flac}ogg" "$i"
done

# Exit 0
exit 0
