#!/bin/sh

# List of scripts that need installed
SUITE=( small )

# Define the installation configuration
INSTALLPREFIX=~/.syntra
URLPREFIX="https://raw.githubusercontent.com/mediachicken/SyntraSmall-CLI/master"


# Determine whether to use wget or curl
if hash wget 2>/dev/null; then
  DOWNLOADER="wget"
elif hash curl 2>/dev/null; then
  DOWNLOADER="curl"
else
  echo "You must have either wget or curl installed."
  exit 1;
fi

# Create the installation directory if it doesn't exist
if [[ ! -d $INSTALLPREFIX ]]; then
    mkdir -p $INSTALLPREFIX
fi

# For scripts in the suite...
for i in "${SUITE[@]}"
do
    if [[ $DOWNLOADER == "wget" ]]; then
        echo "Downloading $i..."
        wget -O $INSTALLPREFIX/$i $URLPREFIX/$i -q
        echo "Done."
    elif [[ $DOWNLOADER == "curl" ]]; then
        echo "Downloading $i..."
        curl -o $INSTALLPREFIX/$i $URLPREFIX/$i -s
        echo "Done."
    fi
    echo "Installing $i..."
    chmod +x $INSTALLPREFIX/$i
    echo "Done."
done

echo "
Finished installing.

What next? Put this:
    source ${INSTALLPREFIX/SUITE[0]}

At the bottom of your ~/.bash_profile file.";