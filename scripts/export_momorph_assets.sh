#!/usr/bin/env bash
# Export MM_MEDIA PNG từ Figma qua MoMorph MCP / Figma Images API.
# Yêu cầu: curl, quyền network. Chạy từ repo root.
set -euo pipefail

FILE_KEY="9ypp4enmFmdK3YAFJLIu6C"
ASSETS_ROOT="app/app/assets/images"

# Node IDs (MoMorph design items) → output path
declare -A NODES=(
  ["6885:9441"]="secret_box/secret_box_closed.png"
  ["6885:9790"]="secret_box/secret_box_gift.png"
  ["6885:9487"]="errors/error_not_found.png"
  ["6885:9529"]="errors/error_access_denied.png"
)

echo "SAA 2025 — export Figma PNG (scale=2)"
echo "File key: $FILE_KEY"
echo ""

# Lấy URL từ MoMorph CLI hoặc paste URL thủ công sau khi gọi:
#   mororph get_figma_image fileKey=$FILE_KEY nodeIds=[...] format=png scale=2
#
# Ví dụ URL (có thể hết hạn — chạy lại MCP get_figma_image):
URLS=(
  "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/7bc559dc-f233-477b-9ede-e2ef5ac8afaa|secret_box/secret_box_closed.png"
  "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/814b1fa6-f474-49c5-b8ee-508e0e440088|secret_box/secret_box_gift.png"
  "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/d9a2912e-5c06-4adc-a728-be4b1b674aca|errors/error_not_found.png"
  "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/643c3a03-cf1c-45c8-9744-7d527e29e75c|errors/error_access_denied.png"
)

for entry in "${URLS[@]}"; do
  url="${entry%%|*}"
  rel="${entry##*|}"
  out="$ASSETS_ROOT/$rel"
  mkdir -p "$(dirname "$out")"
  echo "→ $rel"
  curl -fsSL "$url" -o "$out"
done

echo ""
echo "Done. Regenerate Dart assets:"
echo "  cd app/app && python3 assets/resource_gen_script.py"
