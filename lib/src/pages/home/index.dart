import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/src/pages/home/controller.dart';
import 'widgets/appbar/home_appbar.dart';
import '../../widgets/home_drawer/home_drawer.dart';
import './widgets/notes_list/notes_list.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          key: _scaffoldKey,
          body: CustomScrollView(slivers: <Widget>[
            HomeAppBar(scaffoldKey: _scaffoldKey),
            SliverFillRemaining(
              child: Container(
                height: MediaQuery.of(context).size.height - 80,
                child: NotesList(),
              ),
              hasScrollBody: false,
            )
          ]),
          drawer: Drawer(
            child: HomeDrawer(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed("/note/add");
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
