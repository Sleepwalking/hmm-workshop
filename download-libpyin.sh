git clone https://github.com/Sleepwalking/libpyin
cd libpyin/external
git clone https://github.com/Sleepwalking/libgvps
cd libgvps
echo 'Building libgvps...'
mkdir build
make
cd ../..
echo 'Building libpyin...'
mkdir build
make
echo 'Building libpyin test code...'
make test

