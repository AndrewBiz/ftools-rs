// command options and arguments
use clap::Parser;

#[derive(Parser, Debug)]
#[clap(version, long_about = None, verbatim_doc_comment)]

///     *Keep Your Media Files In Order* (c) ANB
///     ftls scans given directories and generates list of files to standard
/// output. In short it acts like 'ls' command (or 'dir' in Windows) but only for
/// media files supported by ftools.
/// Set DIRs to be scanned as a parameters. If no DIRs are set - current dir (.)
/// will be scanned. Set FILEMASKs as a parameters - and only files matching the
/// masks will be processed. If no FILEMASK is set '*.*' will be used by-default.
/// To avoid unnecessary mask extraction by OS - put it in ''.
///     ftls acts as a 'source' program meaning it does not require any input
/// from STDIN, it generates list of files based on input parameters and sends it
/// to STDOUT. The command is intended to be used with other programs
/// connected via pipes as a 1st command in the pipe chain, e.g.:
/// ```
///    ftls abc '*aaa*' | ftrename -a anb
/// ```
/// => scans 'abc' folder and sends all found files filtered
/// with *aaa* to ftrename command

struct CliArgs {
    #[clap(long)]
    /// Show supported file types
    supported_types: bool,
}

fn main() {
    let cli_args = CliArgs::parse();
    if cli_args.supported_types {
        println!(
            "ftls supports file types: {:?}",
            ftools::SUPPORTED_FILE_TYPE
        );
        std::process::exit(0)
    }

    // TMP globing
    let glob_options = glob::MatchOptions {
        case_sensitive: false,
        require_literal_separator: false,
        require_literal_leading_dot: true,
    };
    for entry in glob::glob_with("./*.jpg", glob_options).unwrap() {
        match entry {
            Ok(path) => println!("{}", path.display()),
            Err(e) => println!("{:?}", e),
        }
    }
    // dbg!(cli_args);
}
