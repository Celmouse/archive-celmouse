import 'package:get_it/get_it.dart';
import 'package:controller/src/features/connect/input_ip/bloc/ip_connect_bloc.dart';

GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerFactory(() => IPConnectBloc());
}
