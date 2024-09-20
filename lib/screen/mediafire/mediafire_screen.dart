import 'package:app_downloader/bloc/mediafire/mediafire_bloc.dart';
import 'package:app_downloader/data/constans/color.dart';
import 'package:app_downloader/screen/mediafire/mediafire_detail_screen.dart';
import 'package:app_downloader/widgets/button_back.dart';
import 'package:app_downloader/widgets/logo_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediafireScreen extends StatefulWidget {
  const MediafireScreen({super.key});

  @override
  State<MediafireScreen> createState() => _MediafireScreenState();
}

class _MediafireScreenState extends State<MediafireScreen> {
  TextEditingController linkMediafire = TextEditingController();

  @override
  void dispose() {
    linkMediafire.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediafireBloc mediafireB = context.read<MediafireBloc>();
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
                    const LogoApps(img: 'assets/logo/mediafire-logo.png'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BlocBuilder<MediafireBloc, MediafireState>(
                          bloc: mediafireB,
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tidak bisa download format Jpg dan Png!',
                                  style: TextStyle(
                                    color: color3,
                                  ),
                                ),
                                TextField(
                                  controller: linkMediafire,
                                  onChanged: (value) {
                                    mediafireB.add(
                                      MediafireTextChanged(
                                          isText: value.isNotEmpty),
                                    );
                                  },
                                  style: TextStyle(
                                    color: color3,
                                  ),
                                  decoration: InputDecoration(
                                    suffixIcon: state is MediafireText
                                        ? state.hasText
                                            ? IconButton(
                                                color: color3,
                                                onPressed: () {
                                                  linkMediafire.clear();
                                                  mediafireB.add(
                                                    const MediafireTextChanged(
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
                                state is MediafireError
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
                        BlocConsumer<MediafireBloc, MediafireState>(
                          listener: (context, state) {
                            if (state is MediafireLoaded) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MediafireDetailScreen(
                                          mediafire: state.mediafire,
                                        )),
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
                                  if (linkMediafire.text.isEmpty) {
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
                                    mediafireB.add(
                                        FetchMediafire(linkMediafire.text));
                                  }
                                },
                                child: Text(
                                  state is MediafireLoading
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
