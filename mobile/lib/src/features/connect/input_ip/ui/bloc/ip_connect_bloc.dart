import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:controller/src/core/connect.dart';

class IPConnectEvent {}

class ConnectToIP extends IPConnectEvent {
  final String ip;
  final int port;

  ConnectToIP(this.ip, this.port);
}

class IPConnectState {}

class IPConnectInitial extends IPConnectState {}

class IPConnecting extends IPConnectState {}

class IPConnectSuccess extends IPConnectState {}

class IPConnectFailure extends IPConnectState {
  final String error;

  IPConnectFailure(this.error);
}

class IPConnectBloc extends Bloc<IPConnectEvent, IPConnectState> {
  IPConnectBloc() : super(IPConnectInitial()) {
    on<ConnectToIP>(_onConnectToIP);
  }

  Future<void> _onConnectToIP(
      ConnectToIP event, Emitter<IPConnectState> emit) async {
    emit(IPConnecting());
    try {
      // print ip and port
      print('IP: ${event.ip}, Port: ${event.port}');
      await connectWS(event.ip, event.port, (err) {
        throw Exception(err);
      });
      emit(IPConnectSuccess());
    } catch (e) {
      emit(IPConnectFailure(e.toString()));
    }
  }
}
