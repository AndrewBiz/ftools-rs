RUST_EXE=$PWD"/target/debug"
PATH=$RUST_EXE:$PATH
#echo $PATH
ftls tmp/aruba | ftstd --undo --verbose