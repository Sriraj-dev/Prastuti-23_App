import 'package:flutter/material.dart';
import 'package:prastuti_23/config/appTheme.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/models/eventListModel.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Event_Timeline extends StatelessWidget {

  List<Timeline> timelines;
  Event_Timeline({Key? key,required this.timelines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (timelines.length==0)?Center(
      child: Text("Timeline of this event will be released soon!!",
        style: AppTheme().headText2.copyWith(
          color: selectedAppTheme.isDarkMode?
          Colors.white:AppTheme().secondaryColor
        ),
      ),
    ):
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for(int i=0;i<timelines.length;i++)
         _subEvent(timelines[i],i==0, i==timelines.length-1)
      ],
    );
  }

  Widget _subEvent(Timeline eventDetail,bool isFirst,bool isLast){
    return Row(
      children: [
        Container(
          height: 80,
          width: 20,
          child: TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0,
            isFirst: isFirst,
            isLast: isLast,
            indicatorStyle: IndicatorStyle(
              indicatorXY: 0,
              width: 15,
              indicator: Container(
                decoration: BoxDecoration(
                  color: selectedAppTheme.isDarkMode?
                  AppTheme().backgroundColor_Dark:AppTheme().backgroundColor,
                  shape: BoxShape.circle,
                  border: Border.all(width: 5,
                  color:  eventDetail.isCompleted!
                              ? selectedAppTheme.isDarkMode?
                  AppTheme().kSecondaryColor_Dark:AppTheme().kSecondaryColor
                              : Colors.grey
                  )
                ),
              )
            ),
            afterLineStyle: LineStyle(
              thickness: 2,
              color: eventDetail.isCompleted!
                    ? selectedAppTheme.isDarkMode?
              AppTheme().kSecondaryColor_Dark:AppTheme().kSecondaryColor
                    : Colors.grey
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(eventDetail.date??"",
                style: AppTheme().headText2.copyWith(
                  color: selectedAppTheme.isDarkMode?
                  Colors.white:Colors.black
                ),
              ),
              _buildCard(eventDetail)
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCard(Timeline eventDetail){
    return Container(
      width: SizeConfig.widthPercent*50,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(13).copyWith(topLeft: const Radius.circular(0)),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(eventDetail.title??"",
            style: AppTheme().headText1.copyWith(
              color: selectedAppTheme.isDarkMode?
              Colors.white:Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16
            ),
          ),
          SizedBox(height: 10,),
          Text(
            eventDetail.slot??"",
            style: AppTheme().headText2.copyWith(
                color: selectedAppTheme.isDarkMode?
                Colors.white:Colors.grey[700], fontSize: 14),
          )
        ],
      ),
    );
  }
}