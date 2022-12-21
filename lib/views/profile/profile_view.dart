import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prastuti_23/animations/home_view_animation.dart';
import 'package:prastuti_23/config/color_palette.dart';
import 'package:prastuti_23/config/image_paths.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/views/profile/profile_view_content.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';


class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with TickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme().secondaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppTheme().backgroundColor,
          body: NestedScrollView(
            headerSliverBuilder: ((context, innerBoxIsScrolled)=>[
              SliverAppBar(
                pinned: true,
                backgroundColor: AppTheme().secondaryColor,
                expandedHeight: SizeConfig.heightPercent*35,
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
                title: Text("Your Profile"),
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: [
                    StretchMode.zoomBackground
                  ],
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage("assets/temp_pic.jpg"),
                          ),
      
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Sriraj",
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              Text("palakurthi.sriraj.eee20@itbhu.ac.in",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              Text("IIT BHU Varanasi",
                                style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.white,
                                ),
                              ),
                              Text("+91 8074821478",
                                style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(AppBar().preferredSize.height),
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
                        //labelPadding: const EdgeInsets.only(right: 23),
                        
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorPadding: const EdgeInsets.symmetric(horizontal: 4),
                        indicator: MaterialIndicator(
                          color: AppTheme().primaryColor,
                          height: 4,
                          topLeftRadius: 8,
                          topRightRadius: 8,
                          bottomLeftRadius: 8,
                          bottomRightRadius: 8,
                          tabPosition: TabPosition.bottom,
                        ),
                        labelColor: AppTheme().primaryColor,
                        unselectedLabelColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            ]),
            body: TabBarView(
              controller: _tabController,
              children: [
                buildList(events),
                buildList(teams),
                buildList(requests)
              ]
            )
          ),
        ),
      ),
    );
  }

  Widget buildList(List<String> list) {

    if(list.isEmpty){
      return const Center(
        child: Text("You have no pending requests"),
      );
    }

    return ListView.separated(
          itemBuilder: (context,index){
            return ListTile(
              title: Text(list[index]),
            );
          },
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) =>Center(
            child: Container(
              height: 0,
              width: SizeConfig.widthPercent*90,
              color: Colors.grey,
            )
          ),
          itemCount: list.length,
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