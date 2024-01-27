# usage: 
#    tests/cucu.sh
#    tests/cucu.sh -t @ftrename
RUST_EXE=$PWD"/target/debug"
FEATURES=$PWD"/features"
PATH=$RUST_EXE:$FEATURES:$PATH
#echo $PATH

echo "****** CARGO TEST ********************************"
cargo test
echo "******* CUCUMBER TEST ****************************"
# cucumber -f progress summary -msi $@
cucumber -f progress $@
echo "**************************************************"
# cucumber $@