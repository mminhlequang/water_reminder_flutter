class AssetIconPaths {
  static const String _basePath = 'assets/images';
  static const String bottle = '$_basePath/ic_bottle.png';
  static const String minus = '$_basePath/ic_minus.png';
  static const String plus = '$_basePath/ic_plus.png';
  static const String upArrow = '$_basePath/ic_up_arrow.png';

  static const String empty100 = '$_basePath/ic_empty_100.png';
  static const String empty150 = '$_basePath/ic_empty_150.png';
  static const String empty250 = '$_basePath/ic_empty_250.png';
  static const String empty500 = '$_basePath/ic_empty_500.png';

  static const String fill100 = '$_basePath/ic_fill_100.png';
  static const String fill150 = '$_basePath/ic_fill_150.png';
  static const String fill250 = '$_basePath/ic_fill_250.png';
  static const String fill500 = '$_basePath/ic_fill_500.png';

  static const String fillPlus100 = '$_basePath/ic_fill_plus_100.webp';
  static const String fillPlus150 = '$_basePath/ic_fill_plus_150.png';
  static const String fillPlus250 = '$_basePath/ic_fill_plus_250.webp';
  static const String fillPlus500 = '$_basePath/ic_fill_plus_500.webp';

  static const Map<int, Map<String, String>> mapCapcityWithIconPath = {
    100: {'empty': empty100, 'fill': fill100, 'fillPlus': fillPlus100},
    150: {'empty': empty150, 'fill': fill150, 'fillPlus': fillPlus150},
    250: {'empty': empty250, 'fill': fill250, 'fillPlus': fillPlus250},
    500: {'empty': empty500, 'fill': fill500, 'fillPlus': fillPlus500},
  };
}
