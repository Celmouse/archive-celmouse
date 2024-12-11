class ProtocolEvent {
  static const none = ProtocolEvent('none');

  const ProtocolEvent(this.name);

  final String name;

  String toJson() => name;

  ProtocolEvent.fromJson(String json) : name = json;

}
