use crate::CliArgs;

// app class
pub struct App {
    dirs2scan: Vec<String>,
    file_masks: Vec<String>,
    recursive: bool,
}

impl App {
    pub fn init(args: CliArgs) -> App {
        // checking dirs and masks to be scanned
        let mut dirs2scan: Vec<String> = Vec::new();
        let mut file_masks: Vec<String> = Vec::new();
        for item in &args.dir_or_filemask {
            let dir = std::path::Path::new(item);
            if dir.is_dir() {
                dirs2scan.push(dir.to_str().unwrap().to_string())
            } else {
                file_masks.push(item.clone());
            }
        }
        // set default dir if empty
        if dirs2scan.is_empty() {
            dirs2scan.push(String::from("."))
        }
        // set default mask if empty
        if file_masks.is_empty() {
            file_masks.push(String::from("*.*"))
        };

        log::debug!("DIRs to be scanned: {:?}", &dirs2scan);
        log::debug!("FILEMASKs to be used: {:?}", &file_masks);
        log::debug!("Recursive scan: {:?}", &args.recursive);

        App {
            dirs2scan,
            file_masks,
            recursive : args.recursive,
        }
    }

    pub fn run(&self) {
        log::info!("Start run");

        let glob_options = glob::MatchOptions {
            case_sensitive: false,
            require_literal_separator: false,
            require_literal_leading_dot: false,
        };
        for dir in &self.dirs2scan {
            for mask in &self.file_masks {
                let mut pattern = String::new();
                pattern.push_str(dir);
                pattern.push('/');
                if self.recursive {
                    pattern.push_str("**/");
                }
                pattern.push_str(mask);
                log::debug!("Using glob pattern: {:?}", &pattern);
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
        log::info!("Finish run");
    }
}

// output file to stdout
fn output_file(path: &std::path::Path) {
    log::info!("Processing file: {}", path.to_str().unwrap());

    // checking if file is hidden in unix (starts with . )
    match path.file_name() {
        None => {
            log::info!("NO file name, return");
            return
        },
        Some(file_name) => match file_name.to_str() {
            None => {
                log::info!("NO str file name, return");
                return
            },
            Some(name) => {
                if name.starts_with('.') {
                    log::info!("Hidden file, return");
                    return
                }
            }
        },
    }
    // checking file extension - should be exist and supported
    match path.extension() {
        None => {
            log::info!("NO file extension, return");
            ()
        },
        Some(ext) => {
            let ext = ext.to_ascii_lowercase();
            match ftools::SUPPORTED_FILE_TYPE
                .iter()
                .position(|&supported_ext| supported_ext == ext)
            {
                None => {
                    log::info!("Unsupported file type, return");
                    ()
                },
                Some(_) => println!("{}", path.display()),
            }
        }
    }
}
