part of 'facebook_bloc.dart';

abstract class FacebookState extends Equatable {
  const FacebookState();

  @override
  List<Object> get props => [];
}

class FacebookInitial extends FacebookState {}

class FacebookLoading extends FacebookState {}

class FacebookLoaded extends FacebookState {
  final FacebookReels facebook;

  const FacebookLoaded(this.facebook);
}

class FacebookDownloadInProgress extends FacebookState {
  final int progress;
  final int total;

  @override
  List<Object> get props => [progress, total];

  const FacebookDownloadInProgress(this.progress, this.total);
}

class FacebookCompleted extends FacebookState {}

class FacebookText extends FacebookState {
  final bool hasText;

  @override
  List<Object> get props => [hasText];

  const FacebookText(this.hasText);
}

class FacebookError extends FacebookState {
  final String error;

  const FacebookError(this.error);
}
