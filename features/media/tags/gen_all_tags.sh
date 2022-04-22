#!/usr/bin/env bash
echo "Generating sample files with phtools-related tags"
# ********** CITY ************
# cfile="tag_city0.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-MWG:City=MWG-Петербург" "$cfile"
#
# cfile="tag_city1.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-IPTC:City=IPTC-Петербург" "-XMP:City=XMP-Москва" "-XMP:LocationShownCity=XMP-ShownCity" "$cfile"
#
# cfile="tag_city2.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-IPTC:City=" "-XMP:City=XMP-Москва" "-XMP:LocationShownCity=XMP-ShownCity" "$cfile"
#
# cfile="tag_city3.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-IPTC:City=" "-XMP:City=" "-XMP:LocationShownCity=XMP-ShownCity" "$cfile"

# ********** Collections ************
# XMP-mwg-coll:Collections (struct+)
#   CollectionName
#   CollectionURI
# cfile="tag_collections0.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-XMP-mwg-coll:Collections+={CollectionName=mwg_collname1, CollectionURI=mwg_colluri1}" "-XMP-mwg-coll:Collections+={CollectionName=mwg_collname2, CollectionURI=mwg_colluri2}" "$cfile"
#
# ********** CREATOR ************
# EXIF:Artist, IPTC:By-line, XMP-dc:Creator
# cfile="tag_creator0.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-MWG:Creator-=mwg1" "-MWG:Creator+=mwg1" "-MWG:Creator-=mwg2" "-MWG:Creator+=mwg2" "$cfile"
#
# cfile="tag_creator1.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-EXIF:Artist=exif_artist1; exif_artist2; exif_artist3" "-IPTC:By-line+=iptc_by-line1" "-IPTC:By-line+=iptc_by-line2" "-IPTC:By-line+=iptc_by-line3" "-XMP:Creator+=xmp-creator1" "-XMP:Creator+=xmp-creator2" "-XMP:Creator+=xmp-creator3" "$cfile"
#
# cfile="tag_creator2.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-EXIF:Artist=" "-IPTC:By-line+=iptc_by-line1" "-IPTC:By-line+=iptc_by-line2" "-IPTC:By-line+=iptc_by-line3" "-XMP:Creator+=xmp-creator1" "-XMP:Creator+=xmp-creator2" "-XMP:Creator+=xmp-creator3" "$cfile"
#
# cfile="tag_creator3.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-EXIF:Artist=" "-IPTC:By-line=" "-XMP:Creator+=xmp-creator1" "-XMP:Creator+=xmp-creator2" "-XMP:Creator+=xmp-creator3" "$cfile"

# ********** COPYRIGHT ************
# EXIF:Artist, IPTC:By-line, XMP-dc:Creator
# cfile="tag_copyright0.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-MWG:Copyright=mwg_AndrewBiz" "$cfile"
#
# cfile="tag_copyright1.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-EXIF:Copyright=exif_copyright" "-IPTC:CopyrightNotice=iptc_copyrightnotice" "-XMP:Rights=xmp-rights" "$cfile"
#
# cfile="tag_copyright2.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-EXIF:Copyright=" "-IPTC:CopyrightNotice=iptc_copyrightnotice" "-XMP:Rights=xmp-rights" "$cfile"
#
# cfile="tag_copyright3.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-EXIF:Copyright=" "-IPTC:CopyrightNotice=" "-XMP:Rights=xmp-rights" "$cfile"

# ********** COUNTRY ************
# IPTC:Country-PrimaryLocationName, XMP-photoshop:Country, XMP-iptcExt:LocationShownCountryName
# cfile="tag_country0.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-MWG:Country=mwg_country" "$cfile"
#
# cfile="tag_country1.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-IPTC:Country-PrimaryLocationName=iptc_country-primarylocationname" "-XMP:Country=xmp_country" "-XMP:LocationShownCountryName=xmp_locationshowncountryname" "$cfile"
#
# cfile="tag_country2.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-IPTC:Country-PrimaryLocationName=" "-XMP:Country=xmp_country" "-XMP:LocationShownCountryName=xmp_locationshowncountryname" "$cfile"
#
# cfile="tag_country3.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-IPTC:Country-PrimaryLocationName=" "-XMP:Country=" "-XMP:LocationShownCountryName=xmp_locationshowncountryname" "$cfile"

# ********** Keywords ************
# IPTC:Keywords, XMP:Subject
# cfile="tag_keywords0.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-MWG:Keywords+=mwg_keyword1" "-MWG:Keywords+=mwg_keyword2" "$cfile"
#
# cfile="tag_keywords1.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-IPTC:Keywords+=iptc_kw1" "-IPTC:Keywords+=iptc_kw2" "-XMP:Subject+=xmp_subj1" "-XMP:Subject+=xmp_subj2" "$cfile"
#
# cfile="tag_keywords2.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-IPTC:Keywords=" "-XMP:Subject+=xmp_subj1" "-XMP:Subject+=xmp_subj2" "$cfile"

# ********** LOCATION ************
# IPTC:Sub-location, XMP:Location, XMP:LocationShownSublocation
# cfile="tag_location0.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-MWG:Location=mwg_location" "$cfile"
#
# cfile="tag_location1.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-IPTC:Sub-location=iptc_sublocation" "-XMP:Location=xmp_location" "-XMP:LocationShownSublocation=xmp_locationshownsublocation" "$cfile"
#
# cfile="tag_location2.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-IPTC:Sub-location=" "-XMP:Location=xmp_location" "-XMP:LocationShownSublocation=xmp_locationshownsublocation" "$cfile"
#
# cfile="tag_location3.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-IPTC:Sub-location=" "-XMP:Location=" "-XMP:LocationShownSublocation=xmp_locationshownsublocation" "$cfile"

# ********** STATE ************
# IPTC:Province-State, XMP-photoshop:State, XMP-iptcExt:LocationShownProvinceState
# cfile="tag_state0.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-MWG:State=mwg_state" "$cfile"
#
# cfile="tag_state1.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-IPTC:Province-State=iptc_provincestate" "-XMP:State=xmp_state" "-XMP:LocationShownProvinceState=xmp_locationshownprovincestate" "$cfile"
#
# cfile="tag_state2.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-IPTC:Province-State=" "-XMP:State=xmp_state" "-XMP:LocationShownProvinceState=xmp_locationshownprovincestate" "$cfile"
#
# cfile="tag_state3.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-IPTC:Province-State=" "-XMP:State=" "-XMP:LocationShownProvinceState=xmp_locationshownprovincestate" "$cfile"

# ********** DateTimeOriginal ************
# -MWG:DateTimeOriginal: EXIF:DateTimeOriginal, IPTC:DateCreated+IPTC:TimeCreated, XMP-photoshop:DateCreated
# cfile="tag_dto0.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-MWG:DateTimeOriginal=2000:01:01 00:00:00" "$cfile"
#
# cfile="tag_dto1.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-EXIF:DateTimeOriginal=2001:01:01 01:01:01" "-IPTC:DateCreated=2002:02:02" "-IPTC:TimeCreated=02:02:02+02:00"  "-XMP:DateCreated=2003:03:03 03:03:03" "$cfile"
#
# cfile="tag_dto2.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-EXIF:DateTimeOriginal=" "-IPTC:DateCreated=2002:02:02" "-IPTC:TimeCreated=02:02:02+02:00"  "-XMP:DateCreated=2003:03:03 03:03:03" "$cfile"
#
# cfile="tag_dto3.JPG"
# echo "Preparing file $cfile ..."
# cp "_template.JPG" "$cfile"
# exiftool -P -overwrite_original "-EXIF:DateTimeOriginal=" "-IPTC:DateCreated=" "-IPTC:TimeCreated="  "-XMP:DateCreated=2003:03:03 03:03:03" "$cfile"

# ********** CreateDate ************
# -MWG:CreateDate: EXIF:CreateDate (EXIF:SubSecTimeDigitized), IPTC:DigitalCreationDate+IPTC:DigitalCreationTime, XMP-xmp:CreateDate
cfile="tag_cd0.JPG"
echo "Preparing file $cfile ..."
cp "_template.JPG" "$cfile"
exiftool -P -overwrite_original "-MWG:CreateDate=2010:10:10 10:10:10" "$cfile"

cfile="tag_cd1.JPG"
echo "Preparing file $cfile ..."
cp "_template.JPG" "$cfile"
exiftool -P -overwrite_original "-EXIF:CreateDate=2004:04:04 04:04:04" "-IPTC:DigitalCreationDate=2005:05:05" "-IPTC:DigitalCreationTime=05:05:05+05:00" "-XMP:CreateDate=2006:06:06 06:06:06"  "$cfile"

cfile="tag_cd2.JPG"
echo "Preparing file $cfile ..."
cp "_template.JPG" "$cfile"
exiftool -P -overwrite_original "-EXIF:CreateDate=" "-IPTC:DigitalCreationDate=2005:05:05" "-IPTC:DigitalCreationTime=05:05:05+05:00" "-XMP:CreateDate=2006:06:06 06:06:06"  "$cfile"

cfile="tag_cd3.JPG"
echo "Preparing file $cfile ..."
cp "_template.JPG" "$cfile"
exiftool -P -overwrite_original "-EXIF:CreateDate=" "-IPTC:DigitalCreationDate=" "-IPTC:DigitalCreationTime=" "-XMP:CreateDate=2006:06:06 06:06:06"  "$cfile"
