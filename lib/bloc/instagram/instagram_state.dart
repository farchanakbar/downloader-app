part of 'instagram_bloc.dart';

abstract class InstagramState extends Equatable {
  const InstagramState();

  @override
  List<Object> get props => [];
}

class InstagramInitial extends InstagramState {}

class InstagramLoading extends InstagramState {}

class InstagramLoaded extends InstagramState {
  final Instagram instagram;

  const InstagramLoaded(this.instagram);
}

class InstagramDownloadInProgress extends InstagramState {
  final int progress;
  final int total;

  @override
  List<Object> get props => [progress, total];

  const InstagramDownloadInProgress(this.progress, this.total);
}

class InstagramCompleted extends InstagramState {}

class InstagramText extends InstagramState {
  final bool hasText;

  @override
  List<Object> get props => [hasText];

  const InstagramText(this.hasText);
}

class InstagramError extends InstagramState {
  final String error;

  const InstagramError(this.error);
}
