RUST_EXE=$PWD"/target/debug"
PATH=$RUST_EXE:$PATH
#echo $PATH
ftls tmp/aruba | ftrename -a anb --debug