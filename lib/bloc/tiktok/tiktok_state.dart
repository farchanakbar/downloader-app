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

class TiktokError extends TiktokState {
  final String error;

  const TiktokError(this.error);
}
