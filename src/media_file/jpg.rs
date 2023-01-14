use crate::error::MyError;
use crate::media_file::*;
use crate::tag::TagDateTime;
use std::path::PathBuf;

#[derive(Debug)]
pub struct Jpg;

impl TagReader for Jpg {
    fn date_of_creation(&self, fs_path: &PathBuf) -> Result<TagDateTime, MyError> {
        match self.read_tags_via_quickexif(fs_path) {
            Ok(dt_created) => return Ok(dt_created),
            Err(e) => return Err(MyError::SmthGoesWrong(format!("{}", e,))),
        }
    }
}
