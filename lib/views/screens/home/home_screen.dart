import 'package:flutter/material.dart';
import 'package:medicine_app/core/extensions/string_extension.dart';
import 'package:medicine_app/core/models/medicine_model.dart';
import 'package:medicine_app/core/viewmodels/home_viewmodel.dart';
import 'package:medicine_app/utilities/constants/color_constant.dart';
import 'package:medicine_app/utilities/constants/medicine_constant.dart';
import 'package:medicine_app/utilities/constants/sizing_constant.dart';
import 'package:medicine_app/views/commons/listtile_common.dart';
import 'package:medicine_app/views/commons/progress_indicator_common.dart';
import 'package:medicine_app/views/commons/text_common.dart';
import 'package:medicine_app/views/commons/transition_common.dart';
import 'package:medicine_app/views/screens/medicine/medicine_form_screen.dart';
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
      body: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, _) {
          if (homeViewModel.isLoading) {
            return const Center(child: CustomProgressIndicator());
          } else {
            scrollController = homeViewModel.scrollController;
            scrollController.addListener(
                () => homeViewModel.setScrollController(scrollController));
            return RefreshIndicator(
              onRefresh: () async => homeViewModel.refreshMedicineList(),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    sortWidget(homeViewModel),
                    listWidget(homeViewModel),
                  ],
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: fabWidget(context),
    );
  }

  FloatingActionButton fabWidget(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MedicineFormScreen(),
              fullscreenDialog: true)),
      child: const Icon(
        Icons.add_rounded,
        size: 32.0,
      ),
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

  ListView listWidget(HomeViewModel homeViewModel) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: homeViewModel.medicineList.length,
        itemBuilder: (context, index) {
          MedicineModel medicine = homeViewModel.medicineList[index];
          return CustomListTile(medicine: medicine, index: index);
        });
  }

  Padding sortWidget(HomeViewModel homeViewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Sizing.w16, vertical: Sizing.h8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.local_pharmacy_rounded,
                color: Colors.blue,
              ),
              CustomTextBold(
                  text: MedicineConstants.branded.capitalizeFirstLetter,
                  fontSize: 16.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizing.h8),
                child: CustomTextBold(text: "•", fontSize: 16.0),
              ),
              const Icon(
                Icons.local_pharmacy_rounded,
                color: Colors.amber,
              ),
              CustomTextBold(
                  text: MedicineConstants.generic.capitalizeFirstLetter,
                  fontSize: 16.0),
            ],
          ),
          GestureDetector(
            onTap: () {
              if (homeViewModel.isAZSorted) {
                homeViewModel.sortMedicineListDesc();
              } else {
                homeViewModel.sortMedicineListAsc();
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
                  homeViewModel.isAZSorted
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
