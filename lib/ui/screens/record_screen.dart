import 'package:drug_addiction/core/constants/colors.dart';
import 'package:drug_addiction/core/view_models/pick_images_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PickImagesViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: backGroundColor,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: backGroundColor,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: whiteColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: ListView.builder(
            itemCount: model.pickImageList.length,
            itemBuilder: (context, index) {
              return Image.file(
                model.pickImageList[index].image,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
              );
            },
          ),
        );
      },
    );
  }
}
