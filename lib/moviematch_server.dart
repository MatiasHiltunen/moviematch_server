import 'dart:async';
import 'package:grpc/grpc.dart';
import 'generated/moviematch.pbgrpc.dart';

// Ready made code: https://github.com/MatiasHiltunen/moviematch_server

class MovieMatchService extends MovieMatchServiceBase {
  final Map<String, StreamController<StateMessage>> clients = {};
  final Map<String, List<String>> userValues = {};

  @override
  Stream<StateMessage> streamState(
    ServiceCall call,
    Stream<StateMessage> request,
  ) {
    final controller = StreamController<StateMessage>();
    String? currentUser;

    request.listen(
      (msg) {
        //print("Server listen, ${msg.user}: ${msg.data}");

        currentUser = msg.user;
        clients[msg.user] = controller;

        if (userValues.containsKey(msg.user)) {
          userValues[msg.user]?.add(msg.data);
        } else {
          userValues[msg.user] = [msg.data];
        }

        print("Current server in-memory db state: $userValues");

        for (var entry in userValues.entries) {
          if (entry.key != msg.user && entry.value.contains(msg.data)) {
            final matchMessage =
                StateMessage()
                  ..user = 'server'
                  ..data = msg.data;

            clients[entry.key]?.add(matchMessage);
            clients[msg.user]?.add(matchMessage);
          }
        }
      },
      onDone: () {
        if (currentUser != null) {
          clients.remove(currentUser);
          userValues.remove(currentUser);
        }
      },
    );

    return controller.stream;
  }
}
