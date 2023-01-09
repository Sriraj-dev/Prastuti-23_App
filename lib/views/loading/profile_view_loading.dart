import 'package:flutter/material.dart';
import 'package:prastuti_23/animations/home_view_animation.dart';
import 'package:prastuti_23/config/appTheme.dart';
import 'package:prastuti_23/config/image_paths.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/views/loading/shimmer_widget.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ProfileViewSceleton extends StatefulWidget {
  const ProfileViewSceleton({Key? key}) : super(key: key);

  @override
  State<ProfileViewSceleton> createState() => _ProfileViewSceletonState();
}

class _ProfileViewSceletonState extends State<ProfileViewSceleton> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme().primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppTheme().backgroundColor,
          body: NestedScrollView(
              headerSliverBuilder: ((context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: AppTheme().primaryColor,
                      expandedHeight: SizeConfig.heightPercent * 35,
                      leading: Center(
                        child: InkWell(
                          onTap: _onDrawerTapped,
                          child: AnimatedIcon(
                            icon: AnimatedIcons.menu_close,
                            color: Colors.white,
                            size: 33,
                            progress: drawerAnimationController.view,
                          ),
                        ),
                      ),
                      title: Text(
                        "Your Profile",
                        style: AppTheme().headText1.copyWith(fontSize: 20),
                      ),
                      stretch: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.person,
                                  color: Colors.grey.withOpacity(0.4),
                                  size: 100,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: AppTheme().kSecondaryColor,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      bottom: PreferredSize(
                        preferredSize:
                            Size.fromHeight(AppBar().preferredSize.height),
                        child: Container(
                          width: double.maxFinite,
                          color: AppTheme().backgroundColor,
                          child: Center(
                            child: TabBar(
                              isScrollable: true,
                              controller: _tabController,
                              tabs: const [
                                Tab(
                                  text: "Events",
                                ),
                                Tab(
                                  text: "Teams",
                                ),
                                Tab(
                                  text: "Requests",
                                ),
                              ],
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: MaterialIndicator(
                                color: AppTheme().kSecondaryColor,
                                height: 2,
                                topLeftRadius: 8,
                                topRightRadius: 8,
                                bottomLeftRadius: 8,
                                bottomRightRadius: 8,
                                tabPosition: TabPosition.bottom,
                              ),
                              labelColor: AppTheme().kSecondaryColor,
                              labelStyle: AppTheme().headText2.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                              unselectedLabelStyle: AppTheme()
                                  .headText2
                                  .copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                              unselectedLabelColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
              body: TabBarView(controller: _tabController, children: [
                buildLoadingList(),
                buildLoadingList(),
                buildLoadingList(),
                ]
              )
            ),
        ),
      ),
    );
  }

  Widget buildLoadingList(){
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: skeleton(SizeConfig.heightPercent*17, SizeConfig.widthPercent*65),
        );
      }
    );
  }

  void _onDrawerTapped() {
    if (drawerAnimationController.isCompleted) {
      drawerAnimationController.reverse();
    } else {
      drawerAnimationController.forward();
    }
  }
}