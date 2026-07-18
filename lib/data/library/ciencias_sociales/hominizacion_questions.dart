import 'package:learn/models/question.dart';

final List<Question> hominizacionQuestions = [
  // ====== NIVEL FÁCIL ======
  Question(
    id: 'pfrh_hom_easy_1',
    topicId: 'cs_t1',
    text:
        r'''¿Cuál fue el principal motor ecológico y ambiental que ejerció la presión selectiva necesaria para que los primeros homínidos africanos adoptaran el bipedismo?''',
    options: [
      r'''El descenso drástico de las temperaturas que generó glaciaciones en el ecuador, obligando a los homínidos a caminar para generar calor.''',
      r'''La transición climática que, debido a la aridificación, redujo los bosques húmedos y expandió los paisajes de sabana abierta.''',
      r'''Las inundaciones masivas en los grandes valles fluviales que obligaron a los primates a caminar erguidos para no ahogarse.''',
      r'''La extinción total de los grandes felinos y depredadores, lo que permitió a los primates bajar de los árboles con seguridad.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''La aridificación del clima en África provocó la desaparición de grandes extensiones de bosques, sustituyéndolos por sabanas abiertas; en este nuevo entorno, la marcha bípeda fue una adaptación clave para desplazarse, buscar alimento y detectar depredadores.''',
  ),

  Question(
    id: 'pfrh_hom_easy_2',
    topicId: 'cs_t1',
    text:
        r'''El fósil de "Lucy", hallado en Etiopía en 1974 por Donald Johanson, es uno de los descubrimientos más importantes de la paleoantropología. ¿A qué especie pertenece y qué característica evolutiva clave demostró poseer?''',
    options: [
      r'''Homo habilis / Demostró poseer un cerebro superior a los 1000 cm³.''',
      r'''Homo erectus / Demostró ser la primera especie en dominar el fuego.''',
      r'''Australopithecus afarensis / Demostró que ya era bípeda, aunque aún no fabricaba herramientas avanzadas ni tenía un cerebro grande.''',
      r'''Homo neanderthalensis / Demostró adaptaciones al frío extremo y el inicio del arte rupestre.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''"Lucy" es un espécimen de Australopithecus afarensis de hace más de 3 millones de años, cuyo esqueleto demostró que la especie ya caminaba erguida (era bípeda), a pesar de tener una capacidad craneal aún muy reducida y no fabricar herramientas líticas.''',
  ),

  // ====== NIVEL MEDIO ======
  Question(
    id: 'pfrh_hom_medium_1',
    topicId: 'cs_t1',
    text:
        r'''La liberación de las extremidades superiores gracias a la marcha bípeda permitió transformaciones anatómicas cruciales en las manos. ¿Qué especie fue la primera en aprovechar el desarrollo de la pinza del pulgar para fabricar sistemáticamente herramientas líticas?''',
    options: [
      r'''Homo antecessor''',
      r'''Australopithecus africanus''',
      r'''Homo erectus''',
      r'''Homo habilis''',
    ],
    correctAnswer: 3,
    explanation:
        r'''El Homo habilis apareció hace aproximadamente 2.5 millones de años y, gracias al perfeccionamiento de la pinza del pulgar, fue la primera especie del género humano en elaborar sistemáticamente herramientas de piedra.''',
  ),

  Question(
    id: 'pfrh_hom_medium_2',
    topicId: 'cs_t1',
    text:
        r'''El aumento exponencial del volumen cerebral impuso un altísimo costo metabólico a la especie humana. ¿Qué innovación tecnológica y conductual actuó como "catalizador biológico" para sostener este gasto energético sin requerir cuerpos gigantescos?''',
    options: [
      r'''El desarrollo de lanzas con punta de metal para cazar megafauna.''',
      r'''El control del fuego y la cocción de los alimentos, que aumentó la absorción de nutrientes y permitió reducir el tamaño del aparato digestivo.''',
      r'''El paso de una dieta omnívora a una dieta estrictamente basada en vegetales fibrosos de la sabana.''',
      r'''La adopción de la neotenia extrema, que redujo el tamaño de los músculos glúteos.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''El dominio del fuego permitió cocinar los alimentos, facilitando su digestión y aumentando la cantidad de nutrientes absorbidos; esto liberó energía metabólica que antes usaba el aparato digestivo, destinándola al extraordinario desarrollo del cerebro.''',
  ),

  // ====== NIVEL DIFÍCIL ======
  Question(
    id: 'pfrh_hom_hard_1',
    topicId: 'cs_t1',
    text:
        r'''El desarrollo del lenguaje articulado en el linaje de los homínidos no fue solo un fenómeno cultural, sino que exigió reconfiguraciones anatómicas complejas. ¿Cuáles fueron las modificaciones biológicas indispensables para la fonación humana?''',
    options: [
      r'''El acortamiento severo del paladar duro y la alineación del foramen magnum.''',
      r'''El ensanchamiento de la cavidad nasal y la hipertrofia de los senos paranasales.''',
      r'''El desarrollo del área de Broca en el cerebro y la modificación de la posición de la laringe hacia una ubicación más baja.''',
      r'''La desaparición completa de los arcos superciliares y el surgimiento del mentón prominente.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El lenguaje complejo y articulado requirió la reorganización neuroanatómica de zonas de la corteza cerebral, destacando el área de Broca, y el descenso físico de la laringe en el tracto vocal.''',
  ),

  Question(
    id: 'pfrh_hom_hard_2',
    topicId: 'cs_t1',
    text:
        r'''De acuerdo con las investigaciones documentadas en Aquitania (Francia) por la Universidad de Cambridge, ¿qué factor fue determinante para la extinción del Homo neanderthalensis frente a la invasión del Homo sapiens?''',
    options: [
      r'''Una vulnerabilidad genética de los neandertales frente a virus tropicales traídos desde África por los Sapiens.''',
      r'''La incapacidad anatómica de los neandertales para articular cualquier tipo de sonido o lenguaje primitivo.''',
      r'''La llegada del Homo sapiens en números hasta diez veces superiores, sumado a su mayor capacidad social, asociativa y el uso de sistemas de almacenamiento.''',
      r'''El monopolio del control del fuego por parte de los Sapiens, tecnología que los neandertales nunca llegaron a conocer.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''El estudio de Cambridge concluyó que el Homo sapiens superó demográficamente a los neandertales (en una proporción de diez a uno) y poseía capacidades sociales superiores, como redes de intercambio, mejor tecnología y almacenamiento de comida, lo que garantizó su supervivencia en la disputa por los recursos.''',
  ),

  // ====== NIVEL EXTREMO ======
  Question(
    id: 'pfrh_hom_extreme_1',
    topicId: 'cs_t1',
    text:
        r'''La biología evolutiva señala que nuestra especie experimentó un profundo proceso de "neotenia". Desde una perspectiva biocultural y neurológica, ¿cuál fue el principal impacto adaptativo de este fenómeno?''',
    options: [
      r'''Generó una mutación en las glándulas ecrinas que aceleró la pérdida del vello corporal para facilitar la termorregulación en la sabana.''',
      r'''Extendió prolongadamente el periodo de dependencia infantil, creando una vasta ventana de plasticidad cerebral indispensable para el aprendizaje social complejo.''',
      r'''Permitió el estrechamiento del canal de parto pélvico, obligando a las hembras a desarrollar el bipedismo estricto.''',
      r'''Causó el crecimiento desproporcionado de las extremidades inferiores y la aparición de la bóveda plantar plantígrada.''',
    ],
    correctAnswer: 1,
    explanation:
        r'''La neotenia consiste en retener características juveniles en la adultez, lo que en los humanos se tradujo en una infancia extremadamente prolongada (altricialidad). Esta etapa de inmadurez extendida propició una alta plasticidad cerebral, vital para la asimilación del lenguaje, la cultura y el aprendizaje social.''',
  ),

  Question(
    id: 'pfrh_hom_extreme_2',
    topicId: 'cs_t1',
    text:
        r'''El control del fuego revolucionó la dieta y ecología del género Homo, pero su dominio fue gradual. Según las evidencias arqueológicas (como las de la Cueva Wonderwerk), ¿qué comportamiento técnico define a la llamada "fase de mantenimiento" del fuego ocurrida hace ~1 millón de años?''',
    options: [
      r'''La fabricación de herramientas complejas como el taladro de arco para encender fuego por fricción constante sobre yesca seca.''',
      r'''La generación de fuego ex novo mediante la percusión sistemática de materiales piritosos contra bloques de sílex.''',
      r'''El aprovechamiento oportunista de las brasas generadas por incendios naturales (rayos), conservándolas vivas en "guardafuegos" de forma prolongada al no saber cómo iniciar la ignición.''',
      r'''La cocción exclusiva de pescados marinos utilizando vapor en pozos cavados en la arena de las playas.''',
    ],
    correctAnswer: 2,
    explanation:
        r'''Durante la fase de mantenimiento (evidenciada en la Cueva Wonderwerk), los homínidos aún no dominaban las técnicas para crear el fuego por fricción o percusión, limitándose a capturar y conservar cuidadosamente brasas procedentes de fuentes naturales para procesar alimentos.''',
  ),
];
