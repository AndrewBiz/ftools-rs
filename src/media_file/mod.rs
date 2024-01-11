use crate::tag::{TagDateTime, TagReader};
use anyhow::{anyhow, Result};
use regex::Regex;
use std::default::Default;
use std::path::PathBuf;

pub mod jpg;
pub mod unsupported;

#[derive(Debug)]
pub struct MediaFile {
    pub fs_path_in: PathBuf,        // input full path and name of the file
    pub fs_path_standard: PathBuf,  // standardtized path and name of the file
    pub fs_path_original: PathBuf,  // original path and name of the file
    file_name_in: String,           // initial full name of the file
    file_name_standard: String,     // standardtized name of the file
    file_name_original: String,     // original name of the file
    pub fn_already_standard: bool,  // true if the input name was already standard
    media_type: Box<dyn TagReader>, // type of the file
    pub dt_created: TagDateTime,    // date-time of creation of the file
}

impl MediaFile {
    fn new(fs_path_in: PathBuf, media_type: Box<dyn TagReader>, author: String) -> Result<Self> {
        let file_name_in = format!(
            "{}",
            fs_path_in
                .as_path()
                .file_name()
                .unwrap_or_default()
                .to_str()
                .unwrap_or_default()
        );

        let fs_path_standard;
        let fs_path_original;
        let file_name_standard;
        let file_name_original;
        let fn_already_standard;
        let dt_created;

        // Check if tne name already standard
        let re =
            Regex::new(r"^(?<date_time>\d{8}-\d{6})_(?<author>[A-Za-z]{3,6}) (?<name_orig>.*)$")
                .unwrap();

        if let Some(caps) = re.captures(&file_name_in) {
            // already standard name given
            log::debug!("filename regex <date_time> : {}", &caps["date_time"]);
            log::debug!("filename regex <author>    : {}", &caps["author"]);
            log::debug!("filename regex <name_orig> : {}", &caps["name_orig"]);
            fn_already_standard = true;
            dt_created = media_type
                .read_date_time_from_str(&caps["date_time"])
                .unwrap_or_default();
            file_name_standard = file_name_in.clone();
            fs_path_standard = fs_path_in.clone();
            file_name_original = String::from(&caps["name_orig"]);
            fs_path_original = fs_path_in.with_file_name(&file_name_original);
        } else {
            // non standard name given
            fn_already_standard = false;
            dt_created = media_type.date_of_creation(&fs_path_in)?; // TODO: logic of different tags read dep on input parameters

            file_name_standard = format!(
                "{}_{} {}",
                dt_created.value.format("%Y%m%d-%H%M%S"),
                author,
                file_name_in
            );
            fs_path_standard = fs_path_in.with_file_name(&file_name_standard);
            file_name_original = file_name_in.clone();
            fs_path_original = fs_path_in.clone();
        };

        Ok(Self {
            fs_path_in,
            fs_path_standard,
            fs_path_original,
            file_name_in,
            file_name_standard,
            file_name_original,
            fn_already_standard,
            media_type,
            dt_created,
        })
    }
}

pub fn init(path: String, author: String) -> Result<MediaFile> {
    let fs_path: PathBuf = path.into();
    if !fs_path.is_file() {
        return Err(anyhow!("Not a file or file does not exist"));
    }
    let fs_ext = fs_path.extension().ok_or(anyhow!("No file extention"))?;
    let file_ext = fs_ext.to_str().unwrap_or("").to_lowercase();
    let file_ext = file_ext.as_str();
    let mf = match file_ext {
        "jpg" | "jpeg" => MediaFile::new(fs_path, Box::new(jpg::Jpg), author),
        // "heic" => MediaFile::new(fs_path, Box::new(heic::Heic)),
        // "arw" => MediaFile::new(fs_path, Box::new(arw::Arw)),
        // "mov" => MediaFile::new(fs_path, Box::new(mov::Mov)),
        // "png" => media_file::process(&fs_path, Png),
        _ => MediaFile::new(fs_path, Box::new(unsupported::Unsupported), author),
    }?;
    Ok(mf)
}
