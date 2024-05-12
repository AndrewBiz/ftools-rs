// #![feature(unix_sigpipe)]
mod ftls_lib;

const VERSION: &str = "0.1.1";
const COMMAND_NAME: &str = "ftls";

// command options and arguments
use clap::Parser;
#[derive(Parser, Debug)]
#[command(name = COMMAND_NAME)]
#[command(version = VERSION)]
#[command(long_about = None, verbatim_doc_comment)]
#[command(rename_all = "snake_case")]

/// ****************** Keep Your Media Files In Order (c) ANB ******************
/// ftls scans given directories and generates list of files to standard
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
/// ---
///    ftls abc 'IMG_*.jpg' | ftstd -a anb
/// # scans 'abc' folder and sends all found IMG_*.jpg files to ftstd command
/// ---

pub struct CliArgs {
    #[arg(verbatim_doc_comment)]
    /// Set DIRs to be scanned and FILEMASKs to filter files.
    /// Empty value is treated as if the user sets `ftls . '*.*'`
    dir_or_filemask: Vec<String>,

    #[arg(short = 'R', long)]
    /// Recursively scan directories
    recursive: bool,

    #[arg(long, verbatim_doc_comment)]
    /// Sets the range of filename endings to be included
    /// into the output. Example: --range '05..07' will take
    /// only files with the filename endings 05, 06, 07 and
    /// will not take any other files
    range: Option<String>,

    #[arg(long)]
    /// Show supported file types
    supported_types: bool,

    #[arg(long)]
    /// Show debug information
    debug: bool,
}

// #[unix_sigpipe = "sig_dfl"]
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
            "ftls explicitly supports file types: {:#?}",
            ftools::SUPPORTED_FILE_TYPE
        );
        std::process::exit(0)
    }
    let app = ftls_lib::App::init(cli_args);
    app.run();

    log::debug!("FINISH main");
}

#[test]
fn verify_cli_args() {
    use clap::CommandFactory;
    CliArgs::command().debug_assert()
}
