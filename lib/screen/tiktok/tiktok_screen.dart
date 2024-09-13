import 'package:app_downloader/screen/tiktok/tiktok_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tiktok/tiktok_bloc.dart';

class TiktokScreen extends StatefulWidget {
  const TiktokScreen({super.key});

  @override
  State<TiktokScreen> createState() => _TiktokScreenState();
}

class _TiktokScreenState extends State<TiktokScreen> {
  TextEditingController linkTiktok = TextEditingController();

  @override
  void dispose() {
    linkTiktok.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TiktokBloc tiktokB = context.read<TiktokBloc>();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Row(
                children: [
                  Icon(Icons.arrow_back_ios_new_rounded),
                  Text('Kembali')
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Image.asset(
                        'assets/logo/tiktok-logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BlocBuilder<TiktokBloc, TiktokState>(
                        bloc: tiktokB,
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: linkTiktok,
                                onChanged: (value) {
                                  tiktokB.add(
                                      TextChanged(isText: value.isNotEmpty));
                                },
                                decoration: InputDecoration(
                                  suffixIcon: state is TiktokText
                                      ? state.hasText
                                          ? IconButton(
                                              onPressed: () {
                                                linkTiktok.clear();
                                                tiktokB.add(const TextChanged(
                                                    isText: false));
                                              },
                                              icon: const Icon(Icons.clear))
                                          : null
                                      : null,
                                  border: const OutlineInputBorder(),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                ),
                              ),
                              state is TiktokError
                                  ? Text(
                                      state.error,
                                      style: const TextStyle(
                                        color: Colors.red,
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocConsumer<TiktokBloc, TiktokState>(
                        listener: (context, state) {
                          if (state is TiktokLoaded) {
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
                                  tiktokB.add(FetchTiktok(linkTiktok.text));
                                }
                              },
                              child: Text(
                                state is TiktokLoading
                                    ? 'Loading...'
                                    : 'Download',
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
            )
          ],
        ),
      ),
    ));
  }
}
