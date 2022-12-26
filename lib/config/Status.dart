


import 'package:prastuti_23/config/image_paths.dart';




class Status {
  static String statusImage(String status) {
    String statusImage = '';
    if (status == 'onGoing') {
      statusImage = ImagePaths.ongoing;
    }
    else if (status == 'ended') {
      statusImage = ImagePaths.ended;
    }
    else {
      statusImage = ImagePaths.coming;
    }
    return statusImage;
  }
}





