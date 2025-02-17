extension NullableStringExtension on String? {
  bool get isNullEmpty => (this ?? '').isEmpty;

  bool get isNullNotEmpty => (this ?? '').isNotEmpty;
}
