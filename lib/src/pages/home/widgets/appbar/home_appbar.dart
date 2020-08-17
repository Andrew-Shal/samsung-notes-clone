import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controller.dart';
import './all_notes_more_options.dart';

class HomeAppBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final HomeController controller = Get.find();
  HomeAppBar({GlobalKey<ScaffoldState> scaffoldKey})
      : scaffoldKey = scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: Container(),
      expandedHeight: 200.0,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: buildAppBar(),
        background: Image.network(
          "https://images.pexels.com/photos/583846/pexels-photo-583846.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
          fit: BoxFit.cover,
        ),
      ),
      bottom: (AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState.openDrawer();
          },
        ),
        title: Opacity(
            opacity: 1.0, child: Text(controller.appController.appBarTitle)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
            alignment: Alignment.centerRight,
          ),
          AllNotesMoreOptions(),
        ],
      )),
    );
  }

  Widget buildAppBar() {
    return Container(
      child: Column(
        children: [
          Text(
            controller.appController.appBarTitle,
            textAlign: TextAlign.left,
          ),
          Obx(
            () {
              return Text(
                '${controller.notes.length}',
                style: TextStyle(fontSize: 12.0),
                textAlign: TextAlign.left,
              );
            },
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
