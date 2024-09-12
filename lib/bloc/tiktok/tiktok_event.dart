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

class StartDownloadMp4 extends TiktokEvent {
  final String url;
  final String fileName;

  const StartDownloadMp4(this.url, this.fileName);
}

class StartDownloadMp3 extends TiktokEvent {
  final String url;
  final String fileName;

  const StartDownloadMp3(this.url, this.fileName);
}

class TextChanged extends TiktokEvent {
  final bool isText;

  const TextChanged(this.isText);
}

class CancelDownloadMp4 extends TiktokEvent {}

class CancelDownloadMp3 extends TiktokEvent {}
