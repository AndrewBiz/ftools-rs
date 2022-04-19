use std::ops::RangeInclusive;
use crate::CliArgs;
use regex::Regex;

// app class
pub struct App {
    dirs2scan: Vec<String>,
    file_masks: Vec<String>,
    recursive: bool,
    range: RangeInclusive<i32>,
    range_str_len: usize,
}

impl App {
    pub fn init(args: CliArgs) -> App {
        // checking dirs and masks to be scanned
        let mut dirs2scan: Vec<String> = Vec::new();
        let mut file_masks: Vec<String> = Vec::new();
        for item in &args.dir_or_filemask {
            let dir = std::path::Path::new(item);
            if dir.is_dir() {
                dirs2scan.push(dir.to_str().unwrap().to_string());
            } else {
                file_masks.push(item.clone());
            }
        }
        // set default dir if empty
        if dirs2scan.is_empty() {
            dirs2scan.push(String::from("."));
        }
        // set default mask if empty
        if file_masks.is_empty() {
            file_masks.push(String::from("*.*"));
        }

        // range prep
        let mut range = 0..=0;
        let mut range_str_len = 0;
        if let Some(range_arg) = &args.range {
            let re = Regex::new(r"^(?P<range_start>[0-9]+)\.\.(?P<range_end>[0-9]+)$").unwrap();
            if let Some(caps) = re.captures(range_arg) {
                let r1 = caps
                    .name("range_start")
                    .unwrap()
                    .as_str()
                    .parse::<i32>()
                    .unwrap();
                let r2 = caps
                    .name("range_end")
                    .unwrap()
                    .as_str()
                    .parse::<i32>()
                    .unwrap();
                range = r1..=r2;
                range_str_len = r2.to_string().len();
            } else {
                log::debug!("NO regex found for --range={}", &range_arg);
            }
        }

        log::debug!("DIRs to be scanned: {:?}", &dirs2scan);
        log::debug!("FILEMASKs to be used: {:?}", &file_masks);
        log::debug!("Recursive scan: {:?}", &args.recursive);
        log::debug!("Range: {:?}", &range);
        log::debug!("Range_str_len: {}", range_str_len);

        App {
            dirs2scan,
            file_masks,
            recursive: args.recursive,
            range,
            range_str_len
        }
    }

    pub fn run(&self) {
        log::debug!("Start run");

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
                            self.output_file(&path);
                        }
                        Err(e) => eprintln!("ERROR {:?}", e),
                    }
                }
            }
        }
        log::debug!("Finish run");
    }

    // output file to stdout
    fn output_file(&self, path: &std::path::Path) {
        log::debug!("Processing file: {}", path.to_str().unwrap());
        // checking if the pth is dir
        if path.is_dir() {
            log::debug!("this is dir, not file, skip");
            return;
        }
        // checking if file is hidden in unix (starts with . )
        match path.file_name() {
            None => {
                log::debug!("NO file name, skip");
                return;
            }
            Some(file_name) => match file_name.to_str() {
                None => {
                    log::debug!("NO str file name, skip");
                    return;
                }
                Some(name) => {
                    // checking if the file is hidden
                    if name.starts_with('.') {
                        log::debug!("Hidden file, skip");
                        return;
                    }
                }
            }
        }
        // checking file name (without extention) if file_name corresponds to the given range
        if let Some(file_stem) = path.file_stem() {
            if let Some(name) = file_stem.to_str() {
                if self.range_str_len >0 {
                    let name_str_len = name.len();
                    let name_ending = &name[name_str_len - self.range_str_len .. name_str_len];
                    if let Ok(name_ending_int) = &name_ending.parse::<i32>() {
                        if self.range.contains(name_ending_int) {
                            log::debug!("File name ending '{}' is inside the range {:?}", &name_ending, &self.range);
                        } else {
                            log::debug!("File name ending '{}' is OUT of the range {:?}, skip", &name_ending, &self.range);
                            return;
                        }
                    } else {
                        log::debug!("File name ending '{}' is not a number, skip", &name_ending);
                        return;
                    }
                }
            } else {
                log::debug!("NO str file stem, skip");
                return;
            }
        } else {
            log::debug!("NO file stem, skip");
            return;
        }

        // checking file extension - should be exist and supported
        match path.extension() {
            None => {
                log::debug!("NO file extension, skip");
            }
            Some(ext) => {
                let ext = ext.to_ascii_lowercase();
                match ftools::SUPPORTED_FILE_TYPE
                    .iter()
                    .position(|&supported_ext| supported_ext == ext)
                {
                    None => {
                        log::debug!("Unsupported file type, skip");
                    }
                    Some(_) => println!("{}", path.display()),
                }
            }
        }
    }
}