import 'dart:io';
import 'package:drug_addiction/core/constants/colors.dart';
import 'package:drug_addiction/core/constants/text_styles.dart';
import 'package:drug_addiction/core/enums/view_state.dart';
import 'package:drug_addiction/core/models/pick_image_model.dart';
import 'package:drug_addiction/core/view_models/base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class PickImagesViewModel extends BaseViewModel {
  PickImageModel pickImageModel = PickImageModel();
  List<PickImageModel> pickImageList = [];
  bool isImageTaken = false;

  PickImagesViewModel();

  void pickGalleryImage(context) async {
    pickImageModel = PickImageModel();
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      pickImageModel.image = File(pickedImage.path);
      pickImageModel.path = pickedImage.path;
      showAlertDialog(
        context: context,
        image: pickImageModel.image,
        onPressed: () {
          addRecord();
          Navigator.pop(context);
        },
      );
      notifyListeners();
    } else {
      print('Exception image Picker');
    }
  }

  void pickCameraImage(context) async {
    pickImageModel = PickImageModel();
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedImage != null) {
      pickImageModel.image = File(pickedImage.path);
      pickImageModel.path = pickedImage.path;
      showAlertDialog(
        context: context,
        image: pickImageModel.image,
        onPressed: () {
          addRecord();
          Navigator.pop(context);
        },
      );
      notifyListeners();
    } else {
      print('Exception image Picker');
    }
  }

  Future classifyImage() async {
    await Tflite.loadModel(
        model: "images/model_unquant.tflite", labels: "images/labels.txt");
    var output = await Tflite.runModelOnImage(path: pickImageModel.path);
    pickImageModel.result = output.toString();
    pickImageModel.confidence = pickImageModel.result.split(",");
    pickImageModel.confidenceString = pickImageModel.confidence[0].split(" ");
    print(pickImageModel.confidenceString[0]);
    var percent = double.parse(pickImageModel.confidenceString[1]);
    var per = percent * 100;
    pickImageModel.confidenceValue = (per).toStringAsFixed(1);
    print(pickImageModel.confidence[2]);
    var res = pickImageModel.confidence[2].split("}");
    pickImageModel.norcoticsResult = res[0].split(" ");
    print('result => ${pickImageModel.norcoticsResult[3]}');
  }

  void addRecord() async {
    setState(ViewState.busy);
    await classifyImage();
    pickImageList.add(pickImageModel);
    setState(ViewState.idle);
  }

  void showAlertDialog({BuildContext context, File image, Function onPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Image.file(
            pickImageModel.image,
          ),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: halfBoldTextStyle.copyWith(color: whiteColor),
                )),
            // ignore: deprecated_member_use
            FlatButton(
                onPressed: onPressed,
                child: Text(
                  'Process',
                  style: halfBoldTextStyle.copyWith(color: whiteColor),
                ))
          ],
        );
      },
    );
  }
}
