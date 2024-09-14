class Mediafire {
  Mediafire({
    required this.url,
    required this.url2,
    required this.filename,
    required this.filetype,
    required this.ext,
    required this.upload,
    required this.filesizeH,
    required this.filesize,
  });

  final String? url;
  final String? url2;
  final String? filename;
  final String? filetype;
  final String? ext;
  final DateTime? upload;
  final String? filesizeH;
  final num? filesize;

  factory Mediafire.fromJson(Map<String, dynamic> json) {
    return Mediafire(
      url: json["url"],
      url2: json["url2"],
      filename: json["filename"],
      filetype: json["filetype"],
      ext: json["ext"],
      upload: DateTime.tryParse(json["upload"] ?? ""),
      filesizeH: json["filesizeH"],
      filesize: json["filesize"],
    );
  }
}
