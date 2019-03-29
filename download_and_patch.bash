mkdir -p git

if [ ! -f git/kbhff_dk_cleaned.sql ]; then
	wget -nc https://github.com/kbhff/udvikler_kbhff_dk/raw/master/theme/www/assets/kbhff_dk_cleaned.sql.zip -O git/kbhff_dk_cleaned.sql.zip
	unzip git/kbhff_dk_cleaned.sql.zip -d git
fi

if [ ! -d git/kbhff_dk ]; then
	git clone https://github.com/kbhff/kbhff_dk.git git/kbhff_dk
	pushd git/kbhff_dk
	git submodule init && git submodule update
	popd
fi

if [ ! -d git/ubuntu_environment ]; then
	git clone https://github.com/parentnode/ubuntu_environment.git git/ubuntu_environment
fi

./patches/apply_patches.sh
