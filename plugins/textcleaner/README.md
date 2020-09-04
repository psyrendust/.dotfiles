# TEXTCLEANER

See [http://www.fmwconcepts.com/imagemagick/textcleaner/](http://www.fmwconcepts.com/imagemagick/textcleaner/) for more details.

## Example Usage

```
textcleaner -g -e normalize -f 45 -o 2 -u -s 1 -T -p 50 test.tiff test3.tiff
```

## Authors Info

```
Developed by Fred Weinhaus 6/9/2009 .......... revised 6/26/2015

------------------------------------------------------------------------------

Licensing:

Copyright © Fred Weinhaus

My scripts are available free of charge for non-commercial use, ONLY.

For use of my scripts in commercial (for-profit) environments or
non-free applications, please contact me (Fred Weinhaus) for
licensing arrangements. My email address is fmw at alink dot net.

If you: 1) redistribute, 2) incorporate any of these scripts into other
free applications or 3) reprogram them in another scripting language,
then you must contact me for permission, especially if the result might
be used in a commercial or for-profit environment.

My scripts are also subject, in a subordinate manner, to the ImageMagick
license, which can be found at: http://www.imagemagick.org/script/license.php

------------------------------------------------------------------------------

##

USAGE: textcleaner [-r rotate] [-l layout] [-c cropoff] [-g] [-e enhance ] [-f filtersize] [-o offset] [-u]  [-t threshold] [-s sharpamt] [-s saturation] [-a adaptblur] [-T] [-p padamt] [-b bgcolor] infile outfile
USAGE: textcleaner [-help]

OPTIONS:

-r      rotate            rotate image 90 degrees in direction specified if
                          aspect ratio does not match layout; options are cw
                          (or clockwise), ccw (or counterclockwise) and n
                          (or none); default=none or no rotation
-l      layout            desired layout; options are p (or portrait) or
                          l (or landscape); default=portrait
-c      cropoff           image cropping offsets after potential rotate 90;
                          choices: one, two or four non-negative integer comma
                          separated values; one value will crop all around;
                          two values will crop at left/right,top/bottom;
                          four values will crop left,top,right,bottom
-g                        convert document to grayscale before enhancing
-e      enhance           enhance image brightness before cleaning;
                          choices are: none, stretch or normalize;
                          default=stretch
-f      filtersize        size of filter used to clean background;
                          integer>0; default=15
-o      offset            offset of filter in percent used to reduce noise;
                          integer>=0; default=5
-u                        unrotate image; cannot unrotate more than
                          about 5 degrees
-t      threshold         text smoothing threshold; 0<=threshold<=100;
                          nominal value is about 50; default is no smoothing
-s      sharpamt          sharpening amount in pixels; float>=0;
                          nominal about 1; default=0
-S      saturation        color saturation expressed as percent; integer>=0;
                          only applicable if -g not set; a value of 100 is
                          no change; default=200 (double saturation)
-a      adaptblur         alternate text smoothing using adaptive blur;
                          floats>=0; default=0 (no smoothing)
-T                        trim background around outer part of image
-p      padamt            border pad amount around outer part of image;
                          integer>=0; default=0
-b      bgcolor           desired color for background; default=white

#

NAME: TEXTCLEANER

PURPOSE: To process a scanned document of text to clean the text background.

DESCRIPTION: TEXTCLEANER processses a scanned document of text to clean
the text background and enhance the text. The order of processing is:
1) optional 90 degree rotate if aspect does not match layout
2) optional crop,
3) optional convert to grayscale,
4) optional enhance,
5) filter to clean background and optionally smooth/antialias,
6) optional unrotate (limited to about 5 degrees or less),
7) optional text smoothing,
8) optional sharpening,
9) optional saturation change (if -g is not specified),
10) optional alternate text smoothing via adaptive blur
11) optional auto trim of border (effective only if background well-cleaned),
12) optional pad of border

OPTIONS:

-r rotate ... ROTATE image either clockwise or counterclockwise by 90 degrees,
if image aspect ratio does not match the layout mode. Choices are: cc (or
clockwise), ccw (or counterclockwise) and n (or none). The default is no rotation.

-l layout ... LAYOUT for determining if rotation is to be applied. The choices
are p (or portrait) or l (or landscape). The image will be rotated if rotate is
specified and the aspect ratio of the image does not match the layout chosen.
The default is portrait.

-c cropoffsets ... CROPOFFSETS are the image cropping offsets after potential
rotate 90. Choices: one, two or four non-negative integer comma separated
values. One value will crop all around. Two values will crop at
left/right,top/bottom. Four values will crop left,top,right,bottom.

-g ... Convert the document to grayscale.

-e enhance ... ENHANCE brightness of image. The choices are: none, stretch,
or normalize. The default=stretch.

-f filtersize ... FILTERSIZE is the size of the filter used to clean up the
background. Values are integers>0. The filtersize needs to be larger than
the thickness of the writing, but the smaller the better beyond this. Making it
larger will increase the processing time and may lose text. The default is 15.

-o offset ... OFFSET is the offset threshold in percent used by the filter
to eliminate noise. Values are integers>=0. Values too small will leave much
noise and artifacts in the result. Values too large will remove too much
text leaving gaps. The default is 5.

-u ... UNROTATE the image. This is limited to about 5 degrees or less.

-t threshold ... THRESHOLD is the text smoothing threshold. Values are integers
between 0 and 100. Smaller values smooth/thicken the text more. Larger values
thin, but can result in gaps in the text. Nominal value is in the middle at
about 50. The default is to disable smoothing.

-s sharpamt ... SHARPAMT is the amount of pixel sharpening to be applied to
the resulting text. Values are floats>=0. If used, it should be small
(suggested about 1). The default=0 (no sharpening).

-S saturation ... SATURATION is the desired color saturation of the text
expressed as a percentage. Values are integers>=0. A value of 100 is no change.
Larger values will make the text colors more saturated. The default=200
indicates double saturation. Not applicable when -g option specified.

-a adaptblur ... ADAPTBLUR applies an alternate text smoothing using
an adaptive blur. The values are floats>=0. The default=0 indicates no
blurring.

-T ... TRIM the border around the image.

-p padamt ... PADAMT is the border pad amount in pixels. The default=0.

-b bgcolor ... BGCOLOR is the desired background color after it has been
cleaned up. Any valid IM color may be use. The default is white.

CAVEAT: No guarantee that this script will work on all platforms,
nor that trapping of inconsistent parameters is complete and
foolproof. Use At Your Own Risk.
```
