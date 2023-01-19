import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_adopt_app/constants/app_colors.dart';
import 'package:pet_adopt_app/widgets/common_widgets.dart';

import '../controller/pet_adopt_controller.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  PetAdoptController controller = Get.put(PetAdoptController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: controller.selectedPet.image!,
              child: Material(
                child: Container(
                  height: Get.height / 2,
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30)),
                      image: DecorationImage(
                          image: AssetImage(
                            controller.selectedPet.image!,
                          ),
                          fit: BoxFit.cover,
                          scale: 20)),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: Get.back,
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ))
                          ]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget(
                          fontSize: 30,
                          text: controller.selectedPet.name!.capitalizeFirst!,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                      textWidget(
                          fontSize: 30,
                          text: '\$${controller.selectedPet.price}',
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      detailBox('Age', '${controller.selectedPet.age!} Yrs'),
                      detailBox('Price', '\$${controller.selectedPet.price}'),
                      detailBox('Animal', controller.selectedPet.category!)
                    ],
                  ),
                  const SizedBox(height: 20),
                  textWidget(
                      text: 'About',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                  const SizedBox(height: 10),
                  textWidget(
                      text: controller.selectedPet.about!,
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500)
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: MaterialButton(
                
                minWidth: Get.width-50,
                height: 44,
                color: controller.adoptedList
                        .where((element) =>
                            element.id == controller.selectedPet.id!)
                        .isEmpty
                    ? Colors.indigo
                    : Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onPressed: () {
                  if (controller.adoptedList
                      .where(
                          (element) => element.id == controller.selectedPet.id!)
                      .isEmpty) {
                    controller.saveAdoption(controller.selectedPet.id!);

                    Get.bottomSheet(
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                          
                            LottieBuilder.asset(
                              'assets/confi.json',
                              height: 200,
                              width: 200,
                            ),

                          ],
                        ),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                                isDismissible: false
                                );
                    Future.delayed(const Duration(seconds: 2)).then((value) {
                      Get.back();
                    });
                  } else {
                    Get.snackbar(
                        'Already Adopted', 'You have already adopted this pet');
                  }
                },
                child: textWidget(
                    text: 'Adopt Me',
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget detailBox(String name, String label) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
          color: AppColors.lightBlue, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            textWidget(text: name, color: Colors.white, fontSize: 12),
            const SizedBox(height: 5),
            textWidget(
                text: label,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white)
          ],
        ),
      ),
    );
  }
}
