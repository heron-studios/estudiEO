import 'package:learn/models/question.dart';

final List<Question> ecosistemasTecnologiaQuestions = [
  // ====== NIVEL FÁCIL ======
  Question(
    id: "pfrh_etds_easy_1",
    topicId: "cs_t4",
    text: r"""Según los parámetros establecidos por la Comisión Brundtland y respaldados por la ONU, ¿cuál es la definición formal y técnica del "Desarrollo Sostenible"?""",
    options: [
      r"""El crecimiento económico y tecnológico acelerado que prioriza la erradicación de la pobreza extrema mediante la explotación intensiva de los recursos no renovables.""",
      r"""La implementación exclusiva de tecnologías de cero emisiones en zonas urbanas para eliminar la huella de carbono en la presente década.""",
      r"""El desarrollo que satisface las necesidades del presente sin comprometer la capacidad de las generaciones futuras para satisfacer sus propias necesidades, equilibrando lo económico, social y ambiental.""",
      r"""La paralización total del desarrollo industrial lineal para retornar a prácticas agrícolas preindustriales como medida de protección ecosistémica.""",
    ],
    correctAnswer: 2,
    explanation: r"""El Informe Brundtland estableció que el desarrollo sostenible no prohíbe el crecimiento económico, sino que exige que este cubra las necesidades actuales en equilibrio con el ambiente y la sociedad, garantizando que los recursos no se agoten para las futuras generaciones.""",
  ),

  Question(
    id: "pfrh_etds_easy_2",
    topicId: "cs_t4",
    text: r"""El concepto de "tecnología sostenible" difiere radicalmente de las tecnologías convencionales por su impacto integral en la sociedad y el planeta. ¿En qué pilares fundamentales se basa su diseño y aplicación?""",
    options: [
      r"""En el uso intensivo de hidrocarburos, la expansión de vertederos controlados y el fomento del consumismo lineal.""",
      r"""En la eficiencia energética, la reducción de residuos (huella ecológica) y el uso prioritario de materiales renovables o reciclables.""",
      r"""En el encarecimiento de los servicios básicos para limitar el acceso poblacional a los recursos naturales.""",
      r"""En la creación de redes de conexión de banda ancha exclusivamente para la extracción de minerales pesados.""",
    ],
    correctAnswer: 1,
    explanation: r"""La tecnología sostenible tiene como base la optimización de recursos, minimizando la contaminación mediante la eficiencia energética, la mitigación de emisiones de gases de efecto invernadero y la priorización de insumos reciclables o renovables.""",
  ),

  // ====== NIVEL MEDIO ======
  Question(
    id: "pfrh_etds_medium_1",
    topicId: "cs_t4",
    text: r"""Las tecnologías ambientales modernas promueven un cambio radical en los sistemas productivos mundiales. En contraposición al modelo lineal de "extraer, producir y desechar", ¿cuál es la finalidad técnica central de la "Economía Circular"?""",
    options: [
      r"""Exportar los residuos sólidos a países vecinos para evitar la saturación de los vertederos nacionales.""",
      r"""Incinerar todos los desechos industriales para generar energía calórica a bajo costo.""",
      r"""Recuperar y reintegrar los residuos al sistema productivo, transformándolos cíclicamente en nuevas materias primas y extendiendo su vida útil.""",
      r"""Utilizar exclusivamente polímeros biodegradables procedentes de la Amazonía para todos los empaques plásticos.""",
    ],
    correctAnswer: 2,
    explanation: r"""La economía circular se basa en la circularidad de los materiales; busca eliminar el concepto tradicional de "basura" recuperando los desechos para reintroducirlos en la cadena de valor como nuevos insumos, preservando así el entorno.""",
  ),

  Question(
    id: "pfrh_etds_medium_2",
    topicId: "cs_t4",
    text: r"""En el marco de la innovación sostenible y la reducción de la huella de carbono industrial, existe una disciplina tecnológica que se caracteriza por pensar y proyectar un producto desde el momento de su concepción original para garantizar y maximizar el reciclaje de sus materiales al final de su vida útil. ¿Cómo se denomina este concepto?""",
    options: [
      r"""Ecodiseño.""",
      r"""Biomimética.""",
      r"""Fotocatálisis.""",
      r"""Biorremediación.""",
    ],
    correctAnswer: 0,
    explanation: r"""El ecodiseño asegura la sostenibilidad de un producto desde su fase de creación (origen), previendo que sus componentes sean fácilmente separables, recuperables y reciclables cuando ya no sean útiles.""",
  ),

  // ====== NIVEL DIFÍCIL ======
  Question(
    id: "pfrh_etds_hard_1",
    topicId: "cs_t4",
    text: r"""La aplicación de la tecnología del Internet de las Cosas (IoT) y sensores inteligentes no solo moderniza a las empresas, sino que brinda beneficios ambientales cuantificables. Según los análisis del sector agrario en el Perú, ¿qué impacto ambiental directo ha logrado la tecnología de precisión en los últimos cinco años?""",
    options: [
      r"""Ha permitido sustituir totalmente el uso de abonos químicos por compost automatizado en la Amazonía.""",
      r"""Ha incrementado la eficiencia hídrica en un 15%, optimizando el uso del agua y reduciendo el desperdicio en la agricultura.""",
      r"""Ha impulsado la erradicación total de la agricultura tradicional, reemplazándola por cultivos hidropónicos en laboratorios.""",
      r"""Ha provocado una disminución del 50% en las emisiones de metano del ganado altoandino.""",
    ],
    correctAnswer: 1,
    explanation: r"""El IoT ha permitido el monitoreo en tiempo real del estado de los suelos, lo que facilitó a la agricultura de precisión peruana optimizar sus recursos e incrementar la eficiencia del uso del agua en un 15%, protegiendo este vital recurso.""",
  ),

  Question(
    id: "pfrh_etds_hard_2",
    topicId: "cs_t4",
    text: r"""El despliegue de las denominadas "Smart Cities" (ciudades inteligentes) utiliza la conectividad para reducir la huella de carbono. De acuerdo a la experiencia logística internacional, ¿de qué manera los sensores IoT aplicados en la gestión de residuos sólidos (basura) han mitigado directamente la contaminación urbana?""",
    options: [
      r"""Instalando sistemas que incineran automáticamente los desechos dentro del contenedor para generar energía calórica barata.""",
      r"""Enviando alertas de llenado que permiten optimizar y acortar las rutas de los camiones recolectores, reduciendo así el consumo de combustible y las emisiones de CO2.""",
      r"""Clasificando y triturando los residuos plásticos a nivel molecular mediante nanotecnología subterránea.""",
      r"""Compactando los desechos para exportarlos directamente por vías férreas magnéticas automatizadas.""",
    ],
    correctAnswer: 1,
    explanation: r"""En ciudades como Barcelona, los contenedores inteligentes informan su nivel de capacidad en tiempo real, lo que evita que los camiones hagan recorridos innecesarios, ahorrando diésel y disminuyendo drásticamente el CO2 emitido al aire.""",
  ),

  // ====== NIVEL EXTREMO ======
  Question(
    id: "pfrh_etds_extreme_1",
    topicId: "cs_t4",
    text: r"""En la supervisión y conservación técnica de los vastos territorios del Bioma Amazónico peruano frente a los efectos antrópicos y la tala ilegal, el SERNANP utiliza prioritariamente dos herramientas tecnológicas para la recolección de datos y la teledetección del impacto ecológico. ¿Cuáles son estas herramientas?""",
    options: [
      r"""El Radar de la Participación (RP) y el Indimapa de impacto biológico.""",
      r"""Los drones de fumigación agrológica y el sistema satelital WGS 84 civil.""",
      r"""Las Alertas Tempranas de Deforestación (ATD) y la herramienta de monitoreo geoespacial SMART (Spatial Monitoring and Reporting Tool).""",
      r"""El Plan de Sitio virtual y la Matriz de Capacidad de Carga Bioclimática.""",
    ],
    correctAnswer: 2,
    explanation: r"""El Estado peruano monitorea la deforestación amazónica cruzando información satelital a través de las ATD y sistematizando los datos operativos recolectados en campo por los guardaparques mediante la tecnología SMART, asegurando una gestión eficiente frente a las amenazas ambientales.""",
  ),

  Question(
    id: "pfrh_etds_extreme_2",
    topicId: "cs_t4",
    text: r"""El desarrollo sostenible global advierte sobre una limitante geopolítica conocida como la "brecha tecnológica". En el marco del cumplimiento de los Objetivos de Desarrollo Sostenible (como el ODS 15), ¿qué representa específicamente este concepto para naciones en vías de desarrollo como el Perú?""",
    options: [
      r"""La prohibición jurídica impuesta por la ONU para utilizar sensores IoT en áreas tropicales debido a la alteración del campo magnético animal.""",
      r"""El contraste evidente entre naciones desarrolladas que resguardan sus ecosistemas automatizadamente y países en desarrollo que todavía enfrentan debilidades de gobernanza ambiental, presupuesto y herramientas digitales para alcanzar las metas.""",
      r"""La incapacidad técnica del país para conectar sus carreteras transversales con las redes viales internacionales.""",
      r"""La imposibilidad perpetua de construir vehículos eléctricos debido a la ausencia total de minerales como el cobre y el litio en territorio nacional.""",
    ],
    correctAnswer: 1,
    explanation: r"""La brecha tecnológica refleja la desigualdad en el acceso a la innovación; los países ricos usan tecnología de punta para vigilar sus ecosistemas, mientras que los países en desarrollo como Perú necesitan primero estructurar y financiar correctamente su gobernanza e institucionalidad para poder digitalizar su gestión ambiental.""",
  ),
];
