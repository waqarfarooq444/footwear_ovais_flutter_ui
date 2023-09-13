import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common_widget/round_button.dart';
import 'package:food_delivery/view/main_tabview/main_tabview.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int selectPage = 0;
  PageController controller = PageController();

  List pageArr = [
    {
      "title": "Winter Style, Celeb Vibe",
      "subtitle":
          "Explore top-notch jackets with diverse choices\nin material, colors, size with customization,\nall swiftly delivered to your doorstep.",
      "image": "assets/img/logo_white.jpg",
    },
    {
      "title": "Fast Delivery",
      "subtitle": "Fast home delivery, office\n wherever you are",
      "image": "assets/img/delivery.png",
    },
    {
      "title": "Bulk Byuing",
      "subtitle":
          "Save 10% on Amazon's Brixwear shelf \nwhen you buy a dozen items through our app.",
      "image": "assets/img/amazone.png",
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.addListener(() {
      setState(() {
        selectPage = controller.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: controller,
            itemCount: pageArr.length,
            itemBuilder: ((context, index) {
              var pObj = pageArr[index] as Map? ?? {};
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: media.width,
                    height: media.width,
                    alignment: Alignment.center,
                    child: Image.asset(
                      pObj["image"].toString(),
                      width: media.width * 0.65,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.2,
                  ),
                  Text(
                    pObj["title"].toString(),
                    style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 28,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  Text(
                    pObj["subtitle"].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: media.width * 0.20,
                  ),
                ],
              );
            }),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: media.height * 0.6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pageArr.map((e) {
                  var index = pageArr.indexOf(e);

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                        color: index == selectPage
                            ? TColor.primary
                            : TColor.placeholder,
                        borderRadius: BorderRadius.circular(4)),
                  );
                }).toList(),
              ),
              SizedBox(
                height: media.height * 0.28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: RoundButton(
                    title: "Next",
                    onPressed: () {
                      if (selectPage >= 2) {
                        // Home Screen

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainTabView(),
                          ),
                        );
                      } else {
                        //Next Screen

                        setState(() {
                          selectPage = selectPage + 1;
                          controller.animateToPage(selectPage,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.bounceInOut);
                        });
                      }
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
