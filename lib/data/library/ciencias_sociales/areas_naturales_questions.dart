import 'package:learn/models/question.dart';

final List<Question> areasNaturalesQuestions = [
  // ====== NIVEL FÁCIL ======
  Question(
    id: "pfrh_anp_easy_1",
    topicId: "cs_t3",
    text: r"""En el marco normativo e institucional peruano, ¿qué entidad pública ejerce la rectoría como autoridad técnico-normativa exclusiva del Sistema Nacional de Áreas Naturales Protegidas por el Estado (SINANPE)?""",
    options: [
      r"""Organismo de Evaluación y Fiscalización Ambiental (OEFA)""",
      r"""Instituto Nacional de Recursos Naturales (INRENA)""",
      r"""Servicio Nacional de Áreas Naturales Protegidas por el Estado (SERNANP)""",
      r"""Ministerio de Cultura (MINCUL)""",
    ],
    correctAnswer: 2,
    explanation: r"""El SERNANP, adscrito al Ministerio del Ambiente (MINAM), es el ente rector responsable de dirigir, administrar y normar todo el SINANPE a nivel nacional, garantizando la conservación de la biodiversidad.""",
  ),

  Question(
    id: "pfrh_anp_easy_2",
    topicId: "cs_t3",
    text: r"""¿Cuál es la restricción legal primordial que diferencia y caracteriza a las "Áreas de Uso Indirecto" frente a las demás categorías del SINANPE?""",
    options: [
      r"""Permiten el aprovechamiento comercial forestal únicamente a comunidades nativas.""",
      r"""Son zonas de protección intangible en las que no se permite la extracción de recursos naturales ni modificaciones del ambiente natural.""",
      r"""Autorizan la minería artesanal formalizada por el Estado en sus zonas de amortiguamiento.""",
      r"""Permiten asentamientos humanos temporales para el turismo vivencial extractivo.""",
    ],
    correctAnswer: 1,
    explanation: r"""Las áreas de uso indirecto (como los Parques Nacionales) poseen carácter estrictamente intangible; prohíben cualquier extracción de recursos o transformación del ecosistema, admitiendo únicamente investigación y turismo regulado.""",
  ),

  // ====== NIVEL MEDIO ======
  Question(
    id: "pfrh_anp_medium_1",
    topicId: "cs_t3",
    text: r"""De acuerdo con la clasificación oficial del SINANPE, ¿qué relación agrupa EXCLUSIVAMENTE a todas las categorías reconocidas como Áreas de Uso Indirecto (intangibles)?""",
    options: [
      r"""Reservas Nacionales, Bosques de Protección y Refugios de Vida Silvestre.""",
      r"""Reservas Paisajísticas, Zonas Reservadas y Santuarios Nacionales.""",
      r"""Parques Nacionales, Santuarios Nacionales y Santuarios Históricos.""",
      r"""Parques Nacionales, Reservas Comunales y Santuarios Históricos.""",
    ],
    correctAnswer: 2,
    explanation: r"""El ordenamiento jurídico del SINANPE consagra estrictamente a los Parques Nacionales, Santuarios Nacionales y Santuarios Históricos como las únicas tres categorías de protección intangible y uso indirecto.""",
  ),

  Question(
    id: "pfrh_anp_medium_2",
    topicId: "cs_t3",
    text: r"""¿Qué Santuario Histórico peruano fue creado en 1974, convirtiéndose en el primero de su categoría, con la finalidad de proteger la meseta altoandina donde se libró la célebre "Batalla sin humo" o Batalla de Junín?""",
    options: [
      r"""Santuario Histórico Pampa de Ayacucho""",
      r"""Santuario Histórico Bosque de Pómac""",
      r"""Santuario Histórico de Chacamarca""",
      r"""Santuario Histórico de Machu Picchu""",
    ],
    correctAnswer: 2,
    explanation: r"""El Santuario Histórico de Chacamarca, ubicado en la Meseta de Bombón (Junín), fue establecido en 1974 y protege el escenario natural intangible donde el ejército patriota liderado por los Húsares de Junín libró esta histórica batalla.""",
  ),

  // ====== NIVEL DIFÍCIL ======
  Question(
    id: "pfrh_anp_hard_1",
    topicId: "cs_t3",
    text: r"""¿Qué Reserva Nacional marina y oceánica ha marcado un hito en la geopolítica de conservación del Perú, protegiendo ecosistemas pelágicos profundos y montes submarinos clave para especies migratorias, ayudando al cumplimiento del ODS 14?""",
    options: [
      r"""Reserva Nacional Sistema de Islas, Islotes y Puntas Guaneras""",
      r"""Reserva Nacional Dorsal de Nasca""",
      r"""Reserva Nacional San Fernando""",
      r"""Reserva Nacional Illescas""",
    ],
    correctAnswer: 1,
    explanation: r"""La Reserva Nacional Dorsal de Nasca es la primera área netamente pelágica y oceánica del país, protegiendo gigantescas cadenas montañosas submarinas y aumentando significativamente el porcentaje de mar territorial protegido.""",
  ),

  Question(
    id: "pfrh_anp_hard_2",
    topicId: "cs_t3",
    text: r"""Dentro de la legislación del SINANPE, ¿qué estatus jurídico y técnico posee una "Zona Reservada"?""",
    options: [
      r"""Área de uso indirecto perpetuo equivalente a un Parque Nacional.""",
      r"""Territorio destinado exclusivamente a bases militares de frontera.""",
      r"""Área que reúne las condiciones para ser ANP, pero que posee un estatus transitorio mientras se realizan los estudios para definir su categoría definitiva de uso.""",
      r"""Reserva otorgada a perpetuidad a empresas privadas para bonos de carbono.""",
    ],
    correctAnswer: 2,
    explanation: r"""Las Zonas Reservadas poseen un reconocimiento legal temporal mientras se ejecutan investigaciones biológicas y sociales que determinen si serán categorizadas finalmente como áreas de uso directo o indirecto.""",
  ),

  // ====== NIVEL EXTREMO ======
  Question(
    id: "pfrh_anp_extreme_1",
    topicId: "cs_t3",
    text: r"""Según los informes de auditoría sobre efectividad en las ANP y gobernanza ambiental, ¿qué instrumento de microzonificación es el encargado de señalar las pautas directas sobre la disposición en terreno de infraestructura, regulaciones de flujo de visitantes y desarrollar metodologías de medición de impacto turístico como la Capacidad de Carga (CCA) y el Límite de Cambio Aceptable (LAC)?""",
    options: [
      r"""Plan de Uso Turístico y Recreativo""",
      r"""Radar de la Participación""",
      r"""Plan de Sitio""",
      r"""Plan Maestro Decenal""",
    ],
    correctAnswer: 2,
    explanation: r"""El Plan de Sitio es el instrumento operativo y de microzonificación que establece el ordenamiento físico, el diseño de instalaciones y las metodologías técnicas (como CCA y LAC) para regular milimétricamente el impacto del turismo en un espacio delimitado del ANP.""",
  ),

  Question(
    id: "pfrh_anp_extreme_2",
    topicId: "cs_t3",
    text: r"""La Contraloría General de la República y el SERNANP miden el desempeño integral de las áreas protegidas. En este contexto, ¿qué función específica cumple la herramienta denominada "Radar de la Participación"?""",
    options: [
      r"""Monitorear telemáticamente las Alertas Tempranas de Deforestación (ATD) mediante sensores satelitales en el bosque.""",
      r"""Medir semestralmente el grado de organización, estructura, funcionamiento y nivel de inclusión comunitaria de los actores estratégicos y el Comité de Gestión del ANP.""",
      r"""Evaluar exclusivamente la Capacidad de Carga (CCA) para la venta de boletos turísticos.""",
      r"""Cuantificar el Índice de Implementación Financiera (Indimapa) de los recursos humanos.""",
    ],
    correctAnswer: 1,
    explanation: r"""El "Radar de la Participación" es el instrumento oficial diseñado por el SERNANP para medir de forma estructurada y semestral cómo interactúan y participan las comunidades y el Comité de Gestión en la toma de decisiones y planificación (Principio de Inclusión) del área protegida.""",
  ),
];
