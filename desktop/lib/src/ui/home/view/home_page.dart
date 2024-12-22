import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:server/src/ui/home/viewmodel/home_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.viewmodel,
  });

  final HomeViewmodel viewmodel;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WebSocket? socket;

  @override
  void initState() {
    super.initState();
    widget.viewmodel.init();
    widget.viewmodel.errorMessage.addListener(_errorListener);
  }

  @override
  void dispose() {
    widget.viewmodel.errorMessage.removeListener(_errorListener);
    widget.viewmodel.dispose();
    super.dispose();
  }

  _errorListener() {
    final errorMessage = widget.viewmodel.errorMessage.value;
    if (errorMessage == null) return;
    if (errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Celmouse",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              launchUrl(
                Uri.parse("https://api.whatsapp.com/send?phone=5533997312898"),
              );
            },
            icon: const Icon(
              Icons.support_agent,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () {
              launchUrl(
                Uri.parse("https://celmouse.com"),
              );
            },
            icon: const Icon(
              Icons.code_sharp,
            ),
          )
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 12),
        child: ListenableBuilder(
            listenable: widget.viewmodel.connected,
            builder: (context, _) {
              return AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: widget.viewmodel.connected.value
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.circle,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Text(
                              "Connected",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListenableBuilder(
                                listenable: widget.viewmodel.availableIPS,
                                builder: (context, _) {
                                  final availableIPS =
                                      widget.viewmodel.availableIPS.value;


                                  return ListView.builder(
                                    itemCount: availableIPS.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Card(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'IP Address: ${availableIPS[index]}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              const SizedBox(height: 8.0),
                                              Center(
                                                child: QrImageView(
                                                  data: availableIPS[index],
                                                  version: QrVersions.auto,
                                                  size: 160.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }),
                            const SizedBox(
                              height: 200,
                            ),
                          ],
                        ),
                      ),
              );
            }),
      ),
    );
  }
}
