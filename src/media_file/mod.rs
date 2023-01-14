use crate::tag::{TagDateTime, TagReader};
use std::path::PathBuf;

pub mod jpg;
pub mod unsupported;

#[derive(Debug)]
pub struct MediaFile {
    pub fs_path: PathBuf,
    pub media_type: Box<dyn TagReader>,
    pub dt_created: TagDateTime,
}

impl MediaFile {
    fn new(fs_path: PathBuf, media_type: Box<dyn TagReader>) -> Self {
        match media_type.date_of_creation(&fs_path) {
            Ok(dt_created) => Self {
                fs_path,
                media_type,
                dt_created,
            },
            Err(e) => {
                eprintln!("MediaFile::new() - {}", e);
                Self {
                    fs_path,
                    media_type,
                    dt_created: TagDateTime::default(),
                }
            }
        }
    }
}

pub fn initialize(fs_path: PathBuf) -> MediaFile {
    if let Some(fs_ext) = fs_path.extension() {
        let file_ext = fs_ext.to_str().unwrap_or("").to_lowercase();
        let file_ext = file_ext.as_str();
        match file_ext {
            "jpg" | "jpeg" => MediaFile::new(fs_path, Box::new(jpg::Jpg)),
            "heic" => MediaFile::new(fs_path, Box::new(heic::Heic)),
            "arw" => MediaFile::new(fs_path, Box::new(arw::Arw)),
            "mov" => MediaFile::new(fs_path, Box::new(mov::Mov)),
            // "png" => media_file::process(&fs_path, Png),
            _ => MediaFile::new(fs_path, Box::new(unsupported::Unsupported)),
        }
    } else {
        MediaFile::new(fs_path, Box::new(unsupported::Unsupported))
    }
}
