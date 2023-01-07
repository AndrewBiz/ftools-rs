use crate::CliArgs;
use std::io;

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
        // TODO! https://stackoverflow.com/questions/65755853/simple-word-count-rust-program-outputs-valid-stdout-but-panicks-when-piped-to-he
        // let stdin = io::stdin();
        // for result in stdin.lock().lines() {
        //     let line = result?;
        //     line_processor(line, &mut words)
        // }
        let mut input = String::new();
        let stdin = io::stdin();
        match stdin.read_line(&mut input) {
            Ok(n) => {
                println!("bytes read {n}");
                println!("line read: {input}")
            }
            Err(e) => println!("error! - {e}"),
        }
        // let lines = io::stdin().lines();
        // for line in lines {
        //     match line {
        //         Ok(line) => eprintln!("got a line: {}", line),
        //         Err(e) => eprintln!("ERROR in stdin: {:?}", e),
        //     }
        // }
        log::debug!("Finish run");
    }

    // output file to stdout
}
