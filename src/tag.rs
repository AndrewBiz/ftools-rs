use anyhow::{anyhow, Result};
use chrono::{DateTime, Local, NaiveDateTime};
use serde_json::Value;
use std::fmt;
use std::{path::PathBuf, process::Command};

#[derive(Debug, Default)]
pub struct TagDateTime {
    name: String,
    reader: String,
    value_raw: String,
    pub value: NaiveDateTime,
}
pub trait TagReader: fmt::Debug {
    // TODO: common function for all types which will use input params and call specific functions of types

    fn date_of_creation(&self, fs_path: &PathBuf) -> Result<TagDateTime>;

    /// exiftool
    fn read_tags_via_exiftool(
        &self,
        fs_path: &PathBuf,
        tags_to_read: &[String],
    ) -> Result<TagDateTime> {
        log::debug!(
            "Reading tags with exiftool engine in {}",
            fs_path.to_str().unwrap_or_default()
        );

        // constructing external command execution
        let mut command = Command::new("exiftool");
        command.arg("-json");
        for tag in tags_to_read.iter() {
            command.arg(format!("-{tag}"));
        }
        command.arg(fs_path);

        // Executing command
        let output = match command.output() {
            Ok(output) => output,
            Err(e) => return Err(anyhow!("exiftool ERROR: {}", e)),
        };
        let json_raw = String::from_utf8(output.stdout).unwrap_or_default();
        log::debug!("JSON output = {json_raw}");

        let json: Value = serde_json::from_str(&json_raw).unwrap_or_default();

        for tag in tags_to_read.iter() {
            log::debug!("Looking for tag {tag}");
            let tag_value = json[0][tag].as_str().unwrap_or_default();
            if tag_value == "" {
                continue;
            };
            log::debug!("Tag {tag} value = {tag_value}");

            match NaiveDateTime::parse_from_str(&tag_value[..19], "%Y:%m:%d %H:%M:%S") {
                Ok(value) => {
                    return Ok(TagDateTime {
                        name: String::from(tag),
                        reader: String::from("exiftool"),
                        value_raw: String::from(tag_value),
                        value,
                    })
                }
                Err(e) => {
                    log::debug!("Tag {tag} parse error: {e}");
                    continue;
                }
            }
        }
        return Err(anyhow!("exiftool ERROR - no tags found"));
    }

    /// quickexif
    fn read_tags_via_quickexif(&self, fs_path: &PathBuf) -> Result<TagDateTime> {
        let rule = quickexif::describe_rule!(
            tiff {
                0x8769 {
                    0x9003 { str + 0 / dto }
                }
            }
        );
        log::debug!(
            "Reading tags with quickexif engine in {}",
            fs_path.to_str().unwrap_or_default()
        );
        let sample = std::fs::read(fs_path)?;
        // TODO validate against zero sample and do not panic
        let sample = match sample[..4] {
            // jpeg jfif
            [0xff, 0xd8, 0xff, 0xe0] => &sample[30..],
            // jpeg simple
            [0xff, 0xd8, 0xff, 0xe1] => &sample[12..],
            // heic apple
            [0x00, 0x00, 0x00, 0x24] => &sample[10718..],
            // png
            [0x89, 0x50, 0x4e, 0x47] => &sample[406..],
            //all others
            _ => &sample,
        };
        match quickexif::parse(&sample, &rule) {
            Ok(parsed_info) => {
                let value_raw = parsed_info.str("dto").unwrap_or_default(); //"2022:04:25 18:15:00"
                let value = NaiveDateTime::parse_from_str(&value_raw[..19], "%Y:%m:%d %H:%M:%S")
                    .unwrap_or_default();
                return Ok(TagDateTime {
                    name: String::from("DateTimeOriginal"),
                    reader: String::from("quickexif"),
                    value_raw: String::from(value_raw),
                    value,
                });
            }
            Err(e) => return Err(anyhow!("qiuickexif ERROR: {}", e)),
        }
    }

    /// reading date_time_modified metadata from file system
    fn read_fmd(&self, fs_path: &PathBuf) -> Result<TagDateTime> {
        let fs_metadata = fs_path.metadata()?;
        let fmd_sys = fs_metadata.modified()?;
        let fmd_dtl: DateTime<Local> = DateTime::from(fmd_sys);

        Ok(TagDateTime {
            name: String::from("FileModifiedDate"),
            reader: String::from("ftools"),
            value_raw: format!("{:?}", fmd_sys),
            value: fmd_dtl.naive_local(),
        })
    }
    /// reading date_time from string in standard form
    fn read_date_time_from_str(&self, dt_str: &str) -> Result<TagDateTime> {
        let value = NaiveDateTime::parse_from_str(&dt_str, "%Y%m%d-%H%M%S").unwrap_or_default();

        Ok(TagDateTime {
            name: String::from("date-time-in-the-name"),
            reader: String::from("ftools"),
            value_raw: format!("{}", dt_str),
            value,
        })
    }
}
