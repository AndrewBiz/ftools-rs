// output file to stdout
pub fn output_file(path: &std::path::Path) {
    // checking file extension - should be exist and supported
    match path.extension() {
        None => return,
        Some(ext) => {
            let ext = ext.to_ascii_lowercase();
            match ftools::SUPPORTED_FILE_TYPE
                .iter()
                .position(|&supported_ext| supported_ext == ext)
            {
                None => return,
                Some(_) => {
                    println!("{}", path.display());
                }
            }
        }
    }
}
