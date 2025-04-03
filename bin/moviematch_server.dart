import 'package:grpc/grpc.dart';
import 'package:moviematch_server/moviematch_server.dart';

Future<void> main() async {
  final server = Server.create(services: [MovieMatchService()]);

  final port = 50051;

  await server.serve(port: port);

  print('MovieMatch gRPC server running on port $port');
}
