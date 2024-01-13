use crate::CliArgs;
use anyhow::{anyhow, Result};
use atty::Stream;
use std::{default, io::BufRead};

// app class
pub struct App {
    author: String,
    undo: bool,
    verbose: bool,
}

impl App {
    pub fn init(args: CliArgs) -> App {
        log::debug!("Start app init");
        // let author = args.author.to_ascii_uppercase();
        let author = args.author.unwrap_or_default().to_ascii_uppercase();
        log::debug!("Finish app init");
        App {
            author,
            undo: args.undo,
            verbose: args.verbose,
        }
    }

    pub fn run(&self) -> Result<()> {
        log::debug!("Start run");
        // if program is run in terminal - quit
        if atty::is(Stream::Stdin) {
            return Err(anyhow!(
                "Command should be executed in a pipe mode (e.g. ftls | ftstd -a anb)"
            ));
        }

        // processing stdin lines
        let stdin = std::io::stdin();
        for line in stdin.lock().lines() {
            let line = line.unwrap_or_default();

            match self.process_file(&line) {
                Ok((out_fn, verbose_msg)) => {
                    ftools::output_to_stdout(&out_fn);
                    if self.verbose {
                        ftools::output_to_stderr(&verbose_msg)
                    }
                }
                Err(e) => eprintln!("    [error: {} - {}]", &line, e),
            }
        }
        log::debug!("Finish run");
        Ok(())
    }

    pub fn process_file(&self, in_fn: &String) -> Result<(String, String)> {
        log::debug!("Started processing {}", in_fn);

        let mf = ftools::media_file::init(in_fn.clone(), self.author.clone())?; // TODO: not to exit in case of error
        log::debug!("MediaFile read: {:?}", mf);

        let out_fn;
        let verbose_msg: String;
        // TODO: To be changed depending on input parameters
        if self.undo {
            // renaming to the original name
            out_fn = mf.fs_path_original.to_str().unwrap_or_default().to_string();
            if mf.fn_already_standard {
                verbose_msg = format!("");
            } else {
                verbose_msg = format!("    [name is not ft-standard - nothing to undo]");
            }
        } else {
            // renaming to standard name
            out_fn = mf.fs_path_standard.to_str().unwrap_or_default().to_string();
            if mf.fn_already_standard {
                verbose_msg = format!("    [name is already ft-standard - keeping unchanged]");
            } else {
                verbose_msg = format!(
                    "    [date-time source: {}, reader: {}]",
                    mf.dt_created.name, mf.dt_created.reader
                );
            }
        }

        // renaming the file (if needed):
        if *in_fn == out_fn {
            log::debug!("... keeping file_name unchanged");
        } else {
            log::debug!("... renaming to: {}", &out_fn);
            std::fs::rename(in_fn, &out_fn)?;
        }
        log::debug!("Finished processing {}", &in_fn);
        Ok((out_fn, verbose_msg))
    }
}
