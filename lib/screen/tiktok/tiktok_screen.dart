import 'package:app_downloader/bloc/tiktok/tiktok_bloc.dart';
import 'package:app_downloader/screen/tiktok/tiktok_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TiktokScreen extends StatelessWidget {
  const TiktokScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController linkTiktok = TextEditingController();

    void showErrorDialog(BuildContext context, String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Terjadi Kesalahan'),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Image.asset(
                'assets/logo/tiktok-logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              TextField(
                controller: linkTiktok,
                decoration: const InputDecoration(
                  hintText: 'Salin Link',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocConsumer<TiktokBloc, TiktokState>(
                listener: (context, state) {
                  if (state is TiktokError) {
                    showErrorDialog(context, state.error);
                  } else if (state is TiktokLoaded) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TiktokDetailScreen(
                          tiktok: state.tiktok,
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        if (linkTiktok.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(
                                milliseconds: 500,
                              ),
                              content: Center(
                                child: Text('Link tidak boleh kosong'),
                              ),
                            ),
                          );
                        } else {
                          context
                              .read<TiktokBloc>()
                              .add(FetchTiktok(linkTiktok.text));
                        }
                      },
                      child: Text(
                        state is TiktokLoading ? 'Loading...' : 'Download',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    ));
  }
}
