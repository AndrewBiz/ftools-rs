# language: en
Feature: Generate a list of ftools-friendly-files
  In order to simplify selection the foto\video files for further process
  As a photographer
  I want to get the list of foto\video files in a form of a plain text
  (one filename by line) in stdout channel

  Scenario: Output with -h produces usage information
    When I run `ftls -h`
    Then the stdout should contain each of:
      | *Keep Your Media Files In Order* (c) ANB |
      | USAGE:                                   |
      | OPTIONS:                                 |
      | -h, --help                               |
      | -V, --version                            |

#
#  Scenario: Debug (verbose) mode is implemented
#    When I run `ftls -h`
#    Then the stdout should contain each of:
#      | -v, --verbose |
#
  Scenario: Output with -V produces version information
    When I run `ftls -V`
    Then the output should match /[0-9]+\.[0-9]+\.[0-9]+(-[a-z,0-9]+)?/
#
  Scenario: Can show which file types are supported by the command
    When I run `ftls --supported-types`
    Then the stdout should contain each of:
      | supports file types |
      | jpg                 |
      | heic                |
#
  #@announce
  Scenario: The command does not process hidden files
    Given empty files named:
      | foto.jpg   |
      | ._foto.jpg |
    When I successfully run `ftls`
    Then the stdout should contain each of:
      | foto.jpg |
    And the stdout should not contain "._foto.jpg"


  #@announce
  Scenario: Default output produces supported-by-ftools file list from current directory
    Given empty files named:
#    | foto.jpeg       |
      | foto.jpg |
#    | foto.tif        |
#    | foto.tiff       |
#    | foto.orf        |
#    | foto.arw        |
#    | foto.png        |
#    | foto.dng        |
#    | foto.heic       |
#    | foto_wrong.psd  |
#    | video.avi       |
#    | video.mp4       |
#    | video.mpg       |
#    | video.mts       |
#    | video.dv        |
#    | video.mov       |
#    | video_wrong.xxx |
#    | video.mkv       |
#    | video.m2t       |
#    | video.m2ts      |
#    | video.3gp       |
    When I successfully run `ftls`
    Then the stdout should contain each of:
#    | foto.jpeg |
      | foto.jpg |
#    | foto.tif  |
#    | foto.tiff |
#    | foto.orf  |
#    | foto.arw  |
#    | foto.png  |
#    | foto.dng  |
#    | foto.heic |
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
#
#  #@announce
#  Scenario: Output produces file list filtered with given mask from current directory
#    Given empty files named:
#    | foto_yes_.jpeg  |
#    | foto.jpg        |
#    | foto_yes_.tif   |
#    | foto.tiff       |
#    | foto_yes_.orf   |
#    | foto.arw        |
#    | foto_yes_.png   |
#    | foto.dng        |
#    | foto_wrong.psd  |
#    | video.avi       |
#    | video_yes_.mp4  |
#    | video.mpg       |
#    | video_yes_.mts  |
#    | video.dv        |
#    | video.mov       |
#    | video_wrong.xxx |
#    | video.mkv       |
#    | video.m2t       |
#    | video.m2ts      |
#    When I successfully run `phls '*_yes*.*'`
#    Then the stdout should contain each of:
#    | foto_yes_.jpeg  |
#    | foto_yes_.tif   |
#    | foto_yes_.orf   |
#    | foto_yes_.png   |
#    | video_yes_.mp4  |
#    | video_yes_.mts  |
#    And the stdout should not contain any of:
#    | foto.jpg        |
#    | foto.tiff       |
#    | foto.arw        |
#    | foto.dng        |
#    | foto_wrong.psd  |
#    | video.avi       |
#    | video.mpg       |
#    | video.dv        |
#    | video.mov       |
#    | video_wrong.xxx |
#    | video.mkv       |
#    | video.m2t       |
#    | video.m2ts      |
#
#  #@announce
#  Scenario: The output DOES NOT show unsupported files EVEN if I intentionally enter it as a parameter
#    Given empty files named:
#    | foto_wrong.psd  |
#    | video_wrong.xxx |
#    When I successfully run `phls foto_wrong.psd video_wrong.xxx`
#    Then the stdout should not contain "foto_wrong.psd"
#    And  the stdout should not contain "video_wrong.xxx"
#
#  #@announce
#  Scenario: The output shows files only inside directories entered as paramenets
#    Given a directory named "fotos"
#    And empty files named:
#    | ./fotos/f4.jpg       |
#    | ./fotos/f4.tiff      |
#    | ./fotos/f4.orf       |
#    | ./fotos/f4.arw       |
#    And a directory named "videos"
#    And empty files named:
#    | ./videos/v4.avi       |
#    | ./videos/v4.mp4       |
#    | ./videos/v4.mpg       |
#    | ./videos/v4.dv        |
#    And empty files named:
#    | foto_wrong.jpg  |
#    | video_wrong.jpg |
#    When I successfully run `phls fotos videos`
#    Then the stdout should contain each of:
#    | fotos/f4.jpg  |
#    | fotos/f4.tiff |
#    | fotos/f4.orf  |
#    | fotos/f4.arw  |
#    | videos/v4.avi |
#    | videos/v4.mp4 |
#    | videos/v4.mpg |
#    | videos/v4.dv  |
#    And the stdout should not contain any of:
#    | foto_wrong.jpg  |
#    | video_wrong.jpg |
#
#  #@announce
#  Scenario: The output DOES NOT show usupported files inside directories entered as paramenets
#    Given a directory named "fotos"
#    And empty files named:
#    | ./fotos/f5_wrong.ppp  |
#    And a directory named "videos"
#    And empty files named:
#    | ./videos/v5_wrong.vvv  |
#    When I successfully run `phls fotos videos`
#    Then the stdout should not contain "fotos/f5_wrong.ppp"
#    And  the stdout should not contain "videos/v5_wrong.vvv"
#
#  #@announce
#  Scenario: The output shows files inside directories and subdirectories if run recursive
#    Given a directory named "fotos"
#    And empty files named:
#    | ./fotos/f6.jpg         |
#    And a directory named "fotos/fotos2"
#    And empty files named:
#    | ./fotos/fotos2/f6.tif  |
#    And a directory named "fotos/fotos2/fotos3"
#    And empty files named:
#    | ./fotos/fotos2/fotos3/f6.png |
#    When I successfully run `phls --recursive fotos`
#    Then the stdout should contain each of:
#    | fotos/f6.jpg                 |
#    | fotos/fotos2/f6.tif          |
#    | fotos/fotos2/fotos3/f6.png   |
#
#  #@announce
#  Scenario: Output produces file list filtered with given masks from given directories
#    Given empty files named:
#    | foto_yes_.jpeg  |
#    | foto_yes_.tif   |
#    | foto.tiff       |
#    | foto.arw        |
#    And a directory named "fotos"
#    And empty files named:
#    | fotos/foto1_yes_.jpeg  |
#    | fotos/foto1_yes_.tif   |
#    | fotos/foto1.tiff       |
#    | fotos/foto1.arw        |
#    And a directory named "videos"
#    And empty files named:
#    | videos/video.avi       |
#    | videos/video_yes_.mp4  |
#    | videos/video.mpg       |
#    | videos/video_yes_.mts  |
#    When I successfully run `phls fotos videos '*_yes*'`
#    Then the stdout should contain each of:
#    | fotos/foto1_yes_.jpeg  |
#    | fotos/foto1_yes_.tif   |
#    | videos/video_yes_.mp4  |
#    | videos/video_yes_.mts  |
#    And the stdout should not contain any of:
#    | foto_yes_.jpeg  |
#    | foto_yes_.tif   |
#    | foto.tiff       |
#    | foto.arw        |
#    | fotos/foto1.tiff       |
#    | fotos/foto1.arw        |
#    | videos/video.avi       |
#    | videos/video.mpg       |
#
#  #@announce
#  Scenario: The output shows only files, no folders (even if folder name looks like a file)
#    Given a directory named "foto.jpg"
#    And a directory named "video.mov"
#    And empty files named:
#    | foto1.jpg         |
#    | foto2.jpg         |
#    | video1.mov        |
#    | video2.mov        |
#    When I successfully run `phls`
#    Then the stdout should contain each of:
#    | foto1.jpg         |
#    | foto2.jpg         |
#    | video1.mov        |
#    | video2.mov        |
#    And the stdout should not contain any of:
#    | foto.jpg  |
#    | video.mov |
#
#  #@announce
#  Scenario: Output produces supported-by-phtools file list keeping extentions unchanged (e.g. capitalized will remain capitalized)
#    Given a directory named "capitalized"
#    Given empty files named:
#    | ./capitalized/foto.TIF  |
#    | ./capitalized/video.DV  |
#    | ./capitalized/video.MOV |
#    | ./capitalized/video1.mov |
#    When I successfully run `phls capitalized`
#    Then the stdout should contain each of:
#    | foto.TIF  |
#    | video.DV  |
#    | video.MOV |
#    | video1.mov |
#
#  #@announce
#  Scenario: The output shows only files included in the given RANGE
#    And empty files named:
#    | DSC3198.jpg       |
#    | DSC3199.jpg       |
#    | DSC3200.jpg       |
#    | DSC3201.jpg       |
#    | DSC3202.jpg       |
#    | DSC3203.jpg       |
#    When I successfully run `phls --range '199..201'`
#    Then the stdout should contain each of:
#    | DSC3199.jpg       |
#    | DSC3200.jpg       |
#    | DSC3201.jpg       |
#    And the stdout should not contain any of:
#    | DSC3198.jpg       |
#    | DSC3202.jpg       |
#    | DSC3203.jpg       |
#
#  #@announce
#  Scenario: The output shows nothing if RANGE is incorrect
#    And empty files named:
#    | DSC3198.jpg       |
#    | DSC3199.jpg       |
#    | DSC3200.jpg       |
#    | DSC3201.jpg       |
#    | DSC3202.jpg       |
#    | DSC3203.jpg       |
#    When I successfully run `phls --range '199..20'`
#    And the stdout should not contain any of:
#    | DSC3198.jpg       |
#    | DSC3199.jpg       |
#    | DSC3200.jpg       |
#    | DSC3201.jpg       |
#    | DSC3202.jpg       |
#    | DSC3203.jpg       |
