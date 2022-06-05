extension MessageExceptionExtension on String {
  String exception() {
    return replaceAll('Exception:', '');
  }
}