import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CursorSettingsPage extends StatefulWidget {
  const CursorSettingsPage({
    super.key,
    required this.channel,
  });
  
  final WebSocketChannel channel;

  @override
  State<CursorSettingsPage> createState() => _CursorSettingsPageState();
}

class _CursorSettingsPageState extends State<CursorSettingsPage> {
  double sensibilidade = 0.5;

  @override
  Widget build(BuildContext context) {
    // TODO: Adicionar alterar sensibilidade.
    // TODO: Adicionar troca de layout dos botões.
    // TODO: Alterar cores dos botões
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          const ListTile(
            title: Text('Sensibilidade', style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          Slider(
            label: sensibilidade.toStringAsFixed(2),
            value: sensibilidade,
            min: 0.01,
            max: 1,
            onChanged: (v) {
              setState(() {
                sensibilidade = v;
              });
          
              var data = {"changeSensitivityEvent": v};
              widget.channel.sink.add(jsonEncode(data));
            },
          ),
        ],
      )),
    );
  }
}
/*

              RotatedBox(
                quarterTurns: -1,
                child: Slider(
                  label: sensibilidade.toStringAsFixed(2),
                  value: sensibilidade,
                  min: 0.01,
                  max: 1,
                  onChanged: (v) {
                    setState(() {
                      sensibilidade = v;
                    });

                    var data = {"changeSensitivityEvent": v};
                    widget.channel.sink.add(jsonEncode(data));
                  },
                ),
              ),
*/