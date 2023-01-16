use std::io::Write;

pub mod media_file;
pub mod tag;

pub const SUPPORTED_FILE_TYPE: [&str; 2] = ["jpg", "heic"];
// FILE_TYPE_IMAGE_NORMAL = %w[jpg jpeg tif tiff png heic].freeze
// FILE_TYPE_IMAGE_RAW = %w[orf arw dng].freeze
// FILE_TYPE_IMAGE = FILE_TYPE_IMAGE_NORMAL + FILE_TYPE_IMAGE_RAW
// FILE_TYPE_VIDEO = %w[avi mp4 mpg mts dv mov mkv m2t m2ts 3gp].freeze
// FILE_TYPE_AUDIO = %w[wav].freeze

// output line to stdout
pub fn output_to_stdout(line: &String) {
    let stdout = std::io::stdout();
    let mut stdout = stdout.lock();
    writeln!(stdout, "{}", line).unwrap_or_default()
}
