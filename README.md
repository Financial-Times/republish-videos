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
