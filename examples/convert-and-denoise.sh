#!/bin/bash
# Usage:
#       [source-file] [dest-file]


set -xeuo pipefail

echo Denoising $1 -> $2

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

tmp_wav_in=/tmp/48-raw-single.pcm
tmp_wav_out=/tmp/48-raw-single-denoised.pcm
# -ac 1 = mono, s16le is raw
ffmpeg -y -i $1 -ac 1 -f s16le -c:a pcm_s16le $tmp_wav_in
$DIR/rnnoise_demo $tmp_wav_in $tmp_wav_out
ffmpeg -y -f s16le -i $tmp_wav_out $2

