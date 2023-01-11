
import 'package:flutter/material.dart';
import 'package:prastuti_23/config/appTheme.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/views/loading/shimmer_widget.dart';

import '../../animations/home_view_animation.dart';

class Events_view_skeleton extends StatefulWidget {
  const Events_view_skeleton({Key? key}) : super(key: key);

  @override
  State<Events_view_skeleton> createState() => _Events_view_skeletonState();
}

class _Events_view_skeletonState extends State<Events_view_skeleton> {


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    SizeConfig.init(context);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme().backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppTheme().backgroundColor.withOpacity(opacityAnimation.value),
          leading: Center(
            child: InkWell(
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                color: selectedAppTheme.isDarkMode?
                Colors.white:AppTheme().secondaryColor,
                size: 33,
                progress: drawerAnimationController.view,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 10, left: 0, right: 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left:30),
                          child: skeleton(40, 120)
                        ),
                      SizedBox(
                        height: 15,
                      ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 30),
                          child: skeleton(SizeConfig.heightPercent*25, SizeConfig.widthPercent*80),
                        ),
                        SizedBox(height: 10,),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.people_alt_rounded,
                                color: AppTheme().kSecondaryColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              skeleton(20, 40)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.sports_gymnastics_outlined,
                                color: AppTheme().kSecondaryColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              skeleton(20, 40)
                            ],
                          ),
                        ],
                      ),
          
                        Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                        ),
                        child: ExpansionTile(
                          title: Text(
                            "Timeline",
                            style: AppTheme()
                                .headText2
                                .copyWith(color: AppTheme().secondaryColor
                            ),
                          ),
                          children: [
                            skeleton(20, SizeConfig.widthPercent*70)
                          ],
                        ),
                      ),
                      Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: Text(
                            "Rules",
                            style: AppTheme()
                                .headText2
                                .copyWith(color: AppTheme().secondaryColor
                            ),
                          ),
                          children: [
                            skeleton(20, SizeConfig.widthPercent * 70)
                          ],
                        ),
                      ),
                      Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: Text(
                            "Rewards",
                            style: AppTheme()
                                .headText2
                                .copyWith(color: AppTheme().secondaryColor
                            ),
                          ),
                          children: [
                            skeleton(20, SizeConfig.widthPercent * 70)
                          ],
                        ),
                      )
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
                          SizeConfig.width - 30,
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}