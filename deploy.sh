#!/bin/sh

# When running this script include the commit message after the execute command -> "commit message formatted like this"

if [ $# -eq 0 ]; then
	echo "Error: Provide a commit message. Ex: './deploy \"commit message\"'"
	exit 1
fi

flutter build web --release
cd build/web
git add .
git commit -m "$1"
git push
