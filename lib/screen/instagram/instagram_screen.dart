import 'package:app_downloader/bloc/instagram/instagram_bloc.dart';
import 'package:app_downloader/screen/instagram/instagram_detail_screen.dart';
import 'package:app_downloader/widgets/button_back.dart';
import 'package:app_downloader/widgets/logo_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstagramScreen extends StatefulWidget {
  const InstagramScreen({super.key});

  @override
  State<InstagramScreen> createState() => _InstagramScreenState();
}

class _InstagramScreenState extends State<InstagramScreen> {
  TextEditingController linkInstagram = TextEditingController();

  @override
  void dispose() {
    linkInstagram.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InstagramBloc instagramB = context.read<InstagramBloc>();
    return Scaffold(
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
                    const LogoApps(img: 'assets/logo/instagram-logo.png'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BlocBuilder<InstagramBloc, InstagramState>(
                          bloc: instagramB,
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hanya bisa download video!'),
                                TextField(
                                  controller: linkInstagram,
                                  onChanged: (value) {
                                    instagramB.add(
                                      InstagramTextChanged(
                                          isText: value.isNotEmpty),
                                    );
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: state is InstagramText
                                        ? state.hasText
                                            ? IconButton(
                                                onPressed: () {
                                                  linkInstagram.clear();
                                                  instagramB.add(
                                                    const InstagramTextChanged(
                                                        isText: false),
                                                  );
                                                },
                                                icon: const Icon(Icons.clear),
                                              )
                                            : null
                                        : null,
                                    border: const OutlineInputBorder(),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                  ),
                                ),
                                state is InstagramError
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
                        BlocConsumer<InstagramBloc, InstagramState>(
                          listener: (context, state) {
                            if (state is InstagramLoaded) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InstagramDetailScreen(
                                    instagram: state.instagram,
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
                                  if (linkInstagram.text.isEmpty) {
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
                                    instagramB.add(
                                        FetchInstagram(linkInstagram.text));
                                  }
                                },
                                child: Text(
                                  state is InstagramLoading
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
