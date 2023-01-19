import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_adopt_app/controller/pet_adopt_controller.dart';
import 'package:pet_adopt_app/widgets/common_widgets.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  PetAdoptController controller = Get.put(PetAdoptController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: textWidget(
              text: 'Adopted Pets',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo),
          iconTheme: const IconThemeData(color: Colors.indigo, size: 30),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (controller.adoptedList.isEmpty) ...[
                const  SizedBox(height: 300,),
                  Align(
                    alignment: Alignment.center,
                    child: textWidget(text: 'No Pets Adopted')),
                ],
                Column(
                  children: controller.adoptedList
                      .map((e) => ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(controller.petsList
                                .where((p0) => p0.id == e.id)
                                .first
                                .image!),
                          ),
                          title: textWidget(
                              text: controller.petsList
                                  .where((p0) => p0.id == e.id)
                                  .first
                                  .name!,
                              fontSize: 20,
                              color: Colors.grey),
                          subtitle: textWidget(
                            text: DateFormat.yMEd().format(
                              e.adoptedDate!,
                            ),
                            color: Colors.grey,
                          )))
                      .toList(),
                )
              ],
            ),
          ),
        ));
  }
}
