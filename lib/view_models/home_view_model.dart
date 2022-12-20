


import 'package:get/get.dart';

HomeViewModel homeViewModel = HomeViewModel();
final homeViewController = Get.put(homeViewModel);

class HomeViewModel extends GetxController{

  RxInt _selectedView = 0.obs;

  int get selectedView => _selectedView.value;

  changeSelectedView(int value){
    print("Changing the SelectedView to $value");
    _selectedView.value = value;
  }
}