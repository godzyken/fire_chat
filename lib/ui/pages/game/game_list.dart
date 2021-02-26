import 'package:fire_chat/core/api/api.dart';
import 'package:fire_chat/core/models/models.dart';
import 'package:fire_chat/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GameList extends StatefulWidget {
  @override
  _GameListState createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  int selectedCard = -1;

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );

  @override
  Widget build(BuildContext context) => StreamBuilder<List<GameModel>>(
      stream: FirebaseApi.getGameModels(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return buildText('Something Went Wrong Tru Later');
            } else {
              final games = snapshot.data;

              return games.isBlank
                  ? Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        title: Text('Game List'),
                        backwardsCompatibility: true,
                        actions: [
                          IconButton(
                            icon: Icon(Icons.home_sharp),
                            tooltip: 'Back to home',
                            onPressed: () => Get.off(() => HomeUI()),
                          ),
                        ],
                      ),
                      body: Container(
                          child: GridView.builder(
                            shrinkWrap: false,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.length,
                            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: MediaQuery.of(context).size.width /
                                  (MediaQuery.of(context).size.height / 3)),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCard = index;
                                  });
                                },
                                child: GameWidget(url: snapshot.data[index].url, gameModel: snapshot.data[index],),
                              );
                            },
                      )))
                  : Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        title: Text('Game List'),
                        backwardsCompatibility: true,
                        actions: [
                          IconButton(
                            icon: Icon(Icons.home_sharp),
                            tooltip: 'Back to home',
                            onPressed: () => Get.off(() => HomeUI()),
                          ),
                        ],
                      ),
                      body: Container(
                          child: GridView.builder(
                        shrinkWrap: false,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 3),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCard = index;
                              });
                            },
                            child: FutureBuilder<GameModel>(
                              builder: (context, snapshot) {
                                return GameWidget(
                                    gameModel: snapshot.data,
                                    url: snapshot.data.url);
                              },
                            ),
                          );
                        },
                      )),
                    );
            }
        }
      });
}
