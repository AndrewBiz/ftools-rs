// app class
pub struct App {}

impl App {
    pub fn run(&self) {
        let glob_options = glob::MatchOptions {
            case_sensitive: false,
            require_literal_separator: false,
            require_literal_leading_dot: true,
        };
        for entry in glob::glob_with("[!.]*.*", glob_options).expect("Failed to read glob pattern")
        {
            match entry {
                Ok(path) => {
                    output_file(&path);
                }
                Err(e) => eprintln!("ERROR {:?}", e),
            }
        }
    }
}

// output file to stdout
fn output_file(path: &std::path::Path) {
    // checking file extension - should be exist and supported
    match path.extension() {
        None => (),
        Some(ext) => {
            let ext = ext.to_ascii_lowercase();
            match ftools::SUPPORTED_FILE_TYPE
                .iter()
                .position(|&supported_ext| supported_ext == ext)
            {
                None => (),
                Some(_) => println!("{}", path.display()),
            }
        }
    }
}
