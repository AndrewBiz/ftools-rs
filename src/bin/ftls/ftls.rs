use crate::CliArgs;

// app class
pub struct App {
    dirs2scan: Vec<String>,
}

impl App {
    pub fn init(args: CliArgs) -> App {
        // dbg!(&args);
        // checking which dirs to scan
        let mut dirs2scan: Vec<String> = Vec::new();
        for item in &args.dir_or_filemask {
            let dir = std::path::Path::new(item);
            if dir.is_dir() {
                dirs2scan.push(dir.to_str().unwrap().to_string())
            }
        }
        App { dirs2scan }
    }

    pub fn run(&self) {
        let glob_options = glob::MatchOptions {
            case_sensitive: false,
            require_literal_separator: false,
            require_literal_leading_dot: true,
        };
        // dbg!(&self.dirs2scan);
        for dir in &self.dirs2scan {
            let mut pattern = String::new();
            pattern.push_str(dir);
            pattern.push('/');
            pattern.push_str("[!.]*.*");
            // dbg!(&pattern);
            for entry in
                glob::glob_with(&pattern, glob_options).expect("Failed to read glob pattern")
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
