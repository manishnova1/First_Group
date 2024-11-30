import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../locator/locator.dart';
import 'navigation_service.dart';

class PickImage {
  ImagePicker _picker = ImagePicker();
  XFile? _image;

  XFile? imagePicker1(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () async {
                      _image = await _picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 50);
                      locator<NavigationService>().pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    _image =
                        await _picker.pickImage(source: ImageSource.camera);
                    locator<NavigationService>().pop();
                  },
                ),
              ],
            ),
          );
        });

    return _image;
  }
}
