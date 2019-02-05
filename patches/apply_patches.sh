patch -r - -N git/kbhff_dk/ci/CodeIgniter-2.2.6/application/config/database.php	< patches/database.php.patch
patch -r - -N git/ubuntu_environment/conf-client/php-apache2.ini < patches/php-apache2.ini.patch
patch -r - -N git/ubuntu_environment/conf-client/php-cli.ini < patches/php-cli.ini.patch
patch -r - -N git/janitor/src/classes/system/cache.class.php < patches/cache.class.php.patch
patch -r - -N git/kbhff_dk/submodules/janitor/src/classes/system/cache.class.php < patches/cache.class.php.patch
