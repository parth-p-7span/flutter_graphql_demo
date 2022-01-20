import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graphql/session/di/session_module.dart';
import 'package:flutter_graphql/session/model/session.dart';
import 'package:flutter_graphql/session/repo/session_repo.dart';
import 'package:flutter_graphql/theme_data.dart';
import 'package:flutter_graphql/widgets/custom_appbar.dart';
import 'package:share/share.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({Key? key}) : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late SessionRepo _sessionRepo;

  @override
  void initState() {
    _sessionRepo = SessionModule().getSessionRepo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar("User Details", true, false, false),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: StreamBuilder<Session>(
            stream: _sessionRepo.getSession(),
            builder: (context, snapshot) {
              print(snapshot.data.toString());
              if (snapshot.data != null) {
                print(snapshot.data?.user?.id.toString());
                return Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        ///user background image section
                        Padding(
                            padding: const EdgeInsets.only(bottom: 35),
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                /// image
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  child: Image.asset(
                                    "assets/images/profile_bg.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                /// edit icon
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Colors.blue),
                                    child: Icon(Icons.edit,
                                        color: Colors.white, size: 15),
                                  ),
                                )
                              ],
                            )),

                        ///user profile image section
                        Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                ///image
                                Container(
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/ProfilePic.jpg"),
                                        fit: BoxFit.cover),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                ),

                                /// edit icon
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Container(
                                    height: 22,
                                    width: 22,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Colors.blue),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 2),
                      child: Text(
                        snapshot.data?.user?.name ?? "",
                        style: MyTheme.latoTextBold(
                            18, Colors.black54, FontWeight.w600),
                      ),
                    ),
                    Text(
                      snapshot.data?.user?.email ?? "",
                      style: MyTheme.latoText(13, Colors.black45),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          String name = snapshot.data?.user?.name ?? "";
                          String msg = "Hey There! This is " +
                              name +
                              ", Sharing you my profile with share plugin. Check this out : https://vepaar.com/";
                          Share.share(msg);
                        },
                        child: Text("Share")),
                  ],
                );
              }
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
