import 'package:flutter/material.dart';
import 'package:medicine_app/core/models/medicine_model.dart';
import 'package:medicine_app/core/providers/home_provider.dart';
import 'package:medicine_app/utilities/constants/color_constant.dart';
import 'package:medicine_app/utilities/constants/sizing_constant.dart';
import 'package:medicine_app/views/commons/listtile_common.dart';
import 'package:medicine_app/views/commons/progress_indicator_common.dart';
import 'package:medicine_app/views/commons/transition_common.dart';
import 'package:medicine_app/views/screens/search/search_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    late ScrollController scrollController;
    return Scaffold(
      key: scaffoldKey,
      drawer: drawerWidget(),
      appBar: appBarWidget(scaffoldKey, context),
      body: Consumer<HomeProvider>(builder: (context, homeProvider, _) {
        if (homeProvider.isLoading) {
          return const Center(child: CustomProgressIndicator());
        } else {
          scrollController = homeProvider.scrollController;
          scrollController.addListener(
              () => homeProvider.setScrollController(scrollController));
          return RefreshIndicator(
            onRefresh: () async => homeProvider.refreshMedicineList(),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  sortWidget(homeProvider),
                  listWidget(homeProvider),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  AppBar appBarWidget(
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => scaffoldKey.currentState!.openDrawer(),
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(
            child: FlutterLogo(
              size: 26.0,
            ),
          ),
        ),
      ),
      centerTitle: true,
      title: Image.asset(
        "assets/images/pill.png",
        width: 40.0,
      ),
      actions: [
        GestureDetector(
          onTap: () => Navigator.push(
              context, customPageTransitionFadeIn(screen: SearchScreen())),
          child: const Padding(
            padding: EdgeInsets.only(right: Sizing.w16),
            child: Icon(
              Icons.search,
              size: 26.0,
            ),
          ),
        ),
      ],
    );
  }

  Drawer drawerWidget() {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizing.h8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text("Developed by: Chiekko Red Alino"),
          ],
        ),
      ),
    );
  }

  ListView listWidget(HomeProvider homeProvider) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: homeProvider.medicineList.length,
        itemBuilder: (context, index) {
          MedicineModel medicine = homeProvider.medicineList[index];
          return CustomListTile(medicine: medicine);
        });
  }

  Padding sortWidget(HomeProvider homeProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Sizing.w16, vertical: Sizing.h8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              if (homeProvider.isAZSorted) {
                homeProvider.sortMedicineListDesc();
              } else {
                homeProvider.sortMedicineListAsc();
              }
            },
            child: Row(
              children: [
                const Text(
                  "SORT",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: CColors.blue,
                  ),
                ),
                const SizedBox(
                  width: 2.0,
                ),
                Icon(
                  homeProvider.isAZSorted
                      ? Icons.north_rounded
                      : Icons.south_rounded,
                  size: 16.0,
                  color: CColors.blue,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
