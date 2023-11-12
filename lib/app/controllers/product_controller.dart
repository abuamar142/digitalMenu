import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> data) async {
    try {
      var result = await firestore.collection('products').add(data);
      await firestore.collection('products').doc(result.id).update(
        {'productId': result.id},
      );

      if (data['imageURL'] == null) {
        return {
          'error': false,
          'message': 'Successfully added product without product image',
        };
      } else {
        return {
          'error': false,
          'message': 'Successfully added product',
        };
      }
    } catch (e) {
      return {
        'error': true,
        'message': 'Failed to add product',
      };
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamProducts() async* {
    yield* firestore.collection('products').snapshots();
  }

  Future<Map<String, dynamic>> updateProduct(Map<String, dynamic> data) async {
    try {
      await firestore.collection('products').doc(data['productId']).update({
        'name': data['name'],
        'price': data['price'],
        'description': data['description'],
        'imageURL': data['imageURL'],
      });

      return {
        'error': false,
        'message': 'Successfully update the product',
      };
    } catch (e) {
      return {
        'error': true,
        'message': e,
      };
    }
  }

  Future<Map<String, dynamic>> deleteProduct(String productId, String downloadURL) async {
    try {
      print("download url : ${downloadURL.toString()}");
      print("download url : ${downloadURL.isNotEmpty}");
      if (downloadURL.isNotEmpty) {
        Reference storageRef = storage.refFromURL(downloadURL);
        await storageRef.delete();
      } else {
        await firestore.collection('products').doc(productId).delete();

        return {
          'error': true,
          'message': 'Product details removed apart from images',
        };
      }

      await firestore.collection('products').doc(productId).delete();

      return {
        'error': false,
        'message': 'Successfully deleted the product',
      };
    } catch (e) {
      return {
        'error': true,
        'message': e,
      };
    }
  }

  Future<Map<String, dynamic>> uploadFileToFirebaseStorage(String filePath, String fileName) async {
    final Reference storageReference = storage.ref().child(fileName);
    final UploadTask uploadTask = storageReference.putFile(File(filePath));

    try {
      await uploadTask.whenComplete(() => null);
      String downloadURL = await storageReference.getDownloadURL();
      return {
        'error': false,
        'message': 'File uploaded successfully',
        'downloadURL': downloadURL,
      };
    } on FirebaseException catch (e) {
      return {
        'error': true,
        'message': 'Error uploading file: $e',
      };
    }
  }

  Future<Map<String, dynamic>> deleteFile(String downloadURL) async {
    try {
      Reference storageRef = storage.refFromURL(downloadURL);
      await storageRef.delete();
      return {
        'error': false,
        'message': 'Successfully deleted the product',
      };
    } catch (e) {
      return {
        'error': true,
        'message': e,
      };
    }
  }

  Future<Map<String, dynamic>> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        allowCompression: true,
      );
      if (result != null && result.files.isNotEmpty) {
        final PlatformFile file = result.files.first;

        // Mendapatkan path file
        String? pathToFile = file.path;

        // Mendapatkan nama file
        int? fileSize = file.size;

        if (pathToFile != null) {
          if (pathToFile.isNotEmpty && fileSize <= 1000000) {
            return {
              'error': false,
              'message': 'Successfully get file',
              'path_to_file': pathToFile,
            };
          } else if (fileSize > 1000000) {
            return {
              'error': true,
              'message': 'Select a file with a size under 1 MB',
            };
          }
        }
      }

      return {
        'error': true,
        'message': 'No file selected',
      };
    } catch (e) {
      return {
        'error': true,
        'message': e.toString(),
      };
    }
  }
}
