#![feature(unix_sigpipe)]
use anyhow::{Context, Result};

mod ftstd_lib;

const VERSION: &str = "0.1.3";
const COMMAND_NAME: &str = "ftstd";

// command options and arguments
use clap::Parser;
#[derive(Parser, Debug)]
#[command(name = COMMAND_NAME)]
#[command(version = VERSION)]
#[command(long_about = None, verbatim_doc_comment)]

/// ****************** Keep Your Media Files In Order (c) ANB ******************
/// ftstd renames the original media file to the ft-standard name. For example,
/// the file "DSC03455.JPG" with Exif:DateTimeOriginal = "2013:01:08 12:41:45"
/// and the author set as "ANB" will be renamed to "20130108-124145_ANB DSC03455.JPG"
/// ---
/// ft-standard template: YYYYmmdd-HHMMSS_AAA ORIGINAL.EXT, where:
///     YYYYmmdd-HHMMSS - Date-Time of content creation,
///     AAA - the author nickname,
///     ORIGINAL.EXT - the original file name (e.g. given by digital camera)
/// ---
/// By default date-time info is taken from EXIF area (in most cases DateTimeOriginal tag).
/// If no internal tags found - FileModifiedDate is used instead
/// ftstd acts as a 'filter' meaning it expects the input files to be passed
/// to STDIN and after the job is done it produces STDOUT with the list of renamed
/// files. In other words this command is intended to be used with other programs
/// connected via pipes, e.g.:
/// ---
///     ftls | ftstd -a anb | some_other_program_using_stdin
/// ---
/// The program is designed to be safe to re-run on the same file several times
/// - every re-run produces the same result (idempotent behaviour).
/// Once the file was renamed to the ft-standard name, the date-time kept in the name
/// is considered as a master date-time of the content creation and will not be
/// changed by re-running ftstd unless user explicitly sets correspondig option.
/// This program in some cases uses external utility ExifTool created by Phil Harvey
/// (http://www.sno.phy.queensu.ca/~phil/exiftool/).

pub struct CliArgs {
    // TODO! - validation via #[arg(value_parser = valid_autor)]
    #[arg(long, short = 'a', required_unless_present("undo"))]
    /// Sets the author nickname. The nickname should be 3 to 6 ASCII chars long
    author: Option<String>,

    #[arg(long, short = None, conflicts_with("author"))]
    /// Rename file back to it's original name
    undo: bool,

    #[arg(long)]
    /// Show debug information
    debug: bool,
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

    let app = ftstd_lib::App::init(cli_args);
    app.run().context("Running ftstd")?;

    log::debug!("FINISH main");
    Ok(())
}

#[test]
fn verify_cli_args() {
    use clap::CommandFactory;
    CliArgs::command().debug_assert()
}
