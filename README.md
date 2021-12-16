# mic-volume
A script that displays the sound status of the PulseAudio default source (microphone).

## Dependencies
- pactl (libpulse)

## Module
```ini
[module/mic-volume]
type = custom/script
tail = true
exec = $SCRIPTS/mic-volume/mic-volume.sh
click-left = $SCRIPTS/mic-volume/mic-volume.sh mute
scroll-up = $SCRIPTS/mic-volume/mic-volume.sh inc
scroll-down = $SCRIPTS/mic-volume/mic-volume.sh dec
```