

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
  "CRYPTEX",
  "HACKATHON",
  "RECOGNIZANCE",
  "SIMULIM",
  "OSCILLION"
];

List<String> desc = [
  "A competitive programming event that involves the application of various data structure and algorithms to check participants' problem solving skills.",
  "Consilium involves introduction to digital electronics from basics of Boolean algebra to FSM designing and optimisation for max efficiency.",
  "This is cryptex event",
  "This is a hackathon event",
  "This event focuses on machine learning and data to build robust solutions in the electrical domaim",
  "Based on the field of Power Electronics, the event introduces participants to MATLAB and Simulink to develop understanding of core concepts",
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
  [],
  [],
  [],
  [],
  [],
  []
];


