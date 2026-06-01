class ChemicalElement {
  final String symbol;
  final String name;
  final int atomicNumber;
  final String family;
  final int group;
  final int period;
  // Position in standard periodic table grid (1-based)
  final int gridColumn;
  final int gridRow;

  const ChemicalElement({
    required this.symbol,
    required this.name,
    required this.atomicNumber,
    required this.family,
    required this.group,
    required this.period,
    required this.gridColumn,
    required this.gridRow,
  });
}
