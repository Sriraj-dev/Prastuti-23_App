

import 'dart:core';

import 'package:prastuti_23/config/appTheme.dart';


class ImagePaths{

  // Suffix "dark/light" after name is to indicate app theme in which it is to be used

  //TODO: Add All the Image Paths Here and Use them in the Code - Yash
  static const  prastuti_logo = "assets/prastuti_logo.png";
  static const google_logo = "assets/login_view/google.png";
  static const google_logo_grey = "assets/login_view/google_grey.png";
  static const prastuti_logo_1 = "assets/login_view/prastuti'23_logo_1.png";
  static const temp_pic = "assets/temp_pic.jpg";

  //login view content
  static const about_us = "assets/login_view/about_us.png";
  static const awards = "assets/login_view/awards.png";
  static const events = "assets/login_view/events.png";

  //events view content
  static const codigo = "assets/events_view/codigo.jpg";
  static const consilium = "assets/events_view/consilium.jpg";
  static const cryptex = "assets/events_view/cryptex.jpg";
  static const hackathon = "assets/events_view/hackathon.jpg";
  static const recognizance = "assets/events_view/recognizance.jpg";
  static const simulim = "assets/events_view/simulim.jpg";
  static const calender = "assets/profile_view/calendar.png";

  //profile_view
  static const score = "assets/profile_view/score.png";
  static const add = "assets/profile_view/add.png";
  static const calendar = "assets/profile_view/calendar.png";
  static const profile_pic = "assets/profile_view/profile_pic.png";
  static String cancel = selectedAppTheme.isDarkMode?
  "assets/profile_view/cancel_dark.png":"assets/profile_view/cancel_light.png";

  //convenors
  static const co_convenor_1 = "assets/contact_us/co_convenor_1.jpg";
  static const convenor = "assets/contact_us/convenor.jpg";
  static const co_convenor_2 = "assets/contact_us/co_convenor_2.jpg";

  //event_heads
  static const codigo_image = "assets/contact_us/event_heads/ASHWANI_Codigo.jpg";
  static const simulim_image = "assets/contact_us/event_heads/Astitva_Gupta.jpg";
  static const recognizance_image = "assets/contact_us/event_heads/Vidit.png";
  static const consilium_image = "assets/contact_us/event_heads/Ayush Pal.jpg";
  static const hackoverflow_image = "assets/contact_us/event_heads/Nilay Mundra.jpg";
  static const WhatsApp = "assets/events_view/whatsapp.png";

  //team_leads
  static const app = "assets/contact_us/team_leads/Sriraj_app.jpg";
  static const web = "assets/contact_us/team_leads/Sumant Chaudhary_web.jpg";
  static const finance_2 = "assets/contact_us/team_leads/Harsh Verma_finance.jpg";
  static const social = "assets/contact_us/team_leads/Smriti Jain_media.jpg";
  static const design = "assets/contact_us/team_leads/Alluru Sai Rushitha_design.jpg";
  static const content = "assets/contact_us/team_leads/Kunal Yewale_content.jpg";
  static const marketing = "assets/contact_us/team_leads/Yash_Varshney_marketing.jpg";
  static const pr = "assets/contact_us/team_leads/Krishanpal Dudi_pr.jpg";
  static const video = "assets/contact_us/team_leads/Utkarsh_video.jpg";
  static const finance_1 = "assets/contact_us/team_leads/Harsh Goyal_finance.jpg";
  static const events_head = "assets/contact_us/team_leads/Akshit Sharma_events.jpg";

  //about_us
  static const instagram_squared = "assets/about_us/instagram.png";
  static const linkedin_squared = "assets/about_us/linkedin.png";
  static const prastuti_logo_squared = "assets/about_us/prastuti_logo.png";
  static const gmail_squared = "assets/about_us/gmail.png";
  static const github_squared = "assets/about_us/github.png";
  static String bulb = selectedAppTheme.isDarkMode?
  "assets/about_us/bulb_dark.png":"assets/about_us/bulb_light.png";

  //registration:
  static String male_icon = selectedAppTheme.isDarkMode?
  "assets/registrationForm/male_dark.png":"assets/registrationForm/male_light.png";
  static String female_icon = selectedAppTheme.isDarkMode?
  "assets/registrationForm/female_dark.png":"assets/registrationForm/female_light.png";
  static const prastuti_CLogo = "assets/registrationForm/prastutiTLogo.png";

  //Background Image
  static String bgImage = selectedAppTheme.isDarkMode?
  "assets/background_image_dark.png":"assets/background_image_light.png";
}