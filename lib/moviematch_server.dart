import 'dart:async';

import 'package:grpc/grpc.dart';

import 'generated/moviematch.pbgrpc.dart';

class MovieMatchService extends MovieMatchServiceBase {
  final Map<String, StreamController<StateMessage>> clients = {};
  final Map<String, String> userValues = {};

  @override
  Stream<StateMessage> streamState(
    ServiceCall call,
    Stream<StateMessage> request,
  ) {
    final controller = StreamController<StateMessage>();
    String? currentUser;

    request.listen(
      (msg) {
        print("Server listen, ${msg.user}: ${msg.data}");

        currentUser = msg.user;
        clients[msg.user] = controller;
        userValues[msg.user] = msg.data;

        for (var entry in userValues.entries) {
          if (entry.key != msg.user && entry.value == msg.data) {
            final matchMessage =
                StateMessage()
                  ..user = 'server'
                  ..data = entry.value;

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
