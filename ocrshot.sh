#!/bin/bash
grim -g "$(slurp)" - | tee /tmp/ocr.png | tesseract stdin stdout -l eng | xclip -selection clipboard
notify-send "OCR complete! Text copied to clipboard."
