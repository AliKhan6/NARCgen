import 'dart:io';

class PickImageModel {
  String id;
  File image;
  String path;
  var confidence;
  var confidenceString;
  var confidenceValue;
  String result;
  var norcoticsResult;

  PickImageModel(
      {this.id,
      this.image,
      this.path,
      this.result,
      this.confidence,
      this.confidenceString,
      this.confidenceValue,
      this.norcoticsResult});

  PickImageModel.fromJson(Map<String, dynamic> json, id) {
    this.id = id;
    image = json['image'];
    path = json['path'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['path'] = this.path;
    data['result'] = this.result;
    return data;
  }
}
