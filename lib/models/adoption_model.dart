class AdoptionModel {
  int? id;
  DateTime? adoptedDate;
  AdoptionModel({this.adoptedDate, this.id});
  factory AdoptionModel.fromJson(Map<dynamic, dynamic> json) => AdoptionModel(
        adoptedDate: json['adoptedDate'],
        id: json["id"],
      );
}
