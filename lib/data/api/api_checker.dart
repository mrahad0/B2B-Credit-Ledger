

import 'package:flutter_extension/views/base/custom_snackbar.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response, {bool getXSnackBar = false}) {
    if(response.statusCode == 401) {
      // Show error message for invalid credentials
      showCustomSnackBar(response.statusText, getXSnackBar: getXSnackBar);
      // TODO: For token expiration, add logic to clear user data and navigate to sign-in screen
    } else {
      showCustomSnackBar(response.statusText, getXSnackBar: getXSnackBar);
    }
  }
}
