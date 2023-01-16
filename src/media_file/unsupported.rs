use crate::media_file::*;
use crate::tag::TagDateTime;
use anyhow::Result;
use std::path::PathBuf;

#[derive(Debug)]
pub struct Unsupported;

impl TagReader for Unsupported {
    fn date_of_creation(&self, fs_path: &PathBuf) -> Result<TagDateTime> {
        let tags_to_read = [String::from("DateTimeOriginal"), String::from("CreateDate")];
        // match self.read_tags_via_exiftool(fs_path, &tags_to_read) {
        //     Ok(dt_created) => return Ok(dt_created),
        //     Err(e) => return Err(MyError::SmthGoesWrong(format!("{}", e))),
        // }
        self.read_tags_via_exiftool(fs_path, &tags_to_read)
    }
}
