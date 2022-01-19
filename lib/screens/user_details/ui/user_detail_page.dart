import 'package:flutter/material.dart';
import 'package:flutter_graphql/session/di/session_module.dart';
import 'package:flutter_graphql/session/model/session.dart';
import 'package:flutter_graphql/session/repo/session_repo.dart';
import 'package:flutter_graphql/widgets/custom_appbar.dart';

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
      body: StreamBuilder<Session>(
          stream: _sessionRepo.getSession(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Column(
                children: [
                  Text(snapshot.data?.user?.name ?? "parth"),
                  Text(snapshot.data?.user?.email ?? "parth@test.com")
                ],
              );
            }
            return Container();
          }),
    );
  }
}
