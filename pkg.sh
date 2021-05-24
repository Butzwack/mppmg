#!/bin/bash

update()
{
	echo "Updating "$package
	if [ $package = "all" ]; then
		cd ~/mppmg/package/update
		for f in *.sh; do
			echo "$f:"
			bash "$f"
		done
	else
		~/mppmg/package/update/$package.sh
	fi
}

install()
{
	echo "Installing "$package
	#if [ ls ~/git | grep $package = 1 ]; then
	#	echo "already"
	#else
		~/mppmg/package/install/$package.sh
	#fi
	
}

command=$1
package=$2
if ( $command = "update" ); then
	$update
elif ( $command = "install" ); then
	$install
fi

