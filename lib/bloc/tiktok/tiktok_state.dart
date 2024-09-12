part of 'tiktok_bloc.dart';

abstract class TiktokState extends Equatable {
  const TiktokState();

  @override
  List<Object> get props => [];
}

class TiktokInitial extends TiktokState {}

class TiktokLoading extends TiktokState {}

class TiktokLoaded extends TiktokState {
  final Tiktok tiktok;

  const TiktokLoaded(this.tiktok);
}

class DownloadInProgress extends TiktokState {
  final int progress;

  @override
  List<Object> get props => [progress];

  const DownloadInProgress(this.progress);
}

class TiktokCompleted extends TiktokState {}

class TiktokText extends TiktokState {
  final bool hasText;

  @override
  List<Object> get props => [hasText];

  const TiktokText(this.hasText);
}

class TiktokError extends TiktokState {
  final String error;

  const TiktokError(this.error);
}
