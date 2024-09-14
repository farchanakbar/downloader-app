part of 'mediafire_bloc.dart';

abstract class MediafireState extends Equatable {
  const MediafireState();

  @override
  List<Object> get props => [];
}

class MediafireInitial extends MediafireState {}

class MediafireLoading extends MediafireState {}

class MediafireLoaded extends MediafireState {
  final Mediafire mediafire;

  const MediafireLoaded(this.mediafire);
}

class MediafireDownloadInProgress extends MediafireState {
  final int progress;
  final int total;

  @override
  List<Object> get props => [progress, total];

  const MediafireDownloadInProgress(this.progress, this.total);
}

class MediafireCompleted extends MediafireState {}

class MediafireText extends MediafireState {
  final bool hasText;

  @override
  List<Object> get props => [hasText];

  const MediafireText(this.hasText);
}

class MediafireError extends MediafireState {
  final String error;

  const MediafireError(this.error);
}
