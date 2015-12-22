# Original script provided by will177 on LinuxQuestions.org
# www.linuxquestions.org/questions/linux-general-1/bash-script-to-convert-flac-album-to-ogg-vorbis-preserving-tags-772235/

if [ $# -lt 1 ]; then
	echo " "
	echo "Please supply artist/albumname as argument, e.g. abba/gold"
else
	SRC_DIR=/music/flac/$1

	if [ -d "$SRC_DIR" ]; then
		echo " "
		echo "Will Ogg encode the album $1 "
		echo "from "
		echo "$SRC_DIR"
		echo "to "
		DEST_DIR=/music/ogg/q6/$1
		echo $DEST_DIR
		echo " "
		if [ -d "$DEST_DIR" ]; then
			echo "Destination already exists, will do nothing."
		else
			echo "Ogg encoding album $1 please wait..."
			mkdir -p $DEST_DIR
			cd $SRC_DIR
			for i in *.flac; do oggenc -q6 -o $DEST_DIR/${i%%flac}ogg $i; done
		fi
	else
		echo "Source directory $SRC_DIR does not exist, doing nothing."
	fi
fi

echo "Finished."

