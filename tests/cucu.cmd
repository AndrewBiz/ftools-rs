@path G:\Github\ftools-rs\target\debug;%PATH%

@echo "****** CARGO TEST ********************************"
cargo test
@echo "******* CUCUMBER TEST ****************************"
cucumber -f progress %*
@echo "**************************************************"
