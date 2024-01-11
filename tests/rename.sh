RUST_EXE=$PWD"/target/debug"
PATH=$RUST_EXE:$PATH
#echo $PATH
cp features/media/sony_jpg/*.JPG tmp/aruba/
ftls tmp/aruba | ftstd -a anb --verbose