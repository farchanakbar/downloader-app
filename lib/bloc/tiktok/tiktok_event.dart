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
