import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pet_adopt_app/controller/pet_adopt_controller.dart';
import 'package:pet_adopt_app/pages/details_screen.dart';
import 'package:pet_adopt_app/pages/history_screen.dart';
import 'package:pet_adopt_app/prefs/prefs.dart';
import 'package:pet_adopt_app/widgets/common_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textController = TextEditingController();
  PetAdoptController controller = Get.put(PetAdoptController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          onPressed: () {
            Get.to(const HistoryScreen());
          },
          child: const Icon(Icons.history_edu_outlined),
        ),
        appBar: AppBar(
          elevation: 0,
          leading: const Icon(
            Icons.list_outlined,
            size: 30,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                controller.setTheme(!PrefsDb.getTheme);
              },
              icon: const Icon(Icons.dark_mode),
              color: Colors.indigo,
              iconSize: 20,
            ),
          ],
          title: textWidget(
              text: 'Pet Cafe',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo),
          iconTheme: const IconThemeData(color: Colors.indigo, size: 30),
        ),
        body: Obx(
          () => SafeArea(
              child: !controller.isLoading.value
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              decoration: inputDecoration(),
                              controller: textController,
                              onChanged: (s) {
                                controller.getSearchedData(textController.text);
                              },
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.searchedList.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.selectedPet =
                                          controller.searchedList[index];
                                      Get.to(const DetailsScreen());
                                    },
                                    child: Obx(
                                      () => Hero(
                                        tag: controller
                                            .searchedList[index].image!,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: Get.height / 4,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20)),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                            controller
                                                                .searchedList[
                                                                    index]
                                                                .image!,
                                                          ),
                                                          fit: BoxFit.fill,
                                                          scale: 20)),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                          .orange[
                                                                      100],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12)),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 2,
                                                                    horizontal:
                                                                        12),
                                                                child:
                                                                    textWidget(
                                                                  text: controller
                                                                      .searchedList[
                                                                          index]
                                                                      .category!,
                                                                  fontSize: 10,
                                                                ),
                                                              )),
                                                          if (controller
                                                              .adoptedList
                                                              .where((element) =>
                                                                  element.id ==
                                                                  controller
                                                                      .searchedList[
                                                                          index]
                                                                      .id!)
                                                              .isNotEmpty) ...[
                                                            textWidget(
                                                                text: 'Adopted',
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 10)
                                                          ]
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          textWidget(
                                                            color:
                                                                Colors.indigo,
                                                            text: controller
                                                                .searchedList[
                                                                    index]
                                                                .name!
                                                                .capitalizeFirst!,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          textWidget(
                                                              text:
                                                                  "${controller.searchedList[index].age} Yrs",
                                                              color:
                                                                  Colors.grey)
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    )
                  : Container()),
        ));
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      hintText: 'Search',
      suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: Colors.indigo,
          )),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.indigo, width: 2)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.indigo, width: 2)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.indigo, width: 2)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.indigo, width: 2)),
    );
  }
}
