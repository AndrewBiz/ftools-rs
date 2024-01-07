use crate::CliArgs;
use anyhow::{anyhow, Result};
use atty::Stream;
use std::io::BufRead;

// app class
pub struct App {
    author: String,
    // force_author: bool,
    clean: bool,
}

impl App {
    pub fn init(args: CliArgs) -> App {
        log::debug!("Start app init");
        let author = args.author.unwrap_or_default().to_ascii_uppercase();
        // let force_author = args.force_author;
        log::debug!("Finish app init");
        App {
            author,
            // force_author,
            clean: args.clean,
        }
    }

    pub fn run(&self) -> Result<()> {
        log::debug!("Start run");
        // if program is run in terminal - quit
        if atty::is(Stream::Stdin) {
            return Err(anyhow!(
                "Command should be executed in a pipe mode (e.g. ftls | ftrename -a anb)"
            ));
        }

        // processing stdin lines
        let stdin = std::io::stdin();
        for line in stdin.lock().lines() {
            let line = line.unwrap_or_default();

            match self.process_file(&line) {
                Ok(out_fn) => ftools::output_to_stdout(&out_fn),
                Err(e) => eprintln!(" ! {} - {}", &line, e),
            }
        }
        log::debug!("Finish run");
        Ok(())
    }

    pub fn process_file(&self, in_fn: &String) -> Result<String> {
        log::debug!("Started processing {}", in_fn);

        let mf = ftools::media_file::init(in_fn.clone(), self.author.clone())?;
        log::debug!("MediaFile read: {:?}", mf);

        // TODO: To be changed depending on input parameters
        let out_fn = mf.fs_path_standard.to_str().unwrap_or_default().to_string();

        if *in_fn == out_fn {
            log::debug!("... keeping file_name unchanged");
        } else {
            log::debug!("... renaming to: {}", &out_fn);
            std::fs::rename(in_fn, &out_fn)?;
        }
        log::debug!("Finished processing {}", &in_fn);
        Ok(out_fn)
    }
}
