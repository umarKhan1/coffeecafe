class ProductIdMapper {
  const ProductIdMapper._();
  static String fromTitle(String title) => title
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9 ]'), '')
      .replaceAll(' ', '_');
}
