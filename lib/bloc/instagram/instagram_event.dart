part of 'instagram_bloc.dart';

abstract class InstagramEvent extends Equatable {
  const InstagramEvent();

  @override
  List<Object> get props => [];
}

class FetchInstagram extends InstagramEvent {
  final String url;

  const FetchInstagram(this.url);
}

class InstagramStartDownloadMp4 extends InstagramEvent {
  final String url;
  final String fileName;

  const InstagramStartDownloadMp4(this.url, this.fileName);
}

class InstagramTextChanged extends InstagramEvent {
  final bool isText;

  const InstagramTextChanged({this.isText = false});
}

class InstagramCancelDownloadMp4 extends InstagramEvent {}
