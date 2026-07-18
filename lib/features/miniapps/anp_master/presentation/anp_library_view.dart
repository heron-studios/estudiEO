import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/core/config/neural_theme.dart';
import 'package:learn/core/widgets/neural_background_wrapper.dart';
import 'package:learn/core/widgets/glass_card_widget.dart';
import '../data/anp_repository.dart';
import '../data/anp_model.dart';

class ANPLibraryView extends StatefulWidget {
  const ANPLibraryView({super.key});

  @override
  State<ANPLibraryView> createState() => _ANPLibraryViewState();
}

class _ANPLibraryViewState extends State<ANPLibraryView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<ANPModel> _anps = ANPRepository.getAllANPs();

  String _searchQuery = '';
  String _catalogFilter = 'Todos';
  static const List<String> _catalogFilters = [
    'Todos',
    'Uso Indirecto',
    'Uso Directo',
    'Parque Nacional',
    'Reserva Nacional',
  ];

  // Comparator sort
  String _sortBy = 'Extensión';
  bool _sortAscending = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nt = NeuralTheme.of(context);

    return Scaffold(
      backgroundColor: nt.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Biblioteca del SINANPE',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: nt.blueGoogle,
          labelColor: nt.blueGoogle,
          unselectedLabelColor: Colors.white60,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: const [
            Tab(text: 'General'),
            Tab(text: 'Catálogo'),
            Tab(text: 'Gestión'),
            Tab(text: 'Comparador'),
          ],
        ),
      ),
      body: NeuralBackgroundWrapper(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildGeneralTab(nt),
                _buildCatalogTab(nt),
                _buildManagementTab(nt),
                _buildComparatorTab(nt),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Tab 1: General ────────────────────────────────────────────────────────
  Widget _buildGeneralTab(NeuralThemeData nt) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGlassSection(
            nt: nt,
            title: '¿Qué es el SINANPE?',
            icon: Icons.shield_rounded,
            iconColor: nt.blueGoogle,
            content:
                'El Sistema Nacional de Áreas Naturales Protegidas por el Estado (SINANPE) es el conjunto de áreas naturales protegidas por el Estado en todas sus categorías. Su objetivo es conservar la diversidad biológica del Perú, sus recursos y valores de interés cultural, científico y paisajístico.\n\nLa autoridad técnico-normativa responsable es el SERNANP, adscrito al Ministerio del Ambiente (MINAM).',
          ),
          const SizedBox(height: 20),
          _buildLawSection(nt),
          const SizedBox(height: 20),
          _buildGlassSection(
            nt: nt,
            title: 'Compromisos Internacionales',
            icon: Icons.language_rounded,
            iconColor: nt.purple,
            content:
                '• ODS 14 (Vida submarina): Conservar océanos y recursos marinos.\n• ODS 15 (Vida de ecosistemas terrestres): Detener la pérdida de biodiversidad.\n• Meta Aichi 11: Las ANP deben formar "Sistemas Ecológicamente Representativos y Bien Conectados", no solo islas aisladas.',
          ),
          const SizedBox(height: 20),
          _buildKeyFactsSection(nt),
        ],
      ),
    );
  }

  Widget _buildKeyFactsSection(NeuralThemeData nt) {
    final facts = [
      ('76+', 'ANPs en el SINANPE', nt.successGreen),
      ('22M+', 'Hectáreas protegidas', nt.blueGoogle),
      ('17%', 'Del territorio nacional', nt.warningAmber),
      ('1961', 'Año de la primera ANP (PN Cutervo)', nt.pink),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bar_chart_rounded, color: nt.cyan, size: 22),
            const SizedBox(width: 10),
            const Text(
              'SINANPE en Números',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.5,
          children: facts.map((f) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: f.$3.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: f.$3.withValues(alpha: 0.25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    f.$1,
                    style: TextStyle(
                      color: f.$3,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    f.$2,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLawSection(NeuralThemeData nt) {
    return StaticGlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.gavel_rounded, color: nt.pink, size: 24),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Diferencia Jurídica Central (Ley N° 26834)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTypeRow(
            nt: nt,
            title: 'Uso Indirecto (Intangible)',
            desc:
                'Se prohíbe la extracción de recursos naturales y la modificación del ambiente natural. Solo se permite investigación, recreación y turismo regulado.',
            badgeColor: nt.pink,
            categories:
                'Parques Nacionales, Santuarios Nacionales, Santuarios Históricos',
          ),
          const Divider(color: Colors.white10, height: 24),
          _buildTypeRow(
            nt: nt,
            title: 'Uso Directo (Tangible/Sostenible)',
            desc:
                'Permite el aprovechamiento de recursos naturales, prioritariamente por poblaciones locales, bajo planes de manejo aprobados por el SERNANP.',
            badgeColor: nt.successGreen,
            categories:
                'Reservas Nacionales, Reservas Comunales, Bosques de Protección, Cotos de Caza, Refugios de Vida Silvestre',
          ),
        ],
      ),
    );
  }

  Widget _buildTypeRow({
    required NeuralThemeData nt,
    required String title,
    required String desc,
    required Color badgeColor,
    required String categories,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: badgeColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: badgeColor.withValues(alpha: 0.3)),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: badgeColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          desc,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Categorías: $categories',
          style: TextStyle(
            color: nt.textMuted,
            fontSize: 11,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildGlassSection({
    required NeuralThemeData nt,
    required String title,
    required IconData icon,
    required Color iconColor,
    required String content,
  }) {
    return StaticGlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            content,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Tab 2: Catalog ────────────────────────────────────────────────────────
  Widget _buildCatalogTab(NeuralThemeData nt) {
    final filtered = _anps.where((anp) {
      final matchSearch =
          _searchQuery.isEmpty ||
          anp.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          anp.regions.any(
            (r) => r.toLowerCase().contains(_searchQuery.toLowerCase()),
          ) ||
          anp.category.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchFilter = switch (_catalogFilter) {
        'Uso Indirecto' => anp.useType.contains('Indirecto'),
        'Uso Directo' => anp.useType.contains('Directo'),
        _ => _catalogFilter == 'Todos' ? true : anp.category == _catalogFilter,
      };

      return matchSearch && matchFilter;
    }).toList();

    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: TextField(
            onChanged: (val) => setState(() => _searchQuery = val),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Buscar por nombre, región o categoría...',
              hintStyle: const TextStyle(color: Colors.white38),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: Colors.white60,
              ),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: nt.blueGoogle),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        // Filter chips
        SizedBox(
          height: 36,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _catalogFilters.length,
            itemBuilder: (context, i) {
              final filter = _catalogFilters[i];
              final isActive = filter == _catalogFilter;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => _catalogFilter = filter),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? nt.blueGoogle.withValues(alpha: 0.2)
                          : Colors.white.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isActive
                            ? nt.blueGoogle.withValues(alpha: 0.6)
                            : Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: isActive ? nt.blueGoogle : Colors.white38,
                        fontSize: 11,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                '${filtered.length} áreas encontradas',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final anp = filtered[index];
              final isIndirect = anp.useType.contains('Indirecto');
              final Color catColor = _categoryColor(anp.category, nt);

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: StaticGlassContainer(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: catColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: catColor.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Icon(
                              _categoryIcon(anp.category),
                              color: catColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              anp.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: (isIndirect ? nt.pink : nt.successGreen)
                                  .withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: (isIndirect ? nt.pink : nt.successGreen)
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              isIndirect ? 'Indirecto' : 'Directo',
                              style: TextStyle(
                                color: isIndirect ? nt.pink : nt.successGreen,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _infoChip(
                            Icons.landscape_rounded,
                            anp.category,
                            catColor,
                            nt,
                          ),
                          _infoChip(
                            Icons.calendar_today_rounded,
                            'Est. ${anp.establishedYear}',
                            nt.purple,
                            nt,
                          ),
                          _infoChip(
                            Icons.map_rounded,
                            anp.regions.join(', '),
                            nt.blueGoogle,
                            nt,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lightbulb_rounded,
                            color: nt.warningAmber,
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              anp.mnemonicHint,
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _infoChip(
    IconData icon,
    String label,
    Color color,
    NeuralThemeData nt,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color.withValues(alpha: 0.7), size: 11),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Color _categoryColor(String cat, NeuralThemeData nt) {
    switch (cat) {
      case 'Parque Nacional':
        return nt.successGreen;
      case 'Reserva Nacional':
        return nt.blueGoogle;
      case 'Santuario Nacional':
        return nt.warningAmber;
      case 'Santuario Histórico':
        return nt.pink;
      default:
        return nt.cyan;
    }
  }

  IconData _categoryIcon(String cat) {
    switch (cat) {
      case 'Parque Nacional':
        return Icons.park_rounded;
      case 'Reserva Nacional':
        return Icons.nature_rounded;
      case 'Santuario Nacional':
        return Icons.eco_rounded;
      case 'Santuario Histórico':
        return Icons.account_balance_rounded;
      default:
        return Icons.landscape_rounded;
    }
  }

  // ─── Tab 3: Management ─────────────────────────────────────────────────────
  Widget _buildManagementTab(NeuralThemeData nt) {
    final List<Map<String, dynamic>> tools = [
      {
        'title': 'Plan Maestro',
        'subtitle': 'El máximo instrumento de planificación',
        'desc':
            'Aprobado por el SERNANP, se revisa cada 5 años. Define la zonificación oficial del ANP, sus programas de manejo y estrategias de conservación a largo plazo.',
        'color': nt.blueGoogle,
        'icon': Icons.menu_book_rounded,
        'tag': 'Cada 5 años',
      },
      {
        'title': 'Plan de Sitio',
        'subtitle': 'Microzonificación y regulación turística',
        'desc':
            'Establece pautas físicas locales en el terreno. Determina la Capacidad de Carga Aceptable (CCA) y el Límite de Cambio Aceptable (LAC) para regular el turismo.',
        'color': nt.cyan,
        'icon': Icons.location_searching_rounded,
        'tag': 'Sitios específicos',
      },
      {
        'title': 'Radar de la Participación',
        'subtitle': 'Métrica de inclusión comunitaria',
        'desc':
            'Instrumento semestral oficial del SERNANP que evalúa el nivel de inclusión, organización y efectividad de los actores locales en el Comité de Gestión.',
        'color': nt.successGreen,
        'icon': Icons.radar_rounded,
        'tag': 'Semestral',
      },
      {
        'title': 'INDIMAPA',
        'subtitle': 'Métrica de auditoría integral',
        'desc':
            'Índice de Implementación y Gestión de Áreas Protegidas, evaluado por la Contraloría. Mide el grado (Alto/Medio/Bajo) según personal, presupuesto, saneamiento físico-legal y planes.',
        'color': nt.pink,
        'icon': Icons.bar_chart_rounded,
        'tag': 'Contraloría',
      },
      {
        'title': 'Alertas Tempranas (ATD)',
        'subtitle': 'Vigilancia satelital de deforestación',
        'desc':
            'Tecnología satelital del MINAM para detectar en tiempo real pérdidas de cobertura forestal y bosque primario amazónico por impacto antrópico dentro de las ANP.',
        'color': nt.warningAmber,
        'icon': Icons.satellite_alt_rounded,
        'tag': 'Tiempo real',
      },
      {
        'title': 'Sistema SMART',
        'subtitle': 'Monitoreo de patrullaje inteligente',
        'desc':
            'Spatial Monitoring and Reporting Tool. Herramienta tecnológica usada por guardaparques para georreferenciar incidentes, amenazas y patrullajes preventivos.',
        'color': nt.purple,
        'icon': Icons.mobile_friendly_rounded,
        'tag': 'Campo',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: tools.length,
      itemBuilder: (context, index) {
        final tool = tools[index];
        final color = tool['color'] as Color;
        return Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: StaticGlassContainer(
            padding: const EdgeInsets.all(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: color.withValues(alpha: 0.3)),
                  ),
                  child: Icon(tool['icon'] as IconData, color: color, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              tool['title'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              tool['tag'] as String,
                              style: TextStyle(
                                color: color,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        tool['subtitle'] as String,
                        style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        tool['desc'] as String,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─── Tab 4: Comparator ─────────────────────────────────────────────────────
  Widget _buildComparatorTab(NeuralThemeData nt) {
    final sortedAnps = [..._anps];
    final maxExt = sortedAnps
        .map((a) => a.extensionHa)
        .reduce((a, b) => a > b ? a : b);

    switch (_sortBy) {
      case 'Extensión':
        sortedAnps.sort(
          (a, b) => _sortAscending
              ? a.extensionHa.compareTo(b.extensionHa)
              : b.extensionHa.compareTo(a.extensionHa),
        );
        break;
      case 'Año':
        sortedAnps.sort(
          (a, b) => _sortAscending
              ? a.establishedYear.compareTo(b.establishedYear)
              : b.establishedYear.compareTo(a.establishedYear),
        );
        break;
      case 'Nombre':
        sortedAnps.sort(
          (a, b) => _sortAscending
              ? a.name.compareTo(b.name)
              : b.name.compareTo(a.name),
        );
        break;
    }

    return Column(
      children: [
        // Sort controls
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Text(
                'Ordenar por:',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 10),
              ...['Extensión', 'Año', 'Nombre'].map((s) {
                final isActive = s == _sortBy;
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_sortBy == s) {
                          _sortAscending = !_sortAscending;
                        } else {
                          _sortBy = s;
                          _sortAscending = false;
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? nt.blueGoogle.withValues(alpha: 0.2)
                            : Colors.white.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isActive
                              ? nt.blueGoogle.withValues(alpha: 0.5)
                              : Colors.white12,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            s,
                            style: TextStyle(
                              color: isActive ? nt.blueGoogle : Colors.white38,
                              fontSize: 11,
                              fontWeight: isActive
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          if (isActive) ...[
                            const SizedBox(width: 3),
                            Icon(
                              _sortAscending
                                  ? Icons.arrow_upward_rounded
                                  : Icons.arrow_downward_rounded,
                              color: nt.blueGoogle,
                              size: 12,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),

        // Table header
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(flex: 3, child: _TableHeader('Área Natural')),
              Expanded(flex: 2, child: _TableHeader('Extensión')),
              Expanded(flex: 1, child: _TableHeader('Año')),
              Expanded(flex: 1, child: _TableHeader('Uso')),
            ],
          ),
        ),
        const SizedBox(height: 8),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: sortedAnps.length,
            itemBuilder: (context, index) {
              final anp = sortedAnps[index];
              final isIndirect = anp.useType.contains('Indirecto');
              final relSize = anp.extensionHa / maxExt;
              final catColor = _categoryColor(anp.category, nt);

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.06),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: catColor,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    anp.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${(anp.extensionHa / 1000).toStringAsFixed(0)}K Ha',
                              style: TextStyle(
                                color: nt.cyan,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              '${anp.establishedYear}',
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 11,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isIndirect ? nt.pink : nt.successGreen,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Extension bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: SizedBox(
                          height: 4,
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.white.withValues(alpha: 0.06),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                width:
                                    (MediaQuery.of(context).size.width - 64) *
                                    relSize,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      catColor.withValues(alpha: 0.7),
                                      catColor,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Legend
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendDot(nt.pink, 'Uso Indirecto'),
              const SizedBox(width: 16),
              _legendDot(nt.successGreen, 'Uso Directo'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 11),
        ),
      ],
    );
  }
}

class _TableHeader extends StatelessWidget {
  final String text;
  const _TableHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white38,
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
      textAlign: TextAlign.center,
    );
  }
}
