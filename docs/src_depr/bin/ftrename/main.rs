#![feature(unix_sigpipe)]
use anyhow::{Context, Result};

mod ftrename;

// command options and arguments
use clap::Parser;
#[derive(Parser, Debug)]
#[clap(version, long_about = None, verbatim_doc_comment)]
/// *Keep Your Media Files In Order* (c) ANB
///      ftrename renames the input file to Standard Name:
/// YYYYmmdd-HHMMSS_AAA ORIGINAL.EXT, where:
/// YYYYmmdd-HHMMSS - Date-Time of content creation,
/// AAA - the author nickname,
/// ORIGINAL.EXT - the original file name (e.g. given by digital camera).
/// By default date-time info is taken from EXIF area (in most cases DateTimeOriginal tag).
/// If no internal tags found - FileModifiedDate is used instead
/// Example: input file DSC03455.JPG will be renamed to 20130108-124145_ANB DSC03455.JPG
/// ftrename acts as a 'filter' meaning it expects the input files to be passed
/// to STDIN and after the job is done it produces STDOUT with the list of renamed
/// files. In other words this command is intended to be used with other programs
/// connected via pipes, e.g.:
///     ftls | ftrename -a anb | some_other_program_taking_stdin
/// The program is designed to be safe to re-run on the same file several times
/// - every re-run produces the same result (idempotent behaviour).
/// Once the file was renamed to Standard Name, the date-time kept in the name
/// is considered as a master date-time of the content creation and will not be
/// changed by re-running ftrename unless user explicitly sets correspondig option.
/// This program uses external utility ExifTool created by Phil Harvey
/// (http://www.sno.phy.queensu.ca/~phil/exiftool/).

pub struct CliArgs {
    #[clap(long)]
    /// Show debug information
    debug: bool,

    // TODO! - validation via #[arg(value_parser = valid_autor)]
    #[clap(long, short = 'a', verbatim_doc_comment)]
    /// Sets the author nickname. The nickname should be 3 to 6 ASCII chars long (e.g. ANB)
    author: Option<String>,

    // #[clap(long)]
    // /// Force to change author in the name. Useful if file already has Standard Name and you want only change the author keeping date-time unchanged
    // force_author: bool,
    #[clap(long, short = 'c')]
    /// Rename file back to it's original name
    clean: bool,
}

#[unix_sigpipe = "sig_dfl"] // This is for correct working in pipe mode under unix-like systems
fn main() -> Result<()> {
    let cli_args = CliArgs::parse();

    if cli_args.debug {
        env_logger::Builder::new()
            .filter_level(log::LevelFilter::Debug)
            .init();
    } else {
        env_logger::init();
    }
    log::debug!("START main");
    log::debug!("Arguments set by the user: {:?}", &cli_args);

    let app = ftrename::App::init(cli_args);
    app.run().context("Running ftrename")?;

    log::debug!("FINISH main");
    Ok(())
}
