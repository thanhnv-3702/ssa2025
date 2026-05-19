/// Result of a download request: bytes, optional filename from Content-Disposition, and optional content-type from response header.
class DownloadResult {
  final List<int> bytes;
  final String? filename;
  final String? title;
  final String? contentType;

  const DownloadResult(this.bytes, [this.filename, this.title, this.contentType]);
}
