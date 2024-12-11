class ProtocolEvent {
  static const none = ProtocolEvent('none');

  const ProtocolEvent(this._event);

  final String _event;

  String toJson() => _event;

  ProtocolEvent.fromJson(String json) : _event = json;
}
