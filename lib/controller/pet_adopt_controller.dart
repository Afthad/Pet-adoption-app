import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adopt_app/models/adoption_model.dart';
import 'package:pet_adopt_app/models/petlist_model.dart';
import 'package:pet_adopt_app/prefs/prefs.dart';

class PetAdoptController extends GetxController {
  @override
  onInit() {
    super.onInit();
    setTheme(null);

    getData();
    getSearchedData(' ');
    getAdopted();
  }

  void setTheme(bool? isDarkMode) {
    if (isDarkMode == null) {
      if (PrefsDb.getTheme) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
           Get.changeThemeMode(
            !PrefsDb.getTheme ? ThemeMode.light : ThemeMode.dark);
        });
       }
      } else {
        Get.changeThemeMode(!isDarkMode ? ThemeMode.light : ThemeMode.dark);
        PrefsDb.saveTheme(isDarkMode);
      }
    
  }

  void getSearchedData(String? d) {
    List<PetDetails> petsTempList = [];
    petsTempList.addAll(petsList);
    searchedList.clear();
    if (d == null || d.isEmpty || d == ' ') {
      searchedList.value = petsTempList;
    } else {
      petsTempList.forEach((element) {
        if (element.name!.contains(d.toLowerCase())) {
          searchedList.add(element);
        }
      });
    }
  }

  RxList<PetDetails> searchedList = <PetDetails>[].obs;
  RxBool isLoading = false.obs;
  RxList<PetDetails> petsList = <PetDetails>[].obs;
  late PetDetails selectedPet;

  getData() {
    isLoading.value = true;
    for (var a in petLis['PetDetails']) {
      petsList.add(PetDetails.fromJson(a));
    }
    isLoading.value = false;
  }

  RxList<AdoptionModel> adoptedList = <AdoptionModel>[].obs;
  void saveAdoption(int id) {
    List<dynamic> data = [];
    if (PrefsDb.prefsBox.isNotEmpty) {
      data.addAll(PrefsDb.adoptedOnes);
    }
    data.add({"id": id, "adoptedDate": DateTime.now()});
    PrefsDb.saveOrders(data);
    getAdopted();
  }

  getAdopted() {
    adoptedList.clear();
    if (PrefsDb.adoptedOnes.isNotEmpty) {
      for (var i in PrefsDb.adoptedOnes) {
        adoptedList.add(AdoptionModel.fromJson(i));
      }
    }
    adoptedList.sort((a, b) => b.adoptedDate!.millisecondsSinceEpoch
        .compareTo(a.adoptedDate!.millisecondsSinceEpoch));
  }
}

Map petLis = {
  "PetDetails": [
    {
      "id": 1,
      "category": "Dog",
      "age": 2,
      "price": 240,
      "isAdopted": false,
      "image": "assets/beagle.webp",
      "name": "beagle",
      "about":
          "A pet is a domesticated animal that lives with an individual or family. There are popular, well-known pets like dogs and cats. Alternatively, there are less common pets sometimes called exotics such as snakes, turtles, and iguanas. Whether a pet is common or exotic, it can offer pleasure and joy to a household. In this article, we will provide a list of pets."
    },
    {
      "id": 2,
      "category": "Dog",
      "age": 3,
      "price": 300,
      "isAdopted": false,
      "image": "assets/husky.jpeg",
      "name": "husky",
      "about":
          "A pet is a domesticated animal that lives with an individual or family. There are popular, well-known pets like dogs and cats. Alternatively, there are less common pets sometimes called exotics such as snakes, turtles, and iguanas. Whether a pet is common or exotic, it can offer pleasure and joy to a household. In this article, we will provide a list of pets."
    },
    {
      "id": 3,
      "category": "Dog",
      "age": 5,
      "price": 300,
      "isAdopted": false,
      "image": "assets/dachshund.jpg",
      "name": "dachshund",
      "about":
          "A pet is a domesticated animal that lives with an individual or family. There are popular, well-known pets like dogs and cats. Alternatively, there are less common pets sometimes called exotics such as snakes, turtles, and iguanas. Whether a pet is common or exotic, it can offer pleasure and joy to a household. In this article, we will provide a list of pets."
    },
    {
      "id": 4,
      "category": "Dog",
      "age": 5,
      "price": 190,
      "isAdopted": false,
      "image": "assets/bulldog.jpeg",
      "name": "bull dog",
      "about":
          "A pet is a domesticated animal that lives with an individual or family. There are popular, well-known pets like dogs and cats. Alternatively, there are less common pets sometimes called exotics such as snakes, turtles, and iguanas. Whether a pet is common or exotic, it can offer pleasure and joy to a household. In this article, we will provide a list of pets."
    },
    {
      "id": 5,
      "category": "Dog",
      "age": 3,
      "price": 190,
      "isAdopted": false,
      "image": "assets/pug.jpeg",
      "name": "pug",
      "about":
          "A pet is a domesticated animal that lives with an individual or family. There are popular, well-known pets like dogs and cats. Alternatively, there are less common pets sometimes called exotics such as snakes, turtles, and iguanas. Whether a pet is common or exotic, it can offer pleasure and joy to a household. In this article, we will provide a list of pets."
    },
    {
      "id": 6,
      "category": "Parrot",
      "age": 3,
      "price": 190,
      "isAdopted": false,
      "image": "assets/parrot.webp",
      "name": "parrot",
      "about":
          "A pet is a domesticated animal that lives with an individual or family. There are popular, well-known pets like dogs and cats. Alternatively, there are less common pets sometimes called exotics such as snakes, turtles, and iguanas. Whether a pet is common or exotic, it can offer pleasure and joy to a household. In this article, we will provide a list of pets."
    },
    {
      "id": 7,
      "category": "Goldfish",
      "age": 3,
      "price": 220,
      "isAdopted": false,
      "image": "assets/goldfish.jpeg",
      "name": "goldfish",
      "about":
          "A pet is a domesticated animal that lives with an individual or family. There are popular, well-known pets like dogs and cats. Alternatively, there are less common pets sometimes called exotics such as snakes, turtles, and iguanas. Whether a pet is common or exotic, it can offer pleasure and joy to a household. In this article, we will provide a list of pets."
    },
    {
      "id": 8,
      "category": "Hamster",
      "age": 3,
      "price": 190,
      "isAdopted": false,
      "image": "assets/hamster.jpeg",
      "name": "hamster",
      "about":
          "A pet is a domesticated animal that lives with an individual or family. There are popular, well-known pets like dogs and cats. Alternatively, there are less common pets sometimes called exotics such as snakes, turtles, and iguanas. Whether a pet is common or exotic, it can offer pleasure and joy to a household. In this article, we will provide a list of pets."
    },
    {
      "id": 9,
      "category": "Rabbit",
      "age": 3,
      "price": 190,
      "isAdopted": false,
      "image": "assets/rabbit.webp",
      "name": "rabbit",
      "about":
          "A pet is a domesticated animal that lives with an individual or family. There are popular, well-known pets like dogs and cats. Alternatively, there are less common pets sometimes called exotics such as snakes, turtles, and iguanas. Whether a pet is common or exotic, it can offer pleasure and joy to a household. In this article, we will provide a list of pets."
    },
    {
      "id": 10,
      "category": "Pegion",
      "age": 3,
      "price": 50,
      "isAdopted": false,
      "image": "assets/pegion.jpeg",
      "name": "pegion",
      "about":
          "A pet is a domesticated animal that lives with an individual or family. There are popular, well-known pets like dogs and cats. Alternatively, there are less common pets sometimes called exotics such as snakes, turtles, and iguanas. Whether a pet is common or exotic, it can offer pleasure and joy to a household. In this article, we will provide a list of pets."
    },
    {
      "id": 11,
      "category": "Cat",
      "age": 1,
      "price": 130,
      "isAdopted": false,
      "image": "assets/cat.jpeg",
      "name": "cat",
      "about":
          "A pet is a domesticated animal that lives with an individual or family. There are popular, well-known pets like dogs and cats. Alternatively, there are less common pets sometimes called exotics such as snakes, turtles, and iguanas. Whether a pet is common or exotic, it can offer pleasure and joy to a household. In this article, we will provide a list of pets."
    }
  ]
};
