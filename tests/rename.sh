RUST_EXE=$PWD"/target/debug"
PATH=$RUST_EXE:$PATH
#echo $PATH
ftls tmp/aruba/rename1 | ftrename -a anb --debug