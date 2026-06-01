import 'anp_model.dart';

class ANPRepository {
  static const List<ANPModel> anpDatabase = [
    ANPModel(
      id: "anp_manu_001",
      name: "Parque Nacional del Manu",
      category: "Parque Nacional",
      useType: "Indirecto (Intangible)",
      regions: ["Madre de Dios", "Cusco"],
      extensionHa: 1716295.22,
      establishedYear: 1973,
      keyFauna: ["Gallito de las rocas", "Caimán negro", "Jaguar"],
      svgAssetPath: "assets/vectors/anp/manu.svg",
      mnemonicHint: "Manu es el pulmón gigante que comparten Madre de Dios y Cusco; recuerda al Gallito de las rocas saltando en la selva alta.",
    ),
    ANPModel(
      id: "anp_huascaran_002",
      name: "Parque Nacional Huascarán",
      category: "Parque Nacional",
      useType: "Indirecto (Intangible)",
      regions: ["Áncash"],
      extensionHa: 340000.0,
      establishedYear: 1975,
      keyFauna: ["Oso de anteojos", "Cóndor andino", "Vicuña"],
      svgAssetPath: "assets/vectors/anp/huascaran.svg",
      mnemonicHint: "El Huascarán es la montaña más alta; refugio del oso de anteojos y cóndores en Áncash.",
    ),
    ANPModel(
      id: "anp_paracas_003",
      name: "Reserva Nacional de Paracas",
      category: "Reserva Nacional",
      useType: "Directo (Tangible/Sostenible)",
      regions: ["Ica"],
      extensionHa: 335000.0,
      establishedYear: 1975,
      keyFauna: ["Lobo marino", "Pingüino de Humboldt", "Flamenco"],
      svgAssetPath: "assets/vectors/anp/paracas.svg",
      mnemonicHint: "Paracas es la costa que preserva al pingüino y al lobo marino; zona de uso sostenible en Ica.",
    ),
    ANPModel(
      id: "anp_machupicchu_004",
      name: "Santuario Histórico de Machupicchu",
      category: "Santuario Histórico",
      useType: "Indirecto (Intangible)",
      regions: ["Cusco"],
      extensionHa: 32592.0,
      establishedYear: 1981,
      keyFauna: ["Oso de anteojos", "Gallito de las rocas", "Puma"],
      svgAssetPath: "assets/vectors/anp/machupicchu.svg",
      mnemonicHint: "La ciudadela Inca por excelencia; santuario histórico que protege el legado en Cusco.",
    ),
    ANPModel(
      id: "anp_huayllay_005",
      name: "Santuario Nacional de Huayllay",
      category: "Santuario Nacional",
      useType: "Indirecto (Intangible)",
      regions: ["Pasco"],
      extensionHa: 6815.0,
      establishedYear: 1974,
      keyFauna: ["Vicuña", "Zorro andino", "Gato montés"],
      svgAssetPath: "assets/vectors/anp/huayllay.svg",
      mnemonicHint: "Un bosque de piedras en Pasco; santuario nacional de asombrosa formación geológica.",
    ),
  ];

  static List<ANPModel> getAllANPs() {
    return anpDatabase;
  }

  static List<ANPModel> getANPsByCategory(String category) {
    return anpDatabase.where((anp) => anp.category == category).toList();
  }

  static List<ANPModel> getANPsByUseType(String useType) {
    return anpDatabase.where((anp) => anp.useType == useType).toList();
  }
}
