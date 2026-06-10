class ANPModel {
  final String id;
  final String name;
  final String category;
  final String useType;
  final List<String> regions;
  final double extensionHa;
  final int establishedYear;
  final List<String> keyFauna;
  final String svgAssetPath;
  final String mnemonicHint;
  final double relativeX;
  final double relativeY;

  const ANPModel({
    required this.id,
    required this.name,
    required this.category,
    required this.useType,
    required this.regions,
    required this.extensionHa,
    required this.establishedYear,
    required this.keyFauna,
    required this.svgAssetPath,
    required this.mnemonicHint,
    required this.relativeX,
    required this.relativeY,
  });

  factory ANPModel.fromJson(Map<String, dynamic> json) {
    return ANPModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      useType: json['use_type'] as String,
      regions: List<String>.from(json['regions'] as List),
      extensionHa: (json['extension_ha'] as num).toDouble(),
      establishedYear: json['established_year'] as int,
      keyFauna: List<String>.from(json['key_fauna'] as List),
      svgAssetPath: json['svg_asset_path'] as String,
      mnemonicHint: json['mnemonic_hint'] as String,
      relativeX: (json['relative_x'] as num?)?.toDouble() ?? 0.5,
      relativeY: (json['relative_y'] as num?)?.toDouble() ?? 0.5,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'use_type': useType,
      'regions': regions,
      'extension_ha': extensionHa,
      'established_year': establishedYear,
      'key_fauna': keyFauna,
      'svg_asset_path': svgAssetPath,
      'mnemonic_hint': mnemonicHint,
      'relative_x': relativeX,
      'relative_y': relativeY,
    };
  }
}
