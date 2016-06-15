#! /bin/sh

# default trackfile is "tracked.txt", but can be overridden?
trackfile="tracked.txt"
# default storage is ./storage
storage="./dotfiles"

# get the operation (copy in or out)
op=""
if [ -z $1 ]; then
	# if no arg, then assume we're copying in
	op="copyin"
elif [ $1 == "out" ]; then
	# if arg is out, then we're copying out
	op="copyout"
else
	# if arg is not blank or "out", then bail
	echo "unknown command"
	exit 1
fi

# read from the trackfile
while read -r line || [[ -n "$line" ]]; do
	if [ $op == "copyin" ]; then
		echo "copying $line in to $storage"
		eval cp -r "~/$line" "$storage/$line"
	else
		echo "copying $line out of $storage"
		eval cp -r "$storage/$line" "~/$line"
	fi
done < "$trackfile"

