import 'dart:async';
import 'dart:io';

// TODO: implement localization
sealed class ErrorMessages {
  static String handleExceptionWithMessage(dynamic error) {
    if (error is SocketException) {
      return "It seems you've entered wrong address or you are not connected to the internet.";
    } else if (error is TimeoutException) {
      return "The request timed out. Ensure you have a stable internet connection";
    } else if (error is ArgumentError) {
      return "Wrong URI format";
    } else {
      return "An error occurred, please try again";
    }
  }
}
