import 'dart:convert';

import 'package:app_downloader/bloc/chatgpt/chatgpt_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatGptScreen extends StatefulWidget {
  const ChatGptScreen({super.key});

  @override
  State<ChatGptScreen> createState() => _ChatGptScreenState();
}

class _ChatGptScreenState extends State<ChatGptScreen> {
  TextEditingController textAi = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Map<String, dynamic>> messages = [];

  void _sendMessage(bool isSender, String mssg) async {
    await saveData(isSender, mssg);
    textAi.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> saveData(bool isSender, String msg) async {
    setState(() {
      messages.add({
        'msg': msg,
        'sender': isSender,
      });
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(messages);
    await prefs.setString('chat', jsonString);
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('chat');
    if (jsonString != null) {
      // Konversi JSON string kembali menjadi list map
      List<dynamic> jsonResponse = jsonDecode(jsonString);
      setState(() {
        messages = List<Map<String, dynamic>>.from(jsonResponse);
        print(messages);
      });
    }
  }

  Future<void> clearData() async {
    setState(() {
      messages.clear(); // Kosongkan list
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('chat'); // Hapus data dari Shared Preferences
  }

  @override
  void dispose() {
    textAi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ChatgptBloc chatgptB = context.read<ChatgptBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with AI'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(10.0),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    return Align(
                      alignment: message['sender']
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        decoration: BoxDecoration(
                          color: message['sender']
                              ? Colors.blueAccent
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: SelectableText(
                          message['msg'],
                          style: TextStyle(
                              color: message['sender']
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                    padding: EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () async {
                        clearData();
                      },
                      child: Icon(Icons.delete_sweep_rounded),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 1.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: BlocBuilder<ChatgptBloc, ChatgptState>(
                    bloc: chatgptB,
                    builder: (context, state) {
                      return TextField(
                        controller: textAi,
                        onChanged: (value) {
                          chatgptB.add(
                            ChatgptTextChanged(
                              isText: value.isNotEmpty,
                            ),
                          );
                        },
                        decoration: InputDecoration(
                          hintText: 'Cari disini...',
                          suffixIcon: state is ChatgptText
                              ? state.hasText
                                  ? GestureDetector(
                                      onTap: () {
                                        textAi.clear();
                                        chatgptB.add(
                                          const ChatgptTextChanged(
                                              isText: false),
                                        );
                                      },
                                      child: Icon(Icons.clear),
                                    )
                                  : null
                              : null,
                          border: const OutlineInputBorder(),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                BlocConsumer<ChatgptBloc, ChatgptState>(
                  bloc: chatgptB,
                  listener: (context, state) {
                    if (state is ChatgptLoaded) {
                      _sendMessage(false, state.text);
                    } else if (state is ChatgptError) {
                      _sendMessage(false, state.error);
                      print(state.error);
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () async {
                        if (textAi.text.isEmpty) {
                          return;
                        }
                        print(textAi.text);
                        chatgptB.add(ChatgptSend(textAi.text));
                        _sendMessage(true, textAi.text);
                      },
                      child: state is ChatgptLoading
                          ? const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            )
                          : const Icon(Icons.send, color: Colors.blueAccent),
                    );
                  },
                ),
                const SizedBox(
                  width: 5,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
