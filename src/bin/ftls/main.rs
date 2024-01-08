#![feature(unix_sigpipe)]
mod ftls_lib;

// command options and arguments
use clap::Parser;

#[derive(Parser, Debug)]
#[clap(version, long_about = None, verbatim_doc_comment)]

/// *Keep Your Media Files In Order* (c) ANB
///     ftls scans given directories and generates list of files to standard
/// output. In short it acts like 'ls' command (or 'dir' in Windows) but only for
/// media files supported by ftools.
/// Set DIRs to be scanned as an arguments. If no DIRs are set - current dir '.'
/// will be scanned. Set FILEMASKs as an arguments - and only files matching the
/// masks will be processed. If no FILEMASK is set '*.*' will be used by-default.
/// To avoid unnecessary mask extraction by OS - put it in ''.
///     ftls acts as a 'source' program meaning it does not require any input
/// from STDIN, it generates list of files based on input parameters and sends it
/// to STDOUT. The command is intended to be used with other programs
/// connected via pipes as a 1st command in the pipe chain, e.g.:
///    ftls abc 'IMG_*.jpg' | ftrename -a anb
/// => scans 'abc' folder and sends all found IMG_*.jpg files to ftrename command

pub struct CliArgs {
    #[clap(long)]
    /// Show debug information
    debug: bool,

    #[clap(long)]
    /// Show supported file types
    supported_types: bool,

    #[clap(short = 'R', long)]
    /// Recursively scan directories
    recursive: bool,

    #[clap(long, verbatim_doc_comment)]
    /// Sets the range of filename endings to be included
    /// into the output. Example: --range '05..07' will take
    /// only files with the filename endings 05, 06, 07 and
    /// will not take any other files
    range: Option<String>,

    #[clap(verbatim_doc_comment)]
    /// Set DIRs to be scanned and FILEMASKs to filter files.
    /// Empty value is treated as if the user sets `ftls . '*.*'`
    dir_or_filemask: Vec<String>,
}

#[unix_sigpipe = "sig_dfl"]
fn main() {
    let cli_args = CliArgs::parse(); // TODO try_parse - to capture --help and --version events
    if cli_args.debug {
        env_logger::Builder::new()
            .filter_level(log::LevelFilter::Debug)
            .init();
    } else {
        env_logger::init();
    }
    log::debug!("START main");
    log::debug!("Arguments set by the user: {:?}", &cli_args);

    if cli_args.supported_types {
        println!(
            "ftls supports file types: {:#?}",
            ftools::SUPPORTED_FILE_TYPE
        );
        std::process::exit(0)
    }
    let app = ftls_lib::App::init(cli_args);
    app.run();

    log::debug!("FINISH main");
}
