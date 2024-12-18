# language: en
Feature: Generate a list of ftools-friendly-files
  In order to simplify selection the foto\video files for further process
  As a photographer
  I want to get the list of foto\video files in a form of a plain text
  (one filename by line) in stdout channel

  @ftls
  Scenario: Output with -h produces usage information
    When I run `ftls -h`
    Then the stdout should contain each of:
      | Keep Your Media Files In Order (c) ANB |
      | Usage:                                 |
      | Options:                               |
      | -h, --help                             |
      | --debug                                |
      | -V, --version                          |


  @ftls
  Scenario: Output with -V produces version information
    When I run `ftls -V`
    Then the output should match /[0-9]+\.[0-9]+\.[0-9]+(-[a-z,0-9]+)?/

  @ftls
  Scenario: Can show which file types are supported by the command
    When I run `ftls --supported_types`
    Then the stdout should contain each of:
      | supports file types |
      | jpg                 |
      | heic                |
      | cr3                |


  @ftls
  Scenario: The command does not process hidden files
    Given empty files named:
      | foto.jpg   |
      | ._foto.jpg |
    When I successfully run `ftls`
    Then the stdout should contain each of:
      | foto.jpg |
    And the stdout should not contain "._foto.jpg"


  @ftls
  Scenario: Default output produces supported-by-ftools file list from current directory
    Given empty files named:
#    | foto.jpeg       |
      | foto.jpg        |
#    | foto.tif        |
#    | foto.tiff       |
#    | foto.orf        |
#    | foto.arw        |
#    | foto.png        |
#    | foto.dng        |
      | foto.heic       |
      | foto.cr3       |
      | foto_wrong.psd  |
#    | video.avi       |
#    | video.mp4       |
#    | video.mpg       |
#    | video.mts       |
#    | video.dv        |
#    | video.mov       |
      | video_wrong.xxx |
#    | video.mkv       |
#    | video.m2t       |
#    | video.m2ts      |
#      | video.3gp       |
      | file_no_ext     |
#
    When I successfully run `ftls`
    Then the stdout should contain each of:
#    | foto.jpeg |
      | foto.jpg |
      | foto.cr3 |
#    | foto.tif  |
#    | foto.tiff |
#    | foto.orf  |
#    | foto.arw  |
#    | foto.png  |
#    | foto.dng  |
    | foto.heic |
#    | video.avi |
#    | video.mp4 |
#    | video.mpg |
#    | video.dv  |
#    | video.mts |
#    | video.mov |
#    | video.mkv |
#    | video.m2t |
#    | video.m2ts|
#    | video.3gp |
    And the stdout should not contain "foto_wrong.psd"
    And the stdout should not contain "video_wrong.xxx"
    And the stdout should not contain "file_no_ext"

  @ftls
  Scenario: The command output shows files inside given directories
    Given a directory named "fotos1"
    And empty files named:
      | ./fotos1/d1_f1.jpg |
      | ./fotos1/d1_f2.jpg |
      | ./fotos1/d1_f3.jpg |
      | ./fotos1/d1_f4.jpg |
    Given a directory named "fotos2"
    And empty files named:
      | ./fotos2/d2_f1.jpg |
      | ./fotos2/d2_f2.jpg |
      | ./fotos2/d2_f3.jpg |
      | ./fotos2/d2_f4.jpg |
    When I successfully run `ftls fotos1 fotos2`
    Then the stdout should contain each of:
      | d1_f1.jpg |
      | d1_f2.jpg |
      | d1_f3.jpg |
      | d1_f4.jpg |
      | d2_f1.jpg |
      | d2_f2.jpg |
      | d2_f2.jpg |
      | d2_f3.jpg |
      | d2_f4.jpg |


  @ftls
  Scenario: Output produces file list filtered with given masks from current directory
    Given empty files named:
      | foto1_yes_.jpg |
      | foto2.jpg      |
      | foto3_yes.heic |
      | foto4.heic     |
      | ok-foto5.jpg   |
      | ok-foto6.heic  |
    When I successfully run `ftls '*_yes*.*' 'ok*.jpg'`
    Then the stdout should contain each of:
      | foto1_yes_.jpg |
      | foto3_yes.heic |
      | ok-foto5.jpg   |
    And the stdout should not contain any of:
      | foto2.jpg     |
      | foto4.heic    |
      | ok-foto6.heic |


  @ftls
  Scenario: The output shows files inside directories and subdirectories if run recursive
    Given a directory named "fotos"
    And empty files named:
      | ./fotos/f1.jpg |
    And a directory named "fotos/fotos2"
    And empty files named:
      | ./fotos/fotos2/f2.jpg |
    And a directory named "fotos/fotos2/fotos3"
    And empty files named:
      | ./fotos/fotos2/fotos3/f3.jpg |
    When I successfully run `ftls --recursive fotos`
    Then the stdout should contain each of:
      | f1.jpg               |
      | f2.jpg        |
      | f3.jpg |

  @ftls
  Scenario: The output DOES NOT show unsupported files EVEN if I intentionally enter it as a parameter
    Given empty files named:
    | foto_wrong.psd  |
    | video_wrong.xxx |
    When I successfully run `ftls foto_wrong.psd video_wrong.xxx`
    Then the stdout should not contain "foto_wrong.psd"
    And  the stdout should not contain "video_wrong.xxx"

  @ftls
  Scenario: The output shows files only inside directories entered as paramenets and not files outside
    Given a directory named "fotos"
    And empty files named:
      | ./fotos/f1.jpg  |
      | ./fotos/f2.jpg  |
      | ./fotos/f3.jpg  |
      | ./fotos/f4.heic |
    And a directory named "videos"
#    And empty files named:
#    | ./videos/v4.avi       |
#    | ./videos/v4.mp4       |
#    | ./videos/v4.mpg       |
#    | ./videos/v4.dv        |
    And empty files named:
      | foto_wrong1.jpg |
      | foto_wrong2.jpg |
    When I successfully run `ftls fotos videos`
    Then the stdout should contain each of:
      | f1.jpg    |
      | f3.jpg  |
      | f2.jpg  |
      | f4.heic |
#      | v4.avi   |
#      | v4.mp4   |
#      | v4.mpg   |
#      | v4.dv    |
    And the stdout should not contain any of:
      | foto_wrong1.jpg |
      | foto_wrong2.jpg |

  @ftls
  Scenario: The output DOES NOT show usupported files inside directories entered as paramenets
    Given a directory named "fotos"
    And empty files named:
    | ./fotos/f5_wrong.ppp  |
    And a directory named "videos"
    And empty files named:
    | ./videos/v5_wrong.vvv  |
    When I successfully run `ftls fotos videos`
    Then the stdout should not contain "f5_wrong.ppp"
    And  the stdout should not contain "v5_wrong.vvv"

  @ftls
  Scenario: Output produces file list filtered with given masks from given directories
    Given a directory named "fotos"
    And empty files named:
      | fotos/foto1_yes_.jpg  |
      | fotos/foto1_yes_.heic |
      | fotos/foto1_no.jpg    |
      | fotos/foto1_no.heic   |
#    And a directory named "videos"
#    And empty files named:
#    | videos/video.avi       |
#    | videos/video_yes_.mp4  |
#    | videos/video.mpg       |
#    | videos/video_yes_.mts  |
    When I successfully run `ftls fotos videos '*_yes*'`
    Then the stdout should contain each of:
      | foto1_yes_.jpg  |
      | foto1_yes_.heic |
#      | videos/video_yes_.mp4 |
#      | videos/video_yes_.mts |
    And the stdout should not contain any of:
      | foto1_no.jpg  |
      | foto1_no.heic |

  @ftls
  Scenario: The output shows only files, no folders (even if folder name looks like a file)
    Given a directory named "foto.jpg"
    And empty files named:
    | foto1.jpg         |
    | foto2.jpg         |
    When I successfully run `ftls`
    Then the stdout should contain each of:
    | foto1.jpg         |
    | foto2.jpg         |
    And the stdout should not contain any of:
    | foto.jpg  |

  @ftls
  Scenario: Output produces supported-by-ftools file list keeping extentions unchanged (e.g. capitalized will remain capitalized)
    Given a directory named "capitalized"
    Given empty files named:
      | ./capitalized/foto1.JPG |
      | ./capitalized/foto2.jpg |
    When I successfully run `ftls capitalized`
    Then the stdout should contain each of:
      | foto1.JPG  |
      | foto2.jpg  |

  @ftls
  Scenario: The output shows only files included in the given RANGE
    And empty files named:
    | DSC3198.jpg       |
    | DSC3199.jpg       |
    | DSC3200.jpg       |
    | DSC3201.jpg       |
    | DSC3202.jpg       |
    | DSC3203.jpg       |
    When I successfully run `ftls --range "199..201"`
    Then the stdout should contain each of:
    | DSC3199.jpg       |
    | DSC3200.jpg       |
    | DSC3201.jpg       |
    And the stdout should not contain any of:
    | DSC3198.jpg       |
    | DSC3202.jpg       |
    | DSC3203.jpg       |

  @ftls
  Scenario: The output shows nothing if RANGE is incorrect
    And empty files named:
    | DSC3198.jpg       |
    | DSC3199.jpg       |
    | DSC3200.jpg       |
    | DSC3201.jpg       |
    | DSC3202.jpg       |
    | DSC3203.jpg       |
    When I successfully run `ftls --range '199..20'`
    And the stdout should not contain any of:
    | DSC3198.jpg       |
    | DSC3199.jpg       |
    | DSC3200.jpg       |
    | DSC3201.jpg       |
    | DSC3202.jpg       |
    | DSC3203.jpg       |
