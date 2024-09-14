import 'package:app_downloader/bloc/gdrive/gdrive_bloc.dart';
import 'package:app_downloader/screen/gdrive/gdrive_detail_screen.dart';
import 'package:app_downloader/widgets/button_back.dart';
import 'package:app_downloader/widgets/logo_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GdriveScreen extends StatefulWidget {
  const GdriveScreen({super.key});

  @override
  State<GdriveScreen> createState() => _GdriveScreenState();
}

class _GdriveScreenState extends State<GdriveScreen> {
  TextEditingController linkGdrive = TextEditingController();

  @override
  void dispose() {
    linkGdrive.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GdriveBloc gdriveB = context.read<GdriveBloc>();
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
                    const LogoApps(img: 'assets/logo/gdrive-logo.png'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BlocBuilder<GdriveBloc, GdriveState>(
                          bloc: gdriveB,
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: linkGdrive,
                                  onChanged: (value) {
                                    gdriveB.add(
                                      GdriveTextChanged(
                                          isText: value.isNotEmpty),
                                    );
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: state is GdriveText
                                        ? state.hasText
                                            ? IconButton(
                                                onPressed: () {
                                                  linkGdrive.clear();
                                                  gdriveB.add(
                                                    const GdriveTextChanged(
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
                                state is GdriveError
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
                        BlocConsumer<GdriveBloc, GdriveState>(
                          listener: (context, state) {
                            if (state is GdriveLoaded) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GdriveDetailScreen(
                                    gdrive: state.googleDrive,
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
                                  if (linkGdrive.text.isEmpty) {
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
                                    gdriveB.add(FetchGdrive(linkGdrive.text));
                                  }
                                },
                                child: Text(
                                  state is GdriveLoading
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
