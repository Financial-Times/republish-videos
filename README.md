# Video republishing script

This is a one-time-use republishing script for videos existing in Universal Publishing Platform.

We force-notify _brightcove-notifier_ and _brightcove-metadata-notifier_, they will fetch the everything from Brightcove and send them through our publishing pipelines.

After this we will have their native form in the native stores, and we could have a Jenkins job for republishing individual videos. In that future case we will not have to go to Brightcove, just take the native content from nativerw and post to notifiers.

## Usage

Command line arguments are: _publishing environment tag_, _file containing the video id list_, _basic authentication for the CoCo cluster_, _parallelism factor: how many parallel requests_

`ruby republish-videos.rb pub-prod-uk identifiers.txt "Basic dXB..." 16 > republish-videos.log`

It's recommended to save the output to a file, for after analysis.

## Input file format

example:

```
"1000142350001"
"1000147905001"
"1000147915001"
"1000596923001"
"1001049056001"
"1002020647001"
"1005835904001"
"1006678550001"
"1007994235001"
"1008118387001"
```

## Output format

example:

```
date='2016-09-07 13:22:36 +0300' thread=5 n=0 tid=republish-video-1002020647001 path='/force-notify/1002020647001' resp=200
date='2016-09-07 13:22:36 +0300' thread=12 n=0 tid=republish-video-1009492286001 path='/force-notify/1009492286001' resp=200
date='2016-09-07 13:22:36 +0300' thread=1 n=0 tid=republish-video-1000147905001 path='/force-notify/1000147905001' resp=200
date='2016-09-07 13:22:36 +0300' thread=13 n=0 tid=republish-video-1010353240001 path='/force-notify/1010353240001' resp=200
date='2016-09-07 13:22:36 +0300' thread=15 n=0 tid=republish-video-1010476986001 path='/force-notify/1010476986001' resp=200
date='2016-09-07 13:22:36 +0300' thread=9 n=0 tid=republish-video-1008118387001 path='/force-notify/1008118387001' resp=200
date='2016-09-07 13:22:36 +0300' thread=14 n=0 tid=republish-video-1010355857001 path='/force-notify/1010355857001' resp=200
date='2016-09-07 13:22:36 +0300' thread=3 n=0 tid=republish-video-1000596923001 path='/force-notify/1000596923001' resp=200
date='2016-09-07 13:22:36 +0300' thread=11 n=0 tid=republish-video-1009246281001 path='/force-notify/1009246281001' resp=200
date='2016-09-07 13:22:36 +0300' thread=4 n=0 tid=republish-video-1001049056001 path='/force-notify/1001049056001' resp=200
```