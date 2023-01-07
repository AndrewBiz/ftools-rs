RUST_EXE=$PWD"/target/debug"
FEATURES=$PWD"/features"
PATH=$RUST_EXE:$FEATURES:$PATH
#echo $PATH
# cucumber -f progress summary -msi $@
cucumber -f progress $@