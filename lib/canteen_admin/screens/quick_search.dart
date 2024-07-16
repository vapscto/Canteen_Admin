import 'package:canteen_management/canteen_admin/admin_api/admin_api.dart';
import 'package:canteen_management/canteen_admin/admin_controller/admin_controller.dart';
import 'package:canteen_management/canteen_admin/widgets/quick_search_kot_print.dart';
import 'package:canteen_management/canteen_admin/widgets/quick_search_pdf.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:canteen_management/widgets/m_skool_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class QuickSearchScreen extends StatefulWidget {
  final MskoolController mskoolController;
  final int miId;
  final AdminController controller;

  const QuickSearchScreen(
      {super.key,
      required this.mskoolController,
      required this.miId,
      required this.controller});

  @override
  State<QuickSearchScreen> createState() => _QuickSearchScreenState();
}

class _QuickSearchScreenState extends State<QuickSearchScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Quick Search").getAppBar(),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Text(
                    "Note:- One Time Print only",
                    style: Get.textTheme.titleSmall!.copyWith(
                        color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: Get.textTheme.titleSmall!
                              .copyWith(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.grey))),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topCenter,
              child: MSkollBtn(
                  title: "Search",
                  onPress: () async {
                    await quickSearch(
                            base: baseUrlFromInsCode(
                                'canteen', widget.mskoolController),
                            orderId: int.parse(searchController.text.trim()),
                            controller: widget.controller,
                            flag: 'overall')
                        .then((value) async {
                      if (value!.values!.isNotEmpty) {
                        await QuickSearchPdf.i.generateNow(
                            controller: widget.controller,
                            mskoolController: widget.mskoolController,
                            date: DateTime.now().toIso8601String());
                        await QuickSearchKotPrint.instance.quickSearch(
                            controller: widget.controller,
                            mskoolController: widget.mskoolController,
                            date: DateTime.now().toIso8601String());
                        searchController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            elevation: 2,
                            content: Text(
                              "Already been printed or check Order Id",
                              style: Get.textTheme.titleSmall!
                                  .copyWith(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      setState(() {});
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
