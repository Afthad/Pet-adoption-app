// To parse this JSON data, do
//
//     final PetDetails = PetDetailsFromJson(jsonString);

import 'dart:convert';



class PetDetails {
    PetDetails({
        this.id,
        this.category,
        this.age,
        this.price,
        this.isAdopted,
        this.image,
        this.name,
        this.about,
    });

    int? id;
    String? category;
    int? age;
    int? price;
    bool? isAdopted;
    String? image;
    String? name;
    String? about;

    factory PetDetails.fromJson(Map<String, dynamic> json) => PetDetails(
        id: json["id"],
      about: json['about'],
        category: json["category"],
        age: json["age"],
        price: json["price"],
        isAdopted: json["isAdopted"],
        image: json["image"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "age": age,
        "price": price,
        "isAdopted": isAdopted,
        "image": image,
        "name": name,
    };
}

