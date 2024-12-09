import 'package:controller/src/data/services/connection_service.dart';
import 'package:controller/src/utils/result.dart';

class ConnectionRepository {
  final ConnectionService _connectionService;

  ConnectionRepository({
    required ConnectionService connectionService,
  }) : _connectionService = connectionService;

  Future<Result<void>> connect(String ip) async {
    // We are using port 7771 por now, so no need to pass it as a parameter
    try {
      await _connectionService.connect(ip, 7771);
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
