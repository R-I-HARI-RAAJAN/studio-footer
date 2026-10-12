#!/usr/bin/env bash
# Fetches the exact fonts and source video, then builds the all-intra scrub clip.
# Run from the project root:  bash scripts/fetch-assets.sh
set -euo pipefail
mkdir -p public/fonts

curl -fL -o public/fonts/DMSans-Regular.woff2 \
  "https://cdn.prod.website-files.com/683703490bc01e1b8c052e06/68370ddd1dd328d7914d6512_DMSans-Regular.woff2"

curl -fL -o public/fonts/Epilogue-Black.woff2 \
  "https://cdn.prod.website-files.com/683703490bc01e1b8c052e06/68370ddd06d737200122a835_Epilogue-Black.woff2"

curl -fL -o public/footer-background.mp4 \
  "https://d8j0ntlcm91z4.cloudfront.net/user_38xzZboKViGWJOttwIXH07lWA1P/hf_20260908_073327_03643c0a-db33-417a-ae8f-4a39259c7f9c.mp4"

ffmpeg -hide_banner -loglevel error -y -i public/footer-background.mp4 -an \
  -c:v libx264 -preset fast -crf 20 -g 1 -pix_fmt yuv420p -movflags +faststart \
  public/footer-scrub.mp4

echo "Done: fonts, footer-background.mp4, footer-scrub.mp4"
