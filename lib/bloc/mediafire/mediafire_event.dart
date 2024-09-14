part of 'mediafire_bloc.dart';

abstract class MediafireEvent extends Equatable {
  const MediafireEvent();

  @override
  List<Object> get props => [];
}

class FetchMediafire extends MediafireEvent {
  final String url;

  const FetchMediafire(this.url);
}

class MediafireStartDownload extends MediafireEvent {
  final String url;
  final String fileName;
  final String tipeFile;

  const MediafireStartDownload(this.url, this.fileName, this.tipeFile);
}

class MediafireTextChanged extends MediafireEvent {
  final bool isText;

  const MediafireTextChanged({this.isText = false});
}

class MediafireCancelDownload extends MediafireEvent {}
