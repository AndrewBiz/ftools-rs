use std::io::Write;

pub mod media_file;
pub mod tag;

pub const SUPPORTED_FILE_TYPE: [&str; 31] = [
    "jpg", "jpeg", "heic", "tif", "tiff", "png", "cr2", "cr3", "orf", "arw", "dng", "avi", "mp4",
    "mpg", "mts", "dv", "mov", "mkv", "m2t", "m2ts", "3gp", "wav", "mp3", "flac", "aac", "ogg",
    "m4a", "wma", "alac", "aiff", "ape",
];

// output line to stdout
pub fn output_to_stdout(line: &String) {
    if line.len() > 0 {
        let stdout = std::io::stdout();
        let mut stdout = stdout.lock();
        writeln!(stdout, "{}", line).unwrap_or_default()
    }
}

// output line to stderr
pub fn output_to_stderr(line: &String) {
    if line.len() > 0 {
        let stderr = std::io::stderr();
        let mut stderr = stderr.lock();
        writeln!(stderr, "{}", line).unwrap_or_default()
    }
}
