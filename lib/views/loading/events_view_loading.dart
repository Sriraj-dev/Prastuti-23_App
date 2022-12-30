
import 'package:flutter/material.dart';
import 'package:prastuti_23/config/color_palette.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/views/loading/shimmer_widget.dart';

class Events_view_skeleton extends StatefulWidget {
  const Events_view_skeleton({Key? key}) : super(key: key);

  @override
  State<Events_view_skeleton> createState() => _Events_view_skeletonState();
}

class _Events_view_skeletonState extends State<Events_view_skeleton> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme().backgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 00, top: 0, left: 0, right: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left:30),
                        child: skeleton(40, 60)
                      ),
                    SizedBox(
                      height: 15,
                    ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 30),
                        child: skeleton(SizeConfig.heightPercent*40, SizeConfig.widthPercent*75),
                      ),
                  ],
                ),
              ),
              Container(
                height: SizeConfig.heightPercent * 25,
                child: PageView.builder(
                    controller: PageController(viewportFraction: 0.88),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return skeleton(
                        SizeConfig.heightPercent * 25,
                        SizeConfig.width - 20,
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}