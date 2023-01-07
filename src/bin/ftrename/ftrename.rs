use crate::CliArgs;

// app class
pub struct App {}

impl App {
    pub fn init(args: CliArgs) -> App {
        log::debug!("Start init");

        log::debug!("Finish init");
        App {}
    }

    pub fn run(&self) {
        log::debug!("Start run");

        log::debug!("Finish run");
    }

    // output file to stdout
}
