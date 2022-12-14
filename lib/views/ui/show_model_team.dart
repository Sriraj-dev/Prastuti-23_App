import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../config/appTheme.dart';
import '../../config/screen_config.dart';
import '../profile/profile_view_content.dart';

class ShowModelTeams extends StatefulWidget {
  const ShowModelTeams({Key? key}) : super(key: key);

  @override
  State<ShowModelTeams> createState() => _ShowModelTeamsState();
}

class _ShowModelTeamsState extends State<ShowModelTeams> {
  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return Center(
        child: Text(
          "Create a team first",
          style: TextStyle(
            color: selectedAppTheme.isDarkMode?
            Colors.white:Colors.black
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
          color: selectedAppTheme.isDarkMode?
          Colors.black.withOpacity(0.5):Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(27), topRight: Radius.circular(27))
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 10,
            child: Column(
              children: [
                Container(
                  height: 5,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4), color: Colors.grey),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Select a Team to register",
                  style: AppTheme().headText1.copyWith(
                      fontSize: 16,
                      color: selectedAppTheme.isDarkMode?
                      Colors.white:Colors.black,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 27),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return EventsTeamsWidget(requests[index]);
              },
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => Center(
                  child: Container(
                    height: 0,
                    width: SizeConfig.widthPercent * 90,
                    color: Colors.grey,
                  )),
              itemCount: requests.length,
            ),
          )
        ],
      ),
    );
  }

  Widget EventsTeamsWidget(String teamName) {
    // final bool isStretched = isAnimating || state == ButtonState.init;
    // final bool isDone = state == ButtonState.done;
    return Container(
        margin: EdgeInsets.fromLTRB(30, 20, 30, 10),
        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme().secondaryColorLight,
            boxShadow: [
              BoxShadow(
                  color: AppTheme().primaryColor.withOpacity(0.3),
                  blurRadius: 4.0,
                  spreadRadius: 3.0,
                  offset: Offset(4, 4))
            ]),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          AutoSizeText(
            teamName,
            style: AppTheme().headText1.copyWith(
                color: selectedAppTheme.isDarkMode?
                Colors.white:Colors.black,
                fontWeight: FontWeight.w500, fontSize: 22),
          ),
          AcceptButton()
        ]));
  }

  Widget AcceptButton() {
    return ElevatedButton(
      onPressed: () async {
        // isPressed = !isPressed;
        // setState(() => state = ButtonState.loading);
        // await Future.delayed(Duration(seconds: 3));
        // setState(() => state = ButtonState.done);
        print("hello lmao dead");
      },
      child: FittedBox(
        child: AutoSizeText(
          'Join',
          style: AppTheme().headText2.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        backgroundColor: AppTheme().secondaryColor,
        shadowColor: AppTheme().primaryColor,
        elevation: 5,
        fixedSize: Size(80, 30),
      ),
    );
  }

  Widget LoadingTick(bool isDone) {
    final color = isDone ? Colors.green[800] : AppTheme().primaryColor;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: isDone
            ? Icon(
          Icons.done,
          size: 30,
          color: Colors.white,
        )
            : CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
