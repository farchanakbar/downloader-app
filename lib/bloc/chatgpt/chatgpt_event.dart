part of 'chatgpt_bloc.dart';

abstract class ChatgptEvent extends Equatable {
  const ChatgptEvent();

  @override
  List<Object> get props => [];
}

class ChatgptTextChanged extends ChatgptEvent {
  final bool isText;

  @override
  List<Object> get props => [isText];

  const ChatgptTextChanged(this.isText);
}

class ChatgptSend extends ChatgptEvent {
  final String text;

  const ChatgptSend(this.text);
}
