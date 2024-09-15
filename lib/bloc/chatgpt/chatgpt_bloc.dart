import 'package:app_downloader/data/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chatgpt_event.dart';
part 'chatgpt_state.dart';

class ChatgptBloc extends Bloc<ChatgptEvent, ChatgptState> {
  final dio = ApiService().dio;
  ChatgptBloc() : super(ChatgptInitial()) {
    on<ChatgptSend>(
      (event, emit) async {
        // print(response.data['response']);
        emit(ChatgptLoading());
        try {
          final response = await dio.get('/api/ai/chatgpt?text=${event.text}');
          emit(ChatgptLoaded(response.data['response']));
          emit(ChatgptComplate());
        } catch (e) {
          emit(const ChatgptError('Gagal memuat data!'));
        }
      },
    );

    on<ChatgptTextChanged>(
      (event, emit) {
        emit(
          ChatgptText(event.isText),
        );
      },
    );
  }
}
