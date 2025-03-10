# Bulk Video Intro Adder

A simple bash script that adds an intro video to multiple video files using FFmpeg's concat demuxer. This tool processes videos in batch, making it perfect for adding intros to multiple videos efficiently.

## Prerequisites

- FFmpeg installed on your system
- Bash shell environment

### Installing FFmpeg

#### macOS
```bash
brew install ffmpeg
```

#### Ubuntu/Debian
```bash
sudo apt update
sudo apt install ffmpeg
```

#### Windows
Download from [FFmpeg's official website](https://ffmpeg.org/download.html) or use Windows Subsystem for Linux (WSL).

## Usage

1. Clone the repository:
```bash
git clone https://github.com/biozalp/BulkVideoIntroAdderScript.git
cd BulkVideoIntroAdderScript
```

2. Make the script executable:
```bash
chmod +x concat.sh
```

3. Run the script:
```bash
./concat.sh <intro_video> <target_directory>
```

Example:
```bash
./concat.sh intro.mp4 ./videos
```

### Parameters

- `intro_video`: Path to the intro video file that will be added to the beginning of each video
- `target_directory`: Directory containing the videos you want to process

### Output

- Processed videos will be saved in an `output` directory within your target directory
- Output files will be prefixed with "with_intro_"
- Original files remain untouched

For example:
```
videos/
├── output/
│   ├── video1.mp4
│   └── video2.mp4
├── video1.mp4
└── video2.mp4
```

## Supported Formats

- MP4 (.mp4)
- MOV (.mov)
- AVI (.avi)

## Features

- Batch processing of multiple videos
- Lossless concatenation using FFmpeg's concat demuxer
- Preserves original video quality
- Handles spaces in filenames and paths
- Creates organized output directory
- Automatic cleanup of temporary files
- Skip processing of already processed videos

## Notes

- The script uses FFmpeg's concat demuxer which performs a lossless concatenation of the videos
- Original videos are not modified
- Videos in the output directory are automatically skipped to prevent re-processing
- Temporary files are automatically cleaned up after processing

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request
