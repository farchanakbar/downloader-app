part of 'instagram_bloc.dart';

abstract class InstagramState extends Equatable {
  const InstagramState();
  
  @override
  List<Object> get props => [];
}

class InstagramInitial extends InstagramState {}
