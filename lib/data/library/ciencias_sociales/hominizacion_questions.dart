import 'package:learn/models/question.dart';

final List<Question> hominizacionQuestions = [
  // ====== NIVEL FÁCIL ======
  Question(
    id: "pfrh_hom_easy_1",
    topicId: "cs_t1",
    text: r"""¿Qué evento climático fue el motor principal que impulsó la presión selectiva hacia el bipedismo en los primeros homínidos africanos?""",
    options: [
      r"""La inundación masiva de los grandes valles.""",
      r"""La glaciación extrema que cubrió de hielo el ecuador.""",
      r"""La transición climática de bosques húmedos a sabanas abiertas por aridificación.""",
      r"""La extinción de los grandes depredadores.""",
    ],
    correctAnswer: 2,
    explanation: r"""La reducción de los bosques y la expansión de la sabana abierta obligaron a los homínidos a caminar erguidos para desplazarse y sobrevivir en un nuevo entorno.""",
  ),

  Question(
    id: "pfrh_hom_easy_2",
    topicId: "cs_t1",
    text: r"""¿A qué especie pertenece el histórico fósil "Lucy", descubierto en 1974, que fue clave para comprender los inicios de la marcha bípeda?""",
    options: [
      r"""Homo sapiens""",
      r"""Australopithecus afarensis""",
      r"""Homo erectus""",
      r"""Homo habilis""",
    ],
    correctAnswer: 1,
    explanation: r"""Los restos de "Lucy" corresponden a una hembra de Australopithecus afarensis, considerada el origen de la evolución bípeda temprana.""",
  ),

  // ====== NIVEL MEDIO ======
  Question(
    id: "pfrh_hom_medium_1",
    topicId: "cs_t1",
    text: r"""¿Qué característica morfológica hizo posible que el Homo habilis inaugurara la fabricación sistemática de herramientas de piedra?""",
    options: [
      r"""La desaparición de los arcos superciliares.""",
      r"""El desarrollo del bipedismo estricto y la pérdida de vello corporal.""",
      r"""El aumento de su estatura a más de 1.8 metros.""",
      r"""La liberación de las extremidades superiores y el perfeccionamiento de la pinza del pulgar.""",
    ],
    correctAnswer: 3,
    explanation: r"""El bipedismo permitió liberar las manos, facilitando el desarrollo de la pinza del pulgar para manipular objetos y fabricar herramientas.""",
  ),

  Question(
    id: "pfrh_hom_medium_2",
    topicId: "cs_t1",
    text: r"""El crecimiento exponencial del volumen cerebral impuso un costo metabólico crítico. ¿Qué "catalizador biológico" permitió al género Homo sostener este enorme gasto de energía?""",
    options: [
      r"""La adopción del bipedismo exclusivo.""",
      r"""El paso a una dieta estrictamente herbívora.""",
      r"""El control del fuego para la cocción de alimentos, facilitando la digestión.""",
      r"""La reducción drástica de la estatura corporal.""",
    ],
    correctAnswer: 2,
    explanation: r"""Cocinar los alimentos aumentó la disponibilidad de nutrientes y requirió menos energía para la digestión, liberando el metabolismo necesario para alimentar el desarrollo cerebral.""",
  ),

  // ====== NIVEL DIFÍCIL ======
  Question(
    id: "pfrh_hom_hard_1",
    topicId: "cs_t1",
    text: r"""La biología evolutiva señala a la "Neotenia" como un factor clave en nuestra especie. ¿Qué significa este concepto y cuál fue su impacto?""",
    options: [
      r"""El desarrollo acelerado de la masa muscular para la caza.""",
      r"""La retención de rasgos juveniles en la adultez que prolongó la dependencia infantil, favoreciendo el aprendizaje social.""",
      r"""El acortamiento de las extremidades inferiores como adaptación al clima polar.""",
      r"""La aparición temprana del lenguaje mediante la expansión nasal.""",
    ],
    correctAnswer: 1,
    explanation: r"""La neotenia extendió el periodo de dependencia infantil, lo que creó una ventana de tiempo fundamental para la plasticidad cerebral y la asimilación de la cultura y la supervivencia.""",
  ),

  Question(
    id: "pfrh_hom_hard_2",
    topicId: "cs_t1",
    text: r"""El lenguaje humano fue crucial para el pensamiento simbólico. Anatómica y neurológicamente, ¿qué cambios hicieron posible la fonación y el lenguaje articulado?""",
    options: [
      r"""La formación del mentón y el acortamiento del paladar.""",
      r"""La reducción del prognatismo y la aparición de incisivos más largos.""",
      r"""El ensanchamiento del tórax y la bipedestación completa.""",
      r"""El desarrollo del área de Broca en el cerebro y la modificación de la posición de la laringe.""",
    ],
    correctAnswer: 3,
    explanation: r"""La capacidad del habla compleja requirió la reorganización neuroanatómica de zonas como el área de Broca y el descenso físico de la laringe.""",
  ),

  // ====== NIVEL EXTREMO ======
  Question(
    id: "pfrh_hom_extreme_1",
    topicId: "cs_t1",
    text: r"""Para permitir la locomoción bípeda permanente, se requirió una reconfiguración severa del esqueleto. ¿Qué transformación específica sufrió la región pélvica?""",
    options: [
      r"""Se acortó y se volvió más robusta para soportar el peso en posición vertical y anclar fuertemente los músculos glúteos.""",
      r"""Se alargó cilíndricamente para proporcionar mayor flexibilidad lumbar durante la carrera.""",
      r"""Se fusionó completamente con las últimas vértebras para prevenir hernias discales.""",
      r"""Realizó una rotación de 90 grados hacia adelante para alinear el fémur.""",
    ],
    correctAnswer: 0,
    explanation: r"""La pelvis humana evolucionó volviéndose más corta y ancha, una adaptación mecánica esencial para soportar los órganos en posición erguida y servir de anclaje a los potentes músculos glúteos de la marcha.""",
  ),

  Question(
    id: "pfrh_hom_extreme_2",
    topicId: "cs_t1",
    text: r"""El control del fuego redefinió la biología y sociedad humana. Basado en evidencias como la Cueva Wonderwerk, ¿qué caracterizó a la "fase de mantenimiento" (~1-0.8 Ma) en la historia del fuego?""",
    options: [
      r"""La creación de chispas percutiendo minerales piritosos contra sílex.""",
      r"""El aprovechamiento temporal de rayos sin capacidad de transportarlo a cuevas.""",
      r"""La conservación prolongada de brasas en "guardafuegos", procesando alimentos antes de que pudieran encender el fuego intencionalmente.""",
      r"""La invención del taladro de arco por parte del Australopithecus afarensis.""",
    ],
    correctAnswer: 2,
    explanation: r"""En la fase de mantenimiento, los homínidos (probablemente Homo erectus) lograban conservar las brasas de origen natural en recipientes o "guardafuegos", pero aún no dominaban las técnicas para encender el fuego de manera deliberada.""",
  ),
];
