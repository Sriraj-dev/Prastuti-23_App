
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prastuti_23/config/color_palette.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Event_Timeline extends StatelessWidget {

  List<Map<String,dynamic>> timeline;
  Event_Timeline({Key? key,required this.timeline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (timeline.length==0)?Center(
      child: Text("Timeline of this event will be released soon!!",
        style: AppTheme().headText2.copyWith(
          color: AppTheme().secondaryColor
        ),
      ),
    ):
    // ListView.builder(
    //   physics: const BouncingScrollPhysics(),
    //   itemBuilder: (context,index){
    //     return _subEvent(timeline[index],index==0,index == timeline.length-1);
    //   },
    //   itemCount: timeline.length,
    // );
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for(int i=0;i<timeline.length;i++)
         _subEvent(timeline[i],i==0, i==timeline.length-1)
      ],
    );
  }

  Widget _subEvent(Map<String,dynamic> eventDetail,bool isFirst,bool isLast){
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
                  color: AppTheme().backgroundColor,
                  shape: BoxShape.circle,
                  border: Border.all(width: 5,
                  color:  eventDetail["isCompleted"]
                              ? AppTheme().kSecondaryColor
                              : Colors.grey
                  )
                ),
              )
            ),
            afterLineStyle: LineStyle(
              thickness: 2,
              color: eventDetail["isCompleted"]
                    ? AppTheme().kSecondaryColor
                    : Colors.grey
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(eventDetail['date'],
                style: AppTheme().headText2.copyWith(
                  color: Colors.black
                ),
              ),
              _buildCard(eventDetail)
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCard(eventDetail){
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
          Text(eventDetail['title'],
            style: AppTheme().headText1.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16
            ),
          ),
          SizedBox(height: 10,),
          Text(
            eventDetail['slot'],
            style: AppTheme().headText2.copyWith(
                color: Colors.black, fontSize: 14),
          )
        ],
      ),
    );
  }
}