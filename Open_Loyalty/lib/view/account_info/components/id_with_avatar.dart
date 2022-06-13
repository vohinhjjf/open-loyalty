import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_loyalty/constant.dart';

class IdWithAvatar extends StatelessWidget {
  PickedFile? imageFile ;
  final ImagePicker picker = ImagePicker();

  IdWithAvatar({
    Key? key,
    required this.imageFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Stack(children: [
        buildImage(mPrimaryColor),
        Positioned(
          child: buildEditIcon(context,mPrimaryColor),
          right: 0,
          top: 7,
        )
      ])
    );
  }

  // Builds Profile Image
  Widget buildImage(Color color) {
    final image = imageFile == null
    ? AssetImage("assets/images/user.jfif")
    : FileImage(File(imageFile!.path),
    );

    return CircleAvatar(
      radius: 75,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: image as ImageProvider,
        radius: 70,
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(BuildContext context,Color color) => buildCircle(
      all: 0,
      child:
      IconButton(
        onPressed: () {
          print(imageFile!.path);
          showModalBottomSheet(
            context: context,
            builder: ((builder) => bottomSheet(context)),
          );
        },
        icon: Icon(
          Icons.edit,
          color: color,
          size: 20,
        ),
      ),
      );

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
            padding: EdgeInsets.all(all),
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color(0x99FFFFFF),
                  Colors.white
                ]),
                borderRadius: BorderRadius.circular(45),
                border:
                Border.all(color: mPrimaryColor, width: 2)),
            child: child,
          ));

  Widget test() {
    if (imageFile == null) {
      return const Text("");
    } else {
      return Image.file(
        File(imageFile!.path),
        width: 60,
        height: 60,
      );
    }
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text("Chọn ảnh hoặc video", style: TextStyle(fontSize: footnote)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton.icon(
                  onPressed: () => _openGallary(context, ImageSource.camera),
                  icon: const Icon(Icons.camera),
                  label: const Text("Camera", style: TextStyle(fontSize: footnote))),
              FlatButton.icon(
                  onPressed: () => _openGallary(context, ImageSource.gallery),
                  icon: const Icon(Icons.collections),
                  label: const Text("Thư viện", style: TextStyle(fontSize: footnote)))
            ],
          )
        ],
      ),
    );
  }

  void _openGallary(BuildContext context, ImageSource source) async {
    final media = await picker.getImage(source: source);

    imageFile = media!;

    Navigator.of(context).pop();
  }
}
