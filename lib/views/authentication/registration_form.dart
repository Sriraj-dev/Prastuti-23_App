import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prastuti_23/config/appTheme.dart';
import 'package:prastuti_23/config/image_paths.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/utils/routes/route_names.dart';
import 'package:prastuti_23/utils/utils.dart';
import 'package:prastuti_23/view_models/auth_view_model.dart';
import 'package:prastuti_23/view_models/registration_view_model.dart';
import 'package:prastuti_23/views/ui/choice_chips.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  List<ChoiceChipData> choiceChips = ChoiceChips.all;
  TextEditingController college = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController linkedIn = new TextEditingController();
  TextEditingController insta = new TextEditingController();
  TextEditingController github = new TextEditingController();
  List<String> socialUrls = [];
  List<String> interests = [];
  String gender = "Male";
  RxBool isLoading = false.obs;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    SizeConfig.init(context);
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppTheme().backgroundColor,
      systemNavigationBarIconBrightness: selectedAppTheme.isDarkMode?
      Brightness.light:Brightness.dark,
    ));

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImagePaths.bgImage),
              fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      ImagePaths.prastuti_CLogo,
                      scale: 2,
                    ),
                    Text(
                      "Create Account",
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        color: selectedAppTheme.isDarkMode?
                        Colors.white:AppTheme().primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "complete your profile",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: selectedAppTheme.isDarkMode?
                        Colors.white:AppTheme().secondaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: SizeConfig.heightPercent * 50,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_outline_outlined,
                                color: selectedAppTheme.isDarkMode?
                                Colors.white:AppTheme().primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    currentUser.name!,
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    currentUser.emailId!,
                                    style: GoogleFonts.lato(
                                      color: selectedAppTheme.isDarkMode?
                                      Colors.white:AppTheme().primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: inputField(
                              controller: college,
                              icon: Icon(
                                Icons.assured_workload_outlined,
                                color: selectedAppTheme.isDarkMode?
                                Colors.white:AppTheme().primaryColor,
                              ),
                              hintText: "COLLEGE",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: inputField(
                              controller: phone,
                              keyBoard: TextInputType.phone,
                            icon: Icon(
                                Icons.phone_android_outlined,
                                color: selectedAppTheme.isDarkMode?
                                Colors.white:AppTheme().primaryColor,
                              ),
                              hintText: "PHONE",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: inputField(
                              controller: linkedIn,
                              icon: Container(
                                height: SizeConfig.height * 0.04,
                                width: SizeConfig.height * 0.04,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            ImagePaths.linkedin_squared),
                                        fit: BoxFit.cover)),
                              ),
                              hintText: "LINKEDIN URL",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: inputField(
                              controller: insta,
                              icon: Container(
                                height: SizeConfig.height * 0.04,
                                width: SizeConfig.height * 0.04,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            ImagePaths.instagram_squared),
                                        fit: BoxFit.cover)),
                              ),
                              hintText: "INSTA ID",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: inputField(
                              controller: github,
                              icon: Container(
                                height: SizeConfig.height * 0.04,
                                width: SizeConfig.height * 0.04,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage(ImagePaths.github_squared),
                                        fit: BoxFit.cover)),
                              ),
                              hintText: "GITHUB ID",
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Interests:",
                            style: GoogleFonts.lato(
                                fontSize: 16,
                                color: selectedAppTheme.isDarkMode?
                                Colors.white:AppTheme().primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          buildChoiceChips(),
                          Text(
                            "Gender:",
                            style: GoogleFonts.lato(
                                fontSize: 16,
                                color: selectedAppTheme.isDarkMode?
                                Colors.white:AppTheme().primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: SizeConfig.widthPercent * 65,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      activeColor: AppTheme().kSecondaryColor,
                                        value: "Male",
                                        groupValue: gender,
                                        onChanged: (value) {
                                          setState(() {
                                            gender = value.toString();
                                          });
                                        }),
                                    Container(
                                      height: SizeConfig.height * 0.04,
                                      width: SizeConfig.height * 0.04,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(ImagePaths.male_icon),
                                              fit: BoxFit.cover,
                                          )
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Radio(
                                      activeColor: AppTheme().kSecondaryColor,
                                        value: "Female",
                                        groupValue: gender,
                                        onChanged: (value) {
                                          setState(() {
                                            gender = value.toString();
                                          });
                                        }),
                                        Container(
                                      height: SizeConfig.height * 0.04,
                                      width: SizeConfig.height * 0.04,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  ImagePaths.female_icon),
                                              fit: BoxFit.cover)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () async{
                        submitTheForm();

                        //Navigator.of(context).pushNamed(RouteNames.homeView);
                      },
                      child: Obx(
                        ()=> Center(
                          child: (isLoading.value)?
                          const SpinKitSpinningLines(color: Colors.white,size: 30,):
                          Text(
                            "CREATE ACCOUNT",
                            style: GoogleFonts.poppins(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        fixedSize: Size(SizeConfig.width, 40),
                        backgroundColor: AppTheme().primaryColor,
                        //shadowColor: AppTheme().primaryColor,
                        elevation: 0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please fill the mandatory fields to proceed",
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        color: selectedAppTheme.isDarkMode?
                        Colors.white:AppTheme().secondaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  void submitTheForm()async{
    final  validCharacters = RegExp(r'^[0-9]+$');
    bool isValidPhone = validCharacters.hasMatch(phone.text) && phone.text.length==10;

    if(!isValidPhone){
      Utils.flushBarMessage(
        message: "Enter a Valid phone number!",
        context: context,
        bgColor: Colors.redAccent
      );
    }

    if(college.text.isEmpty){
      Utils.flushBarMessage(
          message: "Please enter your College name",
          context: context,
          bgColor: Colors.redAccent);
    }

    isLoading.value = true;
    socialUrls.add(linkedIn.text);
    socialUrls.add(insta.text);
    socialUrls.add(github.text);
    await RegistrationViewModel().submitRegistrationForm(
      college.text, num.parse(phone.text), socialUrls, interests, gender, currentUser.sId!, context);
      isLoading.value = false;
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppTheme().primaryColor,
        ),
      ),
    );
  }

  Widget buildChoiceChips() => Wrap(
        runSpacing: 3,
        spacing: 8,
        children: choiceChips
            .map((choiceChip) => ChoiceChip(
                  label: Text(choiceChip.label),
                  labelStyle: AppTheme().headText2.copyWith(
                      fontSize: 13,
                      color: (choiceChip.isSelected)
                          ? Colors.white
                          : Colors.black),
                  onSelected: (isSelected) => setState(() {
                    if (true) {
                      choiceChips = choiceChips.map((otherChip) {
                        final newChip = otherChip.copy(
                            isSelected: otherChip.isSelected,
                            label: otherChip.label);

                        if (newChip == choiceChip) {
                          if (isSelected) {
                            interests.add(choiceChip.label);
                          } else {
                            interests.remove(choiceChip.label);
                          }
                        }
                        return choiceChip == newChip
                            ? newChip.copy(
                                isSelected: isSelected, label: newChip.label)
                            : newChip;
                      }).toList();
                    }
                  }),
                  selected: choiceChip.isSelected,
                  selectedColor: AppTheme().primaryColor,
                  disabledColor: Colors.grey,
                ))
            .toList(),
      );
}


class inputField extends StatelessWidget {
  Widget icon;
  String hintText;
  TextEditingController controller;
  TextInputType keyBoard;

  inputField({Key? key, required this.icon, required this.hintText,required this.controller,this.keyBoard = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon,
        SizedBox(
          width: 20,
        ),
        SizedBox(
          width: SizeConfig.widthPercent * 50,
          child: TextField(
            controller: controller,
            keyboardType: keyBoard,
            decoration: InputDecoration(
              
                border: InputBorder.none,
                hintText: hintText,
                hintStyle:
                    GoogleFonts.poppins(fontSize: 16, color: Colors.grey[400])),
          ),
        ),
      ],
    );
  }
}
