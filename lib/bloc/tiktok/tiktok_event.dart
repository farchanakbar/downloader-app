part of 'tiktok_bloc.dart';

abstract class TiktokEvent extends Equatable {
  const TiktokEvent();

  @override
  List<Object> get props => [];
}

class FetchTiktok extends TiktokEvent {
  final String url;

  const FetchTiktok(this.url);
}

class TiktokStartDownloadMp4 extends TiktokEvent {
  final String url;
  final String fileName;

  const TiktokStartDownloadMp4(this.url, this.fileName);
}

class TiktokStartDownloadMp3 extends TiktokEvent {
  final String url;
  final String fileName;

  const TiktokStartDownloadMp3(this.url, this.fileName);
}

class TiktokTextChanged extends TiktokEvent {
  final bool isText;

  const TiktokTextChanged({this.isText = false});
}

class TiktokCancelDownloadMp4 extends TiktokEvent {}

class TiktokCancelDownloadMp3 extends TiktokEvent {}
