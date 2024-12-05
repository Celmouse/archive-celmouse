import 'package:controller/src/features/connect/input_ip/bloc/ip_connect_bloc.dart';
import 'package:controller/src/features/mouse/move/ui/mouse_move_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class EnterHubIPTile extends StatefulWidget {
  final VoidCallback onConnectionSuccess;

  const EnterHubIPTile({super.key, required this.onConnectionSuccess});

  @override
  EnterHubIPTileState createState() => EnterHubIPTileState();
}

class EnterHubIPTileState extends State<EnterHubIPTile> {
  final TextEditingController ipController = TextEditingController();
  final List<int> ports = [6589, 8443, 7771];
  int selectedPort = 7771;

  @override
  Widget build(BuildContext context) {
    final ipConnectBloc = GetIt.instance<IPConnectBloc>();
    // Tests only
    // set ipController to ip
    // ipController.text = '192.168.1.13';
    return BlocProvider.value(
      value: ipConnectBloc,
      child: BlocListener<IPConnectBloc, IPConnectState>(
        listener: (context, state) {
          if (state is IPConnectSuccess) {
            widget.onConnectionSuccess();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MoveMousePage(),
              ),
            );
          } else if (state is IPConnectFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        child: Builder(
          builder: (context) {
            return ListTile(
              leading: const Icon(Icons.input),
              title: const Text('Enter HUB IP Manually'),
              subtitle: const Text('Connect to the HUB using its IP address'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Enter HUB IP'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: ipController,
                          decoration: const InputDecoration(
                            labelText: 'HUB IP',
                            hintText: '192.168.0.1',
                          ),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<int>(
                          value: selectedPort,
                          decoration: const InputDecoration(
                            labelText: 'Select Port',
                          ),
                          items: ports.map((int port) {
                            return DropdownMenuItem<int>(
                              value: port,
                              child: Text(port.toString()),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedPort = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          ipConnectBloc.add(
                            ConnectToIP(ipController.text, selectedPort),
                          );
                        },
                        child: const Text('Connect'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
