use crate::media_file::*;
use crate::tag::TagDateTime;
use anyhow::Result;
use std::path::PathBuf;

#[derive(Debug)]
pub struct Jpg;

impl TagReader for Jpg {
    fn date_of_creation(&self, fs_path: &PathBuf) -> Result<TagDateTime> {
        // let dt_created = self.read_tags_via_quickexif(fs_path)?;
        // match self.read_tags_via_quickexif(fs_path) {
        //     Ok(dt_created) => return Ok(dt_created),
        //     Err(e) => return Err(MyError::SmthGoesWrong(format!("{}", e,))),
        // }
        self.read_tags_via_quickexif(fs_path)
    }
}
