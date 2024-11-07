import 'dart:convert';

import 'package:protocol/protocol.dart';
import 'package:test/test.dart';

void main() {
  test('model ...', () async {
    
    final json = jsonEncode(MouseButtonProtocolData(type: ClickType.left));

    expect(json, "teste");
  });
}