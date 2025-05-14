#!/bin/bash

# 参数设置
# audio_file="/mnt/workspace/zhangjunan/sheetsage/output/test/dont-u2无奈2-stretched.mp3"  # 替换为实际音频文件路径
# audio_file="/mnt/workspace/zhangjunan/sheetsage/output/test/lovelyglow_instrumental.mp3"  # 替换为实际音频文件路径
audio_file="/mnt/workspace/zhangjunan/sheetsage/output/test/loveglow.mp3"  # 替换为实际音频文件路径
# audio_file="/mnt/workspace/zhangjunan/sheetsage/output/test/space-cowboy.mp3"  # 替换为实际音频文件路径
output_dir="./output-no-jukebox"         # 替换为输出目录路径

# 1. 创建临时目录
tmp_dir=$(mktemp -d)

# 2. 第一次尝试提取 leadsheet（默认参数）
if ! python -m sheetsage.infer --output_dir "$tmp_dir" "$audio_file"; then
    # 3. 如果失败，使用 --measures_per_chunk 4 重试
    python -m sheetsage.infer --output_dir "$tmp_dir" "$audio_file" --measures_per_chunk 4
fi

# 4. 创建目标目录
mkdir -p "$output_dir/leadsheet-loveglow"

# 5. 复制临时文件到输出目录
cp -v "$tmp_dir"/* "$output_dir/leadsheet-loveglow/"

# 6. 清理临时目录
rm -rf "$tmp_dir"