import 'package:demo/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeController>(
          init: HomeController(),
          initState: (state) {
            HomeController homeController = Get.put(HomeController());
            homeController.getCardList();
          },
          builder: (HomeController homeController) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Start'),
                        Text(
                          'Step: ${homeController.stepCount}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.9,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        padding: const EdgeInsets.only(top: 15),
                        itemCount: homeController.cardList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => homeController.cardOnTap(context, homeController.cardList[index]),
                            child: Container(
                              decoration: BoxDecoration(
                                color: homeController.cardList[index].isCardOpened ? Colors.white : Colors.teal,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: homeController.cardList[index].isCardOpened ? Colors.teal : Colors.transparent,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  homeController.cardList[index].isCardOpened
                                      ? '${homeController.cardList[index].cardNumber}'
                                      : '?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                    color: homeController.cardList[index].isCardOpened ? Colors.teal : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
