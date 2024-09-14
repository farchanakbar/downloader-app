part of 'gdrive_bloc.dart';

abstract class GdriveEvent extends Equatable {
  const GdriveEvent();

  @override
  List<Object> get props => [];
}

class FetchGdrive extends GdriveEvent {
  final String url;

  const FetchGdrive(this.url);
}

class GdriveStartDownload extends GdriveEvent {
  final String url;
  final String fileName;
  final String tipeFile;

  const GdriveStartDownload(this.url, this.fileName, this.tipeFile);
}

class GdriveTextChanged extends GdriveEvent {
  final bool isText;

  const GdriveTextChanged({this.isText = false});
}

class GdriveCancelDownload extends GdriveEvent {}
