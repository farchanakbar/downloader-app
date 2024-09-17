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
  late ScrollController scrollController;
  List<Map<String, dynamic>> messages = [];

  void sendMessage(bool isSender, String mssg) async {
    await saveData(isSender, mssg);
    textAi.clear();
  }

  Future<void> saveData(bool isSender, String msg) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      messages.add({
        'sender': isSender,
        'msg': msg,
      });
    });

    String jsonString = jsonEncode(messages);
    await prefs.setString('chat', jsonString);
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('chat');
    if (jsonString != null) {
      List<dynamic> jsonResponse = jsonDecode(jsonString);
      setState(() {
        messages = List<Map<String, dynamic>>.from(jsonResponse);
      });
    }
  }

  Future<void> clearChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('chat');
    setState(() {
      messages.clear();
    });
  }

  @override
  void initState() {
    scrollController = ScrollController();
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    textAi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Scafold');
    ChatgptBloc chatgptB = context.read<ChatgptBloc>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with AI'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              clearChat();
            },
            child: Text('Hapus chat'),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
                          color:
                              message['sender'] ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
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
                        enabled: state is ChatgptLoading ? false : true,
                        controller: textAi,
                        onChanged: (value) {
                          chatgptB.add(
                            ChatgptTextChanged(
                              value.isNotEmpty,
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
                                          const ChatgptTextChanged(false),
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
                      sendMessage(false, state.text);
                    } else if (state is ChatgptError) {
                      sendMessage(false, state.error);
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () async {
                        if (textAi.text.isEmpty) {
                          return;
                        }
                        chatgptB.add(ChatgptSend(textAi.text));
                        sendMessage(true, textAi.text);
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
