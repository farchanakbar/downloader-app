import 'package:app_downloader/data/constans/color.dart';
import 'package:app_downloader/screen/tiktok/tiktok_detail_screen.dart';
import 'package:app_downloader/widgets/button_back.dart';
import 'package:app_downloader/widgets/logo_app.dart';
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
      backgroundColor: color1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const ButtonBack(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const LogoApps(img: 'assets/logo/tiktok-logo.png'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BlocBuilder<TiktokBloc, TiktokState>(
                          bloc: tiktokB,
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hanya bisa download video!',
                                  style: TextStyle(
                                    color: color3,
                                  ),
                                ),
                                TextField(
                                  controller: linkTiktok,
                                  onChanged: (value) {
                                    tiktokB.add(
                                      TiktokTextChanged(
                                          isText: value.isNotEmpty),
                                    );
                                  },
                                  style: TextStyle(color: color3),
                                  decoration: InputDecoration(
                                    suffixIcon: state is TiktokText
                                        ? state.hasText
                                            ? IconButton(
                                                onPressed: () {
                                                  linkTiktok.clear();
                                                  tiktokB.add(
                                                    const TiktokTextChanged(
                                                        isText: false),
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.clear,
                                                  color: color3,
                                                ),
                                              )
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
                                          child:
                                              Text('Link tidak boleh kosong'),
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
