part of 'facebook_bloc.dart';

abstract class FacebookEvent extends Equatable {
  const FacebookEvent();

  @override
  List<Object> get props => [];
}

class FetchFacebook extends FacebookEvent {
  final String url;

  const FetchFacebook(this.url);
}

class FacebookStartDownloadMp4 extends FacebookEvent {
  final String url;
  final String fileName;

  const FacebookStartDownloadMp4(this.url, this.fileName);
}

class FacebookTextChanged extends FacebookEvent {
  final bool isText;

  const FacebookTextChanged({this.isText = false});
}

class FacebookCancelDownloadMp4 extends FacebookEvent {}
