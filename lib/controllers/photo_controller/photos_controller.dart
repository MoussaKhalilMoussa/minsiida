import 'dart:io';

import 'package:get/get.dart';

class PhotosController extends GetxController {

  RxBool isLoading = false.obs;

  RxBool get loading => isLoading;

  RxBool isError = false.obs;
  RxBool get error => isError; 

  
  // Store selected images
  RxList<File> selectedImages = <File>[].obs;
  List<File> get images => selectedImages;

  
 }