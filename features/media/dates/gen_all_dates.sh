#!/usr/bin/env bash
echo "Adding to $@ ftools-related date tags..."
exiftool -P -overwrite_original "-EXIF:DateTimeOriginal=2001:01:01 01:01:01" "-IPTC:DateCreated=2002:02:02" "-IPTC:TimeCreated=02:02:02+02:00"  "-XMP:DateCreated=2003:03:03 03:03:03" "-EXIF:CreateDate=2004:04:04 04:04:04" "-XMP:CreateDate=2005:05:05 05:05:05" "-IPTC:DigitalCreationDate=2006:06:06" "-IPTC:DigitalCreationTime=06:06:06+06:00" "-FileModifyDate=2007:07:07 07:07:07" "$@"

cfile="1exif_datetimeoriginal.JPG"
echo "Preparing file $cfile ..."
cp "$@" "$cfile"
exiftool -P -overwrite_original "-FileModifyDate=2007:07:07 07:07:07" "$cfile"

cfile="2iptc_datecreated.JPG"
echo "Preparing file $cfile ..."
cp "$@" "$cfile"
exiftool -P -overwrite_original "-FileModifyDate=2007:07:07 07:07:07" "-EXIF:DateTimeOriginal=" "$cfile"

cfile="3xmp_datecreated.JPG"
echo "Preparing file $cfile ..."
cp "$@" "$cfile"
exiftool -P -overwrite_original "-FileModifyDate=2007:07:07 07:07:07" "-EXIF:DateTimeOriginal=" "-IPTC:DateCreated=" "-IPTC:TimeCreated=" "$cfile"

cfile="4exif_createdate.JPG"
echo "Preparing file $cfile ..."
cp "$@" "$cfile"
exiftool -P -overwrite_original "-FileModifyDate=2007:07:07 07:07:07" "-EXIF:DateTimeOriginal=" "-IPTC:DateCreated=" "-IPTC:TimeCreated=" "-XMP:DateCreated=" "$cfile"

cfile="5xmp_createdate.JPG"
echo "Preparing file $cfile ..."
cp "$@" "$cfile"
exiftool -P -overwrite_original "-FileModifyDate=2007:07:07 07:07:07" "-EXIF:DateTimeOriginal=" "-IPTC:DateCreated=" "-IPTC:TimeCreated=" "-XMP:DateCreated=" "-EXIF:CreateDate=" "$cfile"

cfile="6iptc_digitalcreationdate.JPG"
echo "Preparing file $cfile ..."
cp "$@" "$cfile"
exiftool -P -overwrite_original "-FileModifyDate=2007:07:07 07:07:07" "-EXIF:DateTimeOriginal=" "-IPTC:DateCreated=" "-IPTC:TimeCreated=" "-XMP:DateCreated=" "-EXIF:CreateDate=" "-XMP:CreateDate=" "$cfile"

cfile="7filemodifydate.JPG"
echo "Preparing file $cfile ..."
cp "$@" "$cfile"
exiftool -P -overwrite_original "-FileModifyDate=2007:07:07 07:07:07" "-EXIF:DateTimeOriginal=" "-IPTC:DateCreated=" "-IPTC:TimeCreated=" "-XMP:DateCreated=" "-EXIF:CreateDate=" "-XMP:CreateDate=" "-IPTC:DigitalCreationDate=" "-IPTC:DigitalCreationTime=" "$cfile"
