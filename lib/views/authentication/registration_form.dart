import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prastuti_23/config/appTheme.dart';
import 'package:prastuti_23/config/image_paths.dart';
import 'package:prastuti_23/config/screen_config.dart';
import 'package:prastuti_23/views/ui/choice_chips.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  List<ChoiceChipData> choiceChips = ChoiceChips.all;
  List<String> interests = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    SizeConfig.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppTheme().primaryColor,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 30),
          child: Container(
            color: AppTheme().backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Create Account",
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    color: AppTheme().primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "complete your profile",
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: AppTheme().secondaryColor,
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
                          Icon(Icons.person_outline_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sriraj",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Psriraj1902@gmail.com",
                                style: GoogleFonts.lato(
                                  color: AppTheme().primaryColor,
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
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: inputField(
                          icon: Icon(
                            Icons.assured_workload_outlined,
                            color: AppTheme().primaryColor,
                          ),
                          hintText: "COLLEGE",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: inputField(
                          icon: Icon(
                            Icons.phone_android_outlined,
                            color: AppTheme().primaryColor,
                          ),
                          hintText: "PHONE",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: inputField(
                          icon: Container(
                            height: SizeConfig.height * 0.04,
                            width: SizeConfig.height * 0.04,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(ImagePaths.linkedin_squared),
                                    fit: BoxFit.cover)),
                          ),
                          hintText: "LINKEDIN URL",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: inputField(
                          icon: Container(
                            height: SizeConfig.height * 0.04,
                            width: SizeConfig.height * 0.04,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage(ImagePaths.instagram_squared),
                                    fit: BoxFit.cover)),
                          ),
                          hintText: "INSTA URL",
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text("Interests:",
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: AppTheme().primaryColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      buildChoiceChips()
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                ElevatedButton(
                  onPressed: () {},
                  child: Center(
                    child: Text(
                      "CREATE ACCOUNT",
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    fixedSize: Size(SizeConfig.width, 40),
                    backgroundColor: AppTheme().primaryColor,
                    //shadowColor: AppTheme().primaryColor,
                    elevation: 0,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Please fill the mandatory fields to proceed",
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: AppTheme().secondaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )),
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

  inputField({Key? key, required this.icon, required this.hintText})
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
          width: SizeConfig.widthPercent * 30,
          child: TextField(
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
