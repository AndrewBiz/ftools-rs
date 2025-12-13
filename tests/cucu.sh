# usage:
#    tests/cucu.sh
#    tests/cucu.sh -t @ftrename
RUST_EXE=$PWD"/target/debug"
FEATURES=$PWD"/features"
export PATH=$RUST_EXE:$FEATURES:$PATH
echo $RUST_EXE
echo $FEATURES
echo $PATH

echo "****** CARGO TEST ********************************"
cargo test
echo "******* CUCUMBER TEST ****************************"
cucumber -f progress summary -msi $@
cucumber -f progress $@
echo "**************************************************"
cucumber $@
