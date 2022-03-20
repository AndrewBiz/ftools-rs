mod ftools {
    pub const SUPPORTED_FILE_TYPE: [&str; 2] = ["jpg", "heic"];
    // FILE_TYPE_IMAGE_NORMAL = %w[jpg jpeg tif tiff png heic].freeze
    // FILE_TYPE_IMAGE_RAW = %w[orf arw dng].freeze
    // FILE_TYPE_IMAGE = FILE_TYPE_IMAGE_NORMAL + FILE_TYPE_IMAGE_RAW
    // FILE_TYPE_VIDEO = %w[avi mp4 mpg mts dv mov mkv m2t m2ts 3gp].freeze
    // FILE_TYPE_AUDIO = %w[wav].freeze
}

// command options and arguments
use clap::Parser;
#[derive(Parser, Debug)]
#[clap(version, long_about = None)]
#[clap(about =
"*Keep Your Media Files In Order* (c) ANB

ftls scans given directories and generates list of files to standard
output. In short it acts like 'ls' command (or 'dir' in Windows) but only for
media files supported by ftools.
Set DIRs to be scanned as a parameters. If no DIRs are set - current dir (.)
will be scanned. Set FILEMASKs as a parameters - and only files matching the
masks will be processed. If no FILEMASK is set '*.*' will be used by-default.
To avoid unnecessary mask extraction by OS - put it in ''.

ftls acts as a 'source' program meaning it does not require any input
from STDIN, it generates list of files based on input parameters and sends it
to STDOUT. The command is intended to be used with other programs
connected via pipes as a 1st command in the pipe chain, e.g.:

    ftls abc '*aaa*' | ftrename -a anb

=> scans 'abc' folder and sends all found files filtered
with *aaa* to ftrename command.")]
struct Opt {
    #[clap(long)]
    /// Show supported file types
    supported_types: bool,
}

fn main() {
    let opt = Opt::parse();
    if opt.supported_types {
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
        require_literal_leading_dot: false,
    };
    for entry in glob::glob_with("./*.jpg", glob_options).unwrap() {
        match entry {
            Ok(path) => println!("{:?}", path.display()),
            Err(e) => println!("{:?}", e),
        }
    }
    // dbg!(opt);
}
