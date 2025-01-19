# PARC

`PARC` is short for `P`recise `A`udio `R`ip `C`ontainer.

## Motivation

I've got a large CD collection. All of my CDs are ripped to MP3. At home I have my own music streaming system ;-) While listening to my music, I've discovered that some of the songs are incomplete ripped or have some other disadvantages like non common tags or things like that. So I have decided to rip my CD collection again.

## Several options

### Hardware

The first idea was to get a commecial device capable of ripping CDs. There are a few ones like

- [Brennan B3][dev-brennan-b3]
- [EverSolo DMP-A6 Gen 2][dev-eversolo-dmp8]
- [Musical Fidelity MX Stream][dev-musicalfidelity-mxstream]
- [sonicTransporter i5][dev-sonictransporter-i5]
- [Zidoo UHD 5000][dev-zidoo-uhd5000]

All in common is that they capable to rip audio CDs. You can influence the ripping process somehow - but all of them are optimized for _speed_ and left the question about _quality_.

### Software

Another option is to do this with plain software. There are various programs available to rip CDs on a PC, e. g.

- [Asunder][app-asunder]
- [CDex][app-cdex]
- [EAC][app-eac]
- [fre:ac][app-freac]

These are a few ones - on the internet there are much more programs to find.

## Requirements

But this is not what I wanted. The longer I'm dealing with the process of ripping CDs, the more information I got and finally I've got the following requirements:

- Support of [AccurateRip][info-accuraterip]
- Support of [cue sheets][info-cuesheets]
- Support of [Musicbrainz][info-musicbrainz]

These requirements will kick off all hardware and almost all software except a few ones.

## Inspiration

Playing around with the container [docker-ripper][app-docker-ripper] and providing some pull request the idea of an own container was born. Additional the blog article [How to rip and tag CD's PROPERLY!][info-tuxtower-post] of Adam Wyatt showed me that this will be possible.

### Prerequisites

The idea will be killed if the utility [CUEtools][app-cuetools], especially the _CUERipper_ will not compile on Linux.

### Process

In theory ripping an audio CD might be a simple process. We will see if this is really such an easy task. Basically there are the following steps:

- Check if an audio CD is inserted
  - Track if CD drive is opened and closed
  - Track if an audio CD is inserted
  - Track if audio CD is already ripped
- No audio CD inserted => continue with previous step
- Request information about CD from [Musicbrainz][info-musicbrainz]
- Rip audio CD with _CUERipper_ regarding
  - [AccurateRip][info-accuraterip]
  - [cue sheets][info-cuesheets]
- Pre-tag ripped files with information of [Musicbrainz][info-musicbrainz]
  - For an UI and non unique result of [Musicbrainz][info-musicbrainz]: Wait for X seconds until user selected cover/CD, if nothing is selected, take first one

The final tagging has to be done manually on the ripped files using [Musicbrainz Picard][app-musicbrainz-picard].

### Software

The container requires some software to get the process described above alive. I'm not sure how to do this at the moment. The options here are

- [bash scripts][lang-bash]
- [Python scripts][lang-python]

[app-asunder]: http://www.littlesvr.ca/asunder/
[app-cdex]: https://cdex.mu/
[app-cuetools]: https://github.com/gchudov/cuetools.net
[app-docker-ripper]: https://github.com/rix1337/docker-ripper
[app-eac]: https://www.exactaudiocopy.de/
[app-freac]: https://www.freac.org/
[app-musicbrainz-picard]: https://picard.musicbrainz.org/
[dev-brennan-b3]: https://brennan.co.uk/pages/b3-overview
[dev-eversolo-dmp8]: https://www.eversolo.de/products/eversolo-dmp-a6-gen-2-digital-media-player-streamer
[dev-musicalfidelity-mxstream]: https://www.musicalfidelity.com/mx-stream
[dev-sonictransporter-i5]: https://www.smallgreencomputer.com/collections/audio-server/products/sonictransporter-i5
[dev-zidoo-uhd5000]: https://www.zidoo.de/products/zidoo-uhd-5000-android-4k-mediaplayer
[info-accuraterip]: https://accuraterip.com/
[info-cuesheets]: https://en.wikipedia.org/wiki/Cue_sheet_(computing)
[info-musicbrainz]: https://musicbrainz.org/
[info-tuxtower-post]: https://tuxtower.net/blog/rippingcds/
[lang-bash]: https://devhints.io/bash
[lang-python]: https://www.python.org/
