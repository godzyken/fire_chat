import 'package:fire_chat/core/models/game_model.dart';
import 'package:flutter/material.dart';

class GameWidget extends StatelessWidget {
  final GameModel gameModel;
  final String url;

  const GameWidget({@required this.gameModel, @required this.url});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 200,
        width: 200,
        child: Center(
          child: Text(
            gameModel.name,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
