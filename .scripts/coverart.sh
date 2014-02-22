#!/bin/bash
#coverart.sh


DEFAULT_COVER="~/.config/awesome/icons/notporn.jpg"

MUSICDIR="/Data/Music"
# `cat /etc/mpd.conf | grep -v "#" | grep music_directory`
#MUSICDIR=${MUSICDIR:16}
#MUSICDIR=${MUSICDIR%/$}

MFILE=`mpc current -f %file%`
MFILE=${MFILE%/*}
MFILE=${MFILE%/$}

FULLDIR="$MUSICDIR/$MFILE"

[ -n "$FULLDIR" ] && COVERS=`ls "$FULLDIR" | grep "\.jpg\|\.png\|\.gif"`

if [ -z "$COVERS" ]; then
	COVERS="$DEFAULT_COVER"
else
	TRYCOVERS=`echo "$COVERS" | grep -i "cover\|front\|folder\|albumart" | head -n 1`
	
	if [ -z "$TRYCOVERS" ]; then
		TRYCOVERS=`echo "$COVERS" | head -n 1`
		if [ -z "$TRYCOVERS" ]; then
			TRYCOVERS="$DEFAULT_COVER"
		else
			TRYCOVERS="$FULLDIR/$TRYCOVERS"
		fi
	else
		TRYCOVERS="$FULLDIR/$TRYCOVERS"
	fi

	COVERS="$TRYCOVERS"
fi

echo -n "$COVERS"
