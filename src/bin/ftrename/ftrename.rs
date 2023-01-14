use crate::CliArgs;
use atty::Stream;
use std::io::BufRead;

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
        // if program is run in terminal - quit
        if atty::is(Stream::Stdin) {
            return;
        }
        let stdin = std::io::stdin();
        for line in stdin.lock().lines() {
            match line {
                Ok(line) => ftools::output_to_stdout(&line),
                Err(e) => eprintln!("ERROR in stdin: {:?}", e),
            }
        }
        log::debug!("Finish run");
    }
}
