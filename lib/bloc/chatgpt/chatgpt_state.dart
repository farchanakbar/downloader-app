part of 'chatgpt_bloc.dart';

abstract class ChatgptState extends Equatable {
  const ChatgptState();

  @override
  List<Object> get props => [];
}

class ChatgptInitial extends ChatgptState {}

class ChatgptLoading extends ChatgptState {}

class ChatgptLoaded extends ChatgptState {
  final String text;

  const ChatgptLoaded(this.text);
}

class ChatgptText extends ChatgptState {
  final bool hasText;

  @override
  List<Object> get props => [hasText];

  const ChatgptText(this.hasText);
}

class ChatgptError extends ChatgptState {
  final String error;

  const ChatgptError(this.error);
}
