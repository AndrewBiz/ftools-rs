use crate::tag::{TagDateTime, TagReader};
use anyhow::{anyhow, Result};
use std::path::PathBuf;

pub mod jpg;
pub mod unsupported;

#[derive(Debug)]
pub struct MediaFile {
    pub fs_path: PathBuf,
    pub file_name: String,
    pub media_type: Box<dyn TagReader>,
    pub dt_created: TagDateTime,
    pub author: String,
}

impl MediaFile {
    fn new(fs_path: PathBuf, media_type: Box<dyn TagReader>, author: String) -> Result<Self> {
        let dt_created = media_type.date_of_creation(&fs_path)?;
        Ok(Self {
            file_name: format!(
                "{}",
                fs_path
                    .as_path()
                    .file_name()
                    .unwrap_or_default()
                    .to_str()
                    .unwrap_or_default()
            ),
            fs_path,
            media_type,
            dt_created,
            author,
        })
    }
    pub fn get_standard_file_name(&self) -> String {
        format!(
            "{}_{} {}",
            self.dt_created.value.format("%Y%m%d-%H%M%S"),
            self.author,
            self.file_name
        )
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
