import 'package:drug_addiction/core/constants/colors.dart';
import 'package:drug_addiction/core/constants/text_styles.dart';
import 'package:drug_addiction/core/view_models/pick_images_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatelessWidget {
  final String result;
  ResultScreen({this.result});

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
                size: 25,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(15.0),
            child: ListView(
              children: [
                model.pickImageModel.image == null
                    ? Text('Image not taken yet')
                    : Padding(
                        padding: EdgeInsets.all(20.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            model.pickImageModel.image,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.4,
                          ),
                        )),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text(
                      '\t\tResult: ',
                      style: boldTextStyle.copyWith(color: whiteColor),
                    ),
                    Text(
                      '${model.pickImageModel.norcoticsResult[3]}',
                      style: boldTextStyle.copyWith(color: whiteColor),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text(
                      '\t\tAccuracy: ',
                      style: boldTextStyle.copyWith(color: whiteColor),
                    ),
                    Text(
                      '${model.pickImageModel.confidenceValue}%',
                      style: boldTextStyle.copyWith(color: whiteColor),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
