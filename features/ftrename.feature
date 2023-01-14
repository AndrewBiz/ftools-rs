# language: en
Feature: Rename photo and video files
  In order to have all my photo and video files (taken with my digital camera, digitized by scanner)
  get well readable and informative filenames
  As a photographer
  I want to get the given files to be renamed to the standard phtools name template

  @ftrename
  Scenario: Output with -h produces usage information
    When I successfully run `ftrename -h`
    Then the stdout should contain each of:
      | *Keep Your Media Files In Order* (c) ANB |
      | Usage:                                   |
      | Options:                                 |
      | -h, --help                               |
      | --debug                                  |
      | -V, --version                            |

  @ftrename
  Scenario: Output with -V produces version information
    When I run `ftrename -V`
    Then the output should match /[0-9]+\.[0-9]+\.[0-9]+(-[a-z,0-9]+)?/

  # @ftrename
  # Scenario: TMP TMP Originally named files are renamed to phtools standard name
  #   Given a directory named "rename1"
  #   And example files from "features/media/sony_jpg" copied to "rename1" named:
  #  | DSC03403.JPG |
  #  | DSC03313.JPG |
  #  | DSC03499.JPG |
  #  | DSC03802.JPG |
  #  | DSC04032.JPG |

  #   When I cd to "rename1"
  #   When I run the following commands:
  #   """bash
  #   ftls | ftrename
  #   """
  #   Then the exit status should be 0

  #   Then the stdout should contain each of:
  #   | DSC03313.JPG |
  #   | DSC03403.JPG |
  #   | DSC03499.JPG |
  #   | DSC03802.JPG |
  #   | DSC04032.JPG |

  @ftrename
  Scenario: Originally named files are renamed to phtools standard name
    Given a directory named "rename1"
    And example files from "features/media/sony_jpg" copied to "rename1" named:
   | DSC03403.JPG |
   | DSC03313.JPG |
   | DSC03499.JPG |
   | DSC03802.JPG |
   | DSC04032.JPG |

    When I cd to "rename1"
    When I run the following commands:
    """bash
    ftls | ftrename -a anb
    """
    Then the exit status should be 0

    Then the stdout should contain each of:
    | 20130103-103254_ANB DSC03313.JPG |
    | 20130103-153908_ANB DSC03403.JPG |
    | 20130104-120745_ANB DSC03499.JPG |
    | 20130105-150446_ANB DSC03802.JPG |
    | 20130107-115201_ANB DSC04032.JPG |
    And the following files should exist:
    | ./20130103-103254_ANB DSC03313.JPG |
    | ./20130103-153908_ANB DSC03403.JPG |
    | ./20130104-120745_ANB DSC03499.JPG |
    | ./20130105-150446_ANB DSC03802.JPG |
    | ./20130107-115201_ANB DSC04032.JPG |
    And the following files should not exist:
    | ./DSC03313.JPG |
    | ./DSC03403.JPG |
    | ./DSC03499.JPG |
    | ./DSC03802.JPG |
    | ./DSC04032.JPG |

  # #@announce
  # Scenario: Originally named files are renamed to phtools standard name using as a timestamp the 1st non-zero value of one of the tags (in priority order): EXIF:DateTimeOriginal -> IPTC:DateCreated + IPTC:TimeCreated -> XMP:DateCreated -> EXIF:CreateDate -> XMP:CreateDate -> IPTC:DigitalCreationDate + IPTC:DigitalCreationTime -> FileModifyDate

  #   Given a directory named "rename2"
  #   And example files from "features/media/dates" copied to "rename2" named:
  #   | 1exif_datetimeoriginal.JPG    |
  #   | 2iptc_datecreated.JPG         |
  #   | 3xmp_datecreated.JPG          |
  #   | 4exif_createdate.JPG          |
  #   | 5xmp_createdate.JPG           |
  #   | 6iptc_digitalcreationdate.JPG |
  #   | 7filemodifydate.JPG           |
  #   And example file "rename2/7filemodifydate.JPG" with file-modify-date set to "2007-07-07 07:07:07"

  #   When I cd to "rename2"
  #   When I run the following commands:
  #   """bash
  #   phls | phrename -a anb
  #   """
  #   Then the exit status should be 0

  #   Then the stdout should contain each of:
  #   | 20010101-010101_ANB 1exif_datetimeoriginal.JPG    |
  #   | 20020202-020202_ANB 2iptc_datecreated.JPG         |
  #   | 20030303-030303_ANB 3xmp_datecreated.JPG          |
  #   | 20040404-040404_ANB 4exif_createdate.JPG          |
  #   | 20050505-050505_ANB 5xmp_createdate.JPG           |
  #   | 20060606-060606_ANB 6iptc_digitalcreationdate.JPG |
  #   | 20070707-070707_ANB 7filemodifydate.JPG           |

  #   And the following files should exist:
  #   | 20010101-010101_ANB 1exif_datetimeoriginal.JPG    |
  #   | 20020202-020202_ANB 2iptc_datecreated.JPG         |
  #   | 20030303-030303_ANB 3xmp_datecreated.JPG          |
  #   | 20040404-040404_ANB 4exif_createdate.JPG          |
  #   | 20050505-050505_ANB 5xmp_createdate.JPG           |
  #   | 20060606-060606_ANB 6iptc_digitalcreationdate.JPG |
  #   | 20070707-070707_ANB 7filemodifydate.JPG           |

  #   And the following files should not exist:
  #   | 1exif_datetimeoriginal.JPG    |
  #   | 2iptc_datecreated.JPG         |
  #   | 3xmp_datecreated.JPG          |
  #   | 4exif_createdate.JPG          |
  #   | 5xmp_createdate.JPG           |
  #   | 6iptc_digitalcreationdate.JPG |
  #   | 7filemodifydate.JPG           |

  # #@announce
  # Scenario: File is renamed using ModifyDate tag
  #   Given a directory named "rename2"
  #   And example files from "features/media/sony_jpg" copied to "rename2" named:
  #  | DSC03313.JPG |

  #   When I cd to "rename2"
  #   When I run the following commands:
  #   """bash
  #   phls | phrename -a anb -t ModifyDate
  #   """
  #   Then the exit status should be 0

  #   Then the stdout should contain each of:
  #   | 20131114-225114_ANB DSC03313.JPG |
  #   And the following files should exist:
  #   | ./20131114-225114_ANB DSC03313.JPG |
  #   And the following files should not exist:
  #   | ./DSC03313.JPG |
  #   And the following files should not exist:
  #   | ./20130103-103254_ANB DSC03313.JPG |

  # #@announce
  # Scenario: cmd reports error if tag does not exist
  #   Given a directory named "rename2"
  #   And example files from "features/media/sony_jpg" copied to "rename2" named:
  #  | DSC03313.JPG |

  #   When I cd to "rename2"
  #   When I run the following commands:
  #   """bash
  #   phls | phrename -a anb -t XXXDateTime
  #   """
  #   Then the exit status should be 0

  #   And the stderr should contain "tag XXXDateTime is not found"
  #   And the following files should exist:
  #   | ./DSC03313.JPG |
  #   And the following files should not exist:
  #   | ./20131114-225114_ANB DSC03313.JPG |
  #   And the following files should not exist:
  #   | ./20130103-103254_ANB DSC03313.JPG |

  # #@announce
  # Scenario: cmd reports error if tag is not DateTime type
  #   Given a directory named "rename2"
  #   And example files from "features/media/sony_jpg" copied to "rename2" named:
  #  | DSC03313.JPG |

  #   When I cd to "rename2"
  #   When I run the following commands:
  #   """bash
  #   phls | phrename -a anb -t Make
  #   """
  #   Then the exit status should be 0

  #   And the stderr should contain "tag Make is not a DateTime type"
  #   And the following files should exist:
  #   | ./DSC03313.JPG |
  #   And the following files should not exist:
  #   | ./20131114-225114_ANB DSC03313.JPG |
  #   And the following files should not exist:
  #   | ./20130103-103254_ANB DSC03313.JPG |

  # #@announce
  # Scenario: Standard named files can be renamed back to original names
  #   Given empty files named:
  #   | 20130101-005311_ANB DSC00001.JPG    |
  #   | 20130102-005311_ANBA DSC00002.JPG   |
  #   | 20130103-005311_ANBAN DSC00003.JPG  |
  #   | 20130104-005311_ANBANB DSC00004.JPG |
  #   When I run the following commands:
  #   """bash
  #   phls | phrename --clean
  #   """
  #   Then the exit status should be 0
  #   And the stdout should contain each of:
  #   | DSC00001.JPG |
  #   | DSC00002.JPG |
  #   | DSC00003.JPG |
  #   | DSC00004.JPG |
  #   And the stdout should not contain any of:
  #   | 20130101-005311 |
  #   | ANB             |
  #   | ANBA            |
  #   | ANBAN           |
  #   | ANBANB          |
  #   And the following files should exist:
  #   | DSC00001.JPG |
  #   | DSC00002.JPG |
  #   | DSC00003.JPG |
  #   | DSC00004.JPG |

  # #@announce
  # Scenario: Files are with HEADER renamed back to original names
  #   Given empty files named:
  #   | 20130101-005311_ANB FLM101-01.JPG    |
  #   | 20130102-005311_ANB FLM101-02.JPG   |
  #   | FLM101-03.JPG  |
  #   | 20130104-005311_ANB XX-FLM101-04.JPG |
  #   | FLM102-05.JPG  |
  #   When I run the following commands:
  #   """bash
  #   phls | phrename --clean --header 'FLM101-'
  #   """
  #   Then the exit status should be 0
  #   And the stdout should contain each of:
  #   | 01.JPG |
  #   | 02.JPG |
  #   | 03.JPG |
  #   | XX-FLM101-04.JPG |
  #   | FLM102-05.JPG |
  #   And the following files should exist:
  #   | 01.JPG |
  #   | 02.JPG |
  #   | 03.JPG |
  #   | XX-FLM101-04.JPG |
  #   | FLM102-05.JPG |

  # #@announce
  # Scenario: Non-Standard named files are renamed back to original names as well
  #   Given empty files named:
  #   | 20130101-105311_ANB[12345678-dfdfdfdf]{flags}DSC10001.JPG |
  #   | 20130102-105311_ANB[12345678-erererer]DSC10002.JPG        |
  #   | 20130103-105311_ANB_DSC10003.JPG                          |
  #   | 20130104-105311_ANB-DSC10004.JPG                          |
  #   | 20130105-1053_ANB_DSC10005.JPG                            |
  #   | 20130106-1053-ANB_DSC10006.JPG                            |
  #   | 20130107-1053_ANB DSC10007.JPG                            |
  #   | 20130108-1053_DSC10008.JPG                                |
  #   | 20130109-1053 DSC10009.JPG                                |
  #   | 20130110_DSC10010.JPG                                     |
  #   | 20130111 DSC10011.JPG                                     |
  #   | 2013_DSC10012.JPG                                         |
  #   | 2013-DSC10013.JPG                                         |
  #   | 2013 DSC10014.JPG                                         |
  #   | CLEAN NAME.JPG                                            |
  #   | CLEAN_NAME.JPG                                            |
  #   | CLEAN-NAME.JPG                                            |
  #   | CLEANNAME.JPG                                             |
  #   When I run the following commands:
  #   """bash
  #   phls | phrename --clean
  #   """
  #   Then the exit status should be 0
  #   And the stdout should contain each of:
  #   | DSC10001.JPG   |
  #   | DSC10002.JPG   |
  #   | DSC10003.JPG   |
  #   | DSC10004.JPG   |
  #   | DSC10005.JPG   |
  #   | DSC10006.JPG   |
  #   | DSC10007.JPG   |
  #   | DSC10008.JPG   |
  #   | DSC10009.JPG   |
  #   | DSC10010.JPG   |
  #   | DSC10011.JPG   |
  #   | DSC10012.JPG   |
  #   | DSC10013.JPG   |
  #   | DSC10014.JPG   |
  #   | CLEAN NAME.JPG |
  #   | CLEAN_NAME.JPG |
  #   | CLEAN-NAME.JPG |
  #   | CLEANNAME.JPG  |
  #   And the stdout should not contain any of:
  #   | 20130101-105311_ANB[12345678-dfdfdfdf]{flags} |
  #   | 20130102-105311_ANB[12345678-erererer]        |
  #   | 20130103-105311_ANB_                          |
  #   | 20130104-105311_ANB-                          |
  #   | 20130105-1053_ANB_                            |
  #   | 20130106-1053-ANB_                            |
  #   | 20130107-1053_ANB                             |
  #   | 20130108-1053_                                |
  #   | 20130109-1053                                 |
  #   | 20130110_                                     |
  #   | 20130111                                      |
  #   | 2013_                                         |
  #   | 2013-                                         |
  #   | 2013                                          |
  #   And the following files should exist:
  #   | DSC10001.JPG   |
  #   | DSC10002.JPG   |
  #   | DSC10003.JPG   |
  #   | DSC10004.JPG   |
  #   | DSC10005.JPG   |
  #   | DSC10006.JPG   |
  #   | DSC10007.JPG   |
  #   | DSC10008.JPG   |
  #   | DSC10009.JPG   |
  #   | DSC10010.JPG   |
  #   | DSC10011.JPG   |
  #   | DSC10012.JPG   |
  #   | DSC10013.JPG   |
  #   | DSC10014.JPG   |
  #   | CLEAN NAME.JPG |
  #   | CLEAN_NAME.JPG |
  #   | CLEAN-NAME.JPG |
  #   | CLEANNAME.JPG  |

  # #@announce
  # Scenario: In SHIFT-TIME mode the jpg file is renamed with new date-time
  #   Given a directory named "changetime"
  #   And example file "features/media/renamed/20130103-103254_ANB DSC03313_notagset.JPG" copied to file "changetime/20130103-103254_ANB DSC03313.JPG"

  #   When I cd to "changetime"
  #   When I run the following commands:
  #   """bash
  #   phls | phrename --shift_time 100
  #   """
  #   Then the exit status should be 0
  #   And the stdout should contain each of:
  #     | 20130103-103434_ANB DSC03313.JPG |
  #   And the following files should exist:
  #     | 20130103-103434_ANB DSC03313.JPG |

  # #@announce
  # Scenario: In SHIFT-TIME mode the jpg file produces error if the name is not standard
  #   Given a directory named "changetime"
  #   And example file "features/media/renamed/20130103-103254_ANB DSC03313_notagset.JPG" copied to file "changetime/DSC03313.JPG"

  #   When I cd to "changetime"
  #   When I run the following commands:
  #   """bash
  #   phls | phrename --shift_time 100
  #   """
  #   Then the exit status should be 0
  #   And the stderr should contain "ERROR: './DSC03313.JPG' - file renaming - non-standard file name"

  # #@announce
  # Scenario: Re-runing phrename on the files previously renamed to Standard phtools Name will not change the Date-Time information kept in the file name

  #   Given a directory named "rename3"
  #   And example files from "features/media/dates_renamed" copied to "rename3" named:
  #   | 20010101-010101_XXX file1.JPG |
  #   | 20021212-020202_ANB file2.JPG |
  #   | 20030303-132333_YYY file3.JPG |

  #   When I cd to "rename3"
  #   When I run the following commands:
  #   """bash
  #   phls | phrename -a anb
  #   """
  #   Then the exit status should be 0

  #   Then the stdout should contain each of:
  #   | 20010101-010101_ANB file1.JPG |
  #   | 20021212-020202_ANB file2.JPG |
  #   | 20030303-132333_ANB file3.JPG |

  #   And the following files should exist:
  #   | 20010101-010101_ANB file1.JPG |
  #   | 20021212-020202_ANB file2.JPG |
  #   | 20030303-132333_ANB file3.JPG |

  #   And the following files should not exist:
  #   | 20010101-010101_ANB file1.JPG |
  #   | 20020202-020202_ANB file2.JPG |
  #   | 20030303-030303_ANB file3.JPG |

  # #@announce
  # Scenario: Re-runing phrename on the files previously renamed to Standard phtools Name with -t option will change the Date-Time information kept in the file name

  #   Given a directory named "rename4"
  #   And example files from "features/media/dates_renamed" copied to "rename4" named:
  #   | 20010101-010101_XXX file1.JPG |
  #   | 20021212-020202_ANB file2.JPG |
  #   | 20030303-132333_YYY file3.JPG |

  #   When I cd to "rename4"
  #   When I run the following commands:
  #   """bash
  #   phls | phrename -a anb --tag_date CreateDate
  #   """
  #   Then the exit status should be 0

  #   Then the stdout should contain each of:
  #   | 20040404-040404_ANB file1.JPG |
  #   | 20040404-040404_ANB file2.JPG |
  #   | 20040404-040404_ANB file3.JPG |

  #   And the following files should exist:
  #   | 20040404-040404_ANB file1.JPG |
  #   | 20040404-040404_ANB file2.JPG |
  #   | 20040404-040404_ANB file3.JPG |

  #   And the following files should not exist:
  #   | 20010101-010101_ANB file1.JPG |
  #   | 20021212-020202_ANB file2.JPG |
  #   | 20030303-132333_ANB file3.JPG |

  # #@announce
  # Scenario: In MANUAL-RENAME mode files are renamed to phtools standard name with values set by the user
  #   Given a directory named "manual"
  #   And example files from "features/media/sony_jpg" copied to "manual" named:
  #  | DSC03403.JPG |
  #  | DSC03313.JPG |
  #  | DSC03499.JPG |

  #   When I cd to "manual"
  #   When I run the following commands:
  #   """bash
  #   phls | phrename --manual_date '20171029-203100' -a anb
  #   """
  #   Then the exit status should be 0

  #   Then the stdout should contain each of:
  #   | 20171029-203100_ANB DSC03313.JPG |
  #   | 20171029-203100_ANB DSC03403.JPG |
  #   | 20171029-203100_ANB DSC03499.JPG |
  #   And the following files should exist:
  #   | 20171029-203100_ANB DSC03313.JPG |
  #   | 20171029-203100_ANB DSC03403.JPG |
  #   | 20171029-203100_ANB DSC03499.JPG |
  #   And the following files should not exist:
  #   | ./DSC03313.JPG |
  #   | ./DSC03403.JPG |
  #   | ./DSC03499.JPG |
  #   | 20130103-103254_ANB DSC03313.JPG |
  #   | 20130103-153908_ANB DSC03403.JPG |
  #   | 20130104-120745_ANB DSC03499.JPG |

  # #@announce
  # Scenario: In MANUAL-RENAME mode it fails if manual-date is incorrect
  #   Given a directory named "manual1"
  #   And example files from "features/media/sony_jpg" copied to "manual1" named:
  #   | DSC03403.JPG |

  #   When I cd to "manual1"
  #   When I run the following commands:
  #   """bash
  #   phls | phrename --manual_date '20171341-006700' -a anb
  #   """
  #   Then the exit status should not be 0
  #   And the stderr should contain "--manual_date value is incorrect"
  #   And the stdout should not contain any of:
  #   | DSC03403.JPG |
  #   And the following files should exist:
  #   | 00000101-000000_ANB DSC03313.JPG |

  # #@announce
  # Scenario: In MANUAL_RENAME mode running phrename on the files previously renamed to Standard phtools Name will not change the date-time-in-the-name

  #   Given a directory named "manual3"
  #   And example files from "features/media/dates_renamed" copied to "manual3" named:
  #   | 20010101-010101_XXX file1.JPG |
  #   | 20021212-020202_ANB file2.JPG |
  #   | 20030303-132333_YYY file3.JPG |

  #   When I cd to "manual3"
  #   When I run the following commands:
  #   """bash
  #   phls | phrename --manual_date '20171030-210119' -a nat
  #   """
  #   Then the exit status should be 0

  #   Then the stdout should contain each of:
  #   | 20010101-010101_XXX file1.JPG |
  #   | 20021212-020202_ANB file2.JPG |
  #   | 20030303-132333_YYY file3.JPG |

  #   And the following files should exist:
  #   | 20010101-010101_XXX file1.JPG |
  #   | 20021212-020202_ANB file2.JPG |
  #   | 20030303-132333_YYY file3.JPG |

  #   And the following files should not exist:
  #   | 20171030-210119_NAT file1.JPG |
  #   | 20171030-210119_NAT file2.JPG |
  #   | 20171030-210119_NAT file3.JPG |

  #   And the stderr should contain each of:
  #   | already standard name.|
  #   | Keeping date-time-in-name unchanged|

  # #@announce
  # Scenario: In MANUAL-RENAME mode with --shift-time parameter files are renamed to standard name, every next file has date-time-in-name = previus value + shift_time seconds
  #   Given a directory named "manual4"
  #   And example files from "features/media/sony_jpg" copied to "manual4" named:
  #  | DSC03403.JPG |
  #  | DSC03313.JPG |
  #  | DSC03499.JPG |

  #   When I cd to "manual4"
  #   When I run the following commands:
  #   """bash
  #   phls | phrename --manual_date '20171030-230400' -a anb --shift_time 10
  #   """
  #   Then the exit status should be 0

  #   Then the stdout should contain each of:
  #   | 20171030-230400_ANB DSC03313.JPG |
  #   | 20171030-230410_ANB DSC03403.JPG |
  #   | 20171030-230420_ANB DSC03499.JPG |
  #   And the following files should exist:
  #   | 20171030-230400_ANB DSC03313.JPG |
  #   | 20171030-230410_ANB DSC03403.JPG |
  #   | 20171030-230420_ANB DSC03499.JPG |
  #   And the following files should not exist:
  #   | ./DSC03313.JPG |
  #   | ./DSC03403.JPG |
  #   | ./DSC03499.JPG |
  #   | 20130103-103254_ANB DSC03313.JPG |
  #   | 20130103-153908_ANB DSC03403.JPG |
  #   | 20130104-120745_ANB DSC03499.JPG |

  # Scenario: In MANUAL-RENAME mode with --header parameter files are renamed to standard name and HEADER is added to the beginning of the original name
  #   Given empty files named:
  #   | 01.JPG |
  #   | 02.JPG |
  #   When I run the following commands:
  #   """bash
  #   phls | phrename --manual_date '20171031-215318' -a anb --header 'FLM99-'
  #   """
  #   Then the exit status should be 0
  #   And the stdout should contain each of:
  #   | 20171031-215318_ANB FLM99-01.JPG |
  #   | 20171031-215318_ANB FLM99-02.JPG |
  #   And the following files should exist:
  #   | 20171031-215318_ANB FLM99-01.JPG |
  #   | 20171031-215318_ANB FLM99-02.JPG |
