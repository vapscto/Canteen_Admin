import 'package:canteen_management/constants/theme_constants.dart';
import 'package:canteen_management/controller/theme_controller.dart';
import 'package:canteen_management/main.dart';
import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:canteen_management/widgets/custom_container.dart';
import 'package:canteen_management/widgets/m_skool_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  final List<String> name = [
    "Sports Blue",
    "Radial Red",
    "Kingfisher Daisy",
    "Pantone",
  ];
  final List<Color> color = [
    const Color(0xFF1E38FC),
    const Color(0xFFFF385C),
    const Color(0xFF604A7B),
    const Color(0xFFFFA500)
  ];
  final List<Color> bgColor = [
    const Color(0xFFEFF1FF),
    const Color(0xFFFFE5EA),
    const Color(0xFFF4EBFF),
    const Color(0xFFFFF5E3),
  ];
  int index = 0;
  ThemeController controller = Get.find<ThemeController>();

  @override
  void initState() {
    if (themeBox!.get("colorTheme") != null) {
      index = themeBox!.get("colorTheme");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Theme Color").getAppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Choose Theme Color",
                  style: Theme.of(context).textTheme.titleMedium!.merge(
                    const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  "Select the color palette according to your choice.",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          this.index = index;
                        });
                      },
                      child: ColorThemeItem(
                        color: color.elementAt(index),
                        title: name.elementAt(index),
                        bgColor: bgColor.elementAt(index),
                        isSelected: this.index == index,
                      ),
                    );
                  },
                  itemCount: color.length,
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Center(
                  child: MSkollBtn(
                    onPress: () {
                      setState(() {
                        controller.theme.value = index;
                        if (themeBox != null) {
                          themeBox!.put("colorTheme", index);
                        }
                        CustomThemeData.changeStatusBarColor(context);
                        Get.back();
                      });
                    },
                    size: Size(Get.width * 0.5, 50),
                    title: "Set Color Theme",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ColorThemeItem extends StatelessWidget {
  final String title;
  final Color color;
  final Color bgColor;
  final bool isSelected;

  const ColorThemeItem({
    super.key,
    required this.title,
    required this.color,
    required this.bgColor,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
              border: isSelected
                  ? Border.all(
                color: color,
                width: 2.0,
              )
                  : null,
              borderRadius: BorderRadius.circular(8.0)),
          margin: const EdgeInsets.only(top: 12.0, bottom: 12, left: 36.0),
          child: CustomContainer(
            color: bgColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Color Name "),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelMedium!.merge(
                      TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          child: CircleAvatar(
            minRadius: 54.0,
            backgroundColor: color,
          ),
        ),
      ],
    );
  }
}
