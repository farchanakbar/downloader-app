part of 'gdrive_bloc.dart';

abstract class GdriveState extends Equatable {
  const GdriveState();

  @override
  List<Object> get props => [];
}

class GdriveInitial extends GdriveState {}

class GdriveLoading extends GdriveState {}

class GdriveLoaded extends GdriveState {
  final GoogleDrive googleDrive;

  const GdriveLoaded(this.googleDrive);
}

class GdriveDownloadInProgress extends GdriveState {
  final int progress;
  final int total;

  @override
  List<Object> get props => [progress, total];

  const GdriveDownloadInProgress(this.progress, this.total);
}

class GdriveCompleted extends GdriveState {}

class GdriveText extends GdriveState {
  final bool hasText;

  @override
  List<Object> get props => [hasText];

  const GdriveText(this.hasText);
}

class GdriveError extends GdriveState {
  final String error;

  const GdriveError(this.error);
}
