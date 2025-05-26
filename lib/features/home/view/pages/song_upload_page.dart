import 'dart:io';

import 'package:client/core/theme/pallete.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/custom_field.dart';
import 'package:client/features/home/view/widgets/audio_wave.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SognUploadPage extends ConsumerStatefulWidget {
  const SognUploadPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SognUploadPageState();
}

class _SognUploadPageState extends ConsumerState<SognUploadPage> {
  File? selectedImage;
  File? selectedAudio;
  Color selectedColor = Pallete.cardColor;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _songNameController = TextEditingController();

  void selectAudio() async {
    final pickedAudio = await pickAudio();
    if (pickedAudio != null) {
      setState(() {
        selectedAudio = pickedAudio;
      });
    }
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _artistController.dispose();
    _songNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Song'),
        actions: [
          IconButton(
            onPressed: () async {
              // if (_formKey.currentState!.validate() &&
              //     selectedAudio != null &&
              //     selectedImage != null) {
              //   ref
              //       .read(homeViewModelProvider.notifier)
              //       .uploadSong(
              //         selectedAudio: selectedAudio!,
              //         selectedThumbnail: selectedImage!,
              //         songName: _songNameController.text.trim(),
              //         artist: _artistController.text.trim(),
              //         selectedColor: selectedColor,
              //       );
              // } else {
              //   showSnackBar(context, 'Missing fields!');
              // }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: selectImage,
                    child:
                        selectedImage != null
                            ? SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                            : Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Pallete.borderColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.folder_open, size: 40),
                                  SizedBox(height: 15),
                                  Text(
                                    "Select Image",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                  ),
                  const SizedBox(height: 20),
                  selectedAudio != null
                      ? AudioWave(path: selectedAudio!.path)
                      : CustomField(
                        hintText: 'Pick Song',
                        controller: null,
                        readOnly: true,
                        onTap: selectAudio,
                      ),
                  const SizedBox(height: 20),
                  CustomField(
                    hintText: 'Artist',
                    controller: _artistController,
                  ),
                  const SizedBox(height: 20),
                  CustomField(
                    hintText: 'Song Name',
                    controller: _songNameController,
                  ),
                  const SizedBox(height: 20),
                  ColorPicker(
                    pickersEnabled: const {ColorPickerType.wheel: true},
                    color: selectedColor,
                    onColorChanged: (Color color) {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
