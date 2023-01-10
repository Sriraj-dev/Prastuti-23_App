import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/appTheme.dart';
import '../config/image_paths.dart';
import '../config/screen_config.dart';

class CreateNewTeam extends StatefulWidget {
  const CreateNewTeam({Key? key}) : super(key: key);

  @override
  State<CreateNewTeam> createState() => _CreateNewTeamState();
}

class _CreateNewTeamState extends State<CreateNewTeam> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: SizeConfig.width*0.75,
        height: SizeConfig.height*0.31,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4.0,
              spreadRadius: 3.0,
              offset: Offset(4, 4)
          )]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ImagePaths.cancel_02),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                ),
              ],
            ),
            AutoSizeText(
              'Create New Team',
              style: AppTheme().headText1.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    hintText: 'Enter Team Name',
                  ),
                  validator: (name) => name != null && name.isEmpty
                      ? 'You cannot leave this field empty!'
                      : null,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Container(
                    width: SizeConfig.height*0.14,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                        // boxShadow: [BoxShadow(
                        //     color: Colors.black.withOpacity(0.3),
                        //     blurRadius: 4.0,
                        //     spreadRadius: 3.0,
                        //     offset: Offset(4, 4)
                        // )]
                    ),
                    child: Center(
                      child: Text(
                          'Create',
                          style: GoogleFonts.catamaran(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    ),
                  ),
                  onPressed: () {
                    /// TODO: Implement Add
                  }
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
