

//This is a temporary file ...
//Events model need to be created in models folder ..and then work on them

import 'package:flutter/cupertino.dart';
import 'package:prastuti_23/config/color_palette.dart';
import 'package:prastuti_23/config/image_paths.dart';

List<String> event_images = [
  ImagePaths.codigo,
  ImagePaths.consilium,
  ImagePaths.cryptex,
  ImagePaths.hackathon,
  ImagePaths.recognizance,
  ImagePaths.simulim,
  ImagePaths.temp_pic
];

List<String> titles = [
  "CODIGO",
  "CONSILIUM",
  "HACKOVERFLOW",
  "RECOGNIZANCE",
  "SIMULIM",
  "OSCILLION"
];

List<String> desc = [
  "It is a competitive programming event that involves the application of various data structure and algorithms to check participants' problem solving skills.",
  "Digital electronics based event, introduces Electronic design to students comprising experimentation, design, modelling, simulation and analysis of ingle devices or circuits.",
  "To provide a headstart in web development by introducing HTML,CSS, Javascript and the most used frontend framework ReactJs.",
  "This event focuses on machine learning and data to build robust solutions in the electrical domain.",
  " Based on the field of Power Electronics, the event introduces participants to MATLAB and Simulink to develop understanding of core concepts",
  "The event aims to introduce the participants to the world of analog Electronics and the systems it helps us create to interact with the real world."
];

List<List<Map<String,dynamic>>> timeLines = [
  [
    {
      "title" : "Workshop 1",
      "date": "Jan 15",
      "slot": "5:00 - 6:00pm",
      "isCompleted" : true,
    },
    {
      "title": "Workshop 2",
      "date": "Jan 20",
      "slot": "5:00 - 6:00pm",
      "isCompleted": true,
    },
    {
      "title": "Workshop 3",
      "date": "Jan 25",
      "slot": "5:00 - 6:00pm",
      "isCompleted": true,
    },
    {
      "title": "Problem Statement",
      "date": "Jan 27",
      "slot": "5:00 - 6:00pm",
      "isCompleted": false,
    },
    {
      "title": "Evaluation",
      "date": "Feb 1",
      "slot": "",
      "isCompleted": false,
    },
    {
      "title": "Results",
      "date": "Feb 4",
      "slot": "",
      "isCompleted": false,
    }
  ],
  [
    {
      "title": "Workshop 1",
      "date": "Jan 15",
      "slot": "8:00 - 9:00pm",
      "isCompleted": true,
    },
    {
      "title": "Workshop 2",
      "date": "Jan 20",
      "slot": "5:00 - 6:00pm",
      "isCompleted": false,
    },
    {
      "title": "Problem Statement",
      "date": "Jan 27",
      "slot": "5:00 - 6:00pm",
      "isCompleted": false,
    },
    {
      "title": "Evaluation",
      "date": "Feb 1",
      "slot": "",
      "isCompleted": false,
    },
    {
      "title": "Results",
      "date": "Feb 4",
      "slot": "",
      "isCompleted": false,
    }
  ],
  [],
  [],
  [],
  [],
];


