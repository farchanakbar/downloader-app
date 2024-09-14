class GoogleDrive {
  GoogleDrive({
    required this.fileName,
    required this.fileSize,
    required this.mimetype,
    required this.downloadUrl,
  });

  final String? fileName;
  final String? fileSize;
  final String? mimetype;
  final String? downloadUrl;

  factory GoogleDrive.fromJson(Map<String, dynamic> json) {
    return GoogleDrive(
      fileName: json["fileName"],
      fileSize: json["fileSize"],
      mimetype: json["mimetype"],
      downloadUrl: json["downloadUrl"],
    );
  }
}
