extension MessageExceptionExtension on String {
  String exception() {
    return replaceAll('Exception:', '');
  }
}

extension IterableModifier<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) =>
      cast<E?>().firstWhere((v) => v != null && test(v), orElse: () => null);
}