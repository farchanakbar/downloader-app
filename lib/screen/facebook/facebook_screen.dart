import 'package:app_downloader/bloc/facebook/facebook_bloc.dart';
import 'package:app_downloader/screen/facebook/facebook_detail_screen.dart';
import 'package:app_downloader/widgets/button_back.dart';
import 'package:app_downloader/widgets/logo_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FacebookScreen extends StatefulWidget {
  const FacebookScreen({super.key});

  @override
  State<FacebookScreen> createState() => _FacebookScreenState();
}

class _FacebookScreenState extends State<FacebookScreen> {
  TextEditingController linkFacebook = TextEditingController();

  @override
  void dispose() {
    linkFacebook.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FacebookBloc facebookB = context.read<FacebookBloc>();
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
                    const LogoApps(img: 'assets/logo/facebook-logo.png'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BlocBuilder<FacebookBloc, FacebookState>(
                          bloc: facebookB,
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hanya bisa download video!'),
                                TextField(
                                  controller: linkFacebook,
                                  onChanged: (value) {
                                    facebookB.add(
                                      FacebookTextChanged(
                                          isText: value.isNotEmpty),
                                    );
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: state is FacebookText
                                        ? state.hasText
                                            ? IconButton(
                                                onPressed: () {
                                                  linkFacebook.clear();
                                                  facebookB.add(
                                                    const FacebookTextChanged(
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
                                state is FacebookError
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
                        BlocConsumer<FacebookBloc, FacebookState>(
                          listener: (context, state) {
                            if (state is FacebookLoaded) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FacebookDetailScreen(
                                    facebookReels: state.facebook,
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
                                  if (linkFacebook.text.isEmpty) {
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
                                    facebookB
                                        .add(FetchFacebook(linkFacebook.text));
                                  }
                                },
                                child: Text(
                                  state is FacebookLoading
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
