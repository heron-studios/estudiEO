import 'package:learn/models/question.dart';
import 'package:learn/models/subject.dart';
import 'package:learn/models/topic.dart';

final Subject cienciasSocialesSubject = Subject(
  id: 'ciencias-sociales',
  name: 'Ciencias Sociales',
  color: '#95E1D3',
  icon: '🌍',
  topicIds: ['cs_t1', 'cs_t2', 'cs_t3', 'cs_t4', 'cs_t5'],
);

final List<Question> cienciasSocialesQuestions = [
  Question(
    id: 'cs_q1',
    topicId: 'cs_t1',
    text:
        'La paleoantropología define el proceso de hominización como un conjunto de transformaciones biológicas y anatómicas que diferenciaron a los homínidos de los primates. Dentro de este proceso, ¿cuál fue el cambio morfológico primigenio que consolidó al género Australopithecus, antecediendo por millones de años al crecimiento acelerado de la capacidad craneal?',
    options: [
      'El desarrollo del pulgar oponible para sujetar ramas.',
      'El bipedismo permanente y la adopción de una postura erguida.',
      'La invención del lenguaje fonético articulado.',
      'El descubrimiento y uso empírico de la agricultura.',
      'La pérdida total del vello corporal para la termorregulación.',
    ],
    correctAnswer: 1,
    explanation:
        "El bipedismo (caminar sobre dos piernas) liberó las extremidades superiores y es la característica fundamental que separa a los Australopithecus de otros primates, evidenciado en fósiles como 'Lucy' y las huellas de Laetoli.",
  ),
  Question(
    id: 'cs_q2',
    topicId: 'cs_t1',
    text:
        'En 1974, el antropólogo Donald Johanson realizó un descubrimiento trascendental en la región de Afar (Etiopía): un esqueleto fósil notablemente completo de una hembra adulta de Australopithecus afarensis, evidenciando un bipedismo indiscutible. Este hallazgo, mundialmente famoso, fue bautizado como:',
    options: [
      'El Niño de Taung.',
      'El Hombre de Cro-Magnon.',
      'Lucy.',
      'El Hombre de Java.',
      'Ardi.',
    ],
    correctAnswer: 2,
    explanation:
        "'Lucy' es el fósil más emblemático del Australopithecus afarensis. Su esqueleto demostró concluyentemente que la marcha bípeda precedió a la encefalización masiva.",
  ),
  Question(
    id: 'cs_q3',
    topicId: 'cs_t1',
    text:
        "El salto evolutivo que marca el inicio del género 'Homo' y, simultáneamente, el inicio del periodo Paleolítico Inferior, se sustenta en la capacidad de transformar conscientemente el entorno. ¿Qué especie homínida inaugura esta etapa al ser la primera en fabricar herramientas líticas (industria olduvaiense)?",
    options: [
      'Homo erectus.',
      'Homo sapiens.',
      'Homo habilis.',
      'Paranthropus boisei.',
      'Homo neanderthalensis.',
    ],
    correctAnswer: 2,
    explanation:
        "El Homo habilis ('hombre hábil') es el primer fabricante de herramientas de piedra documentado, rompiendo cantos rodados para obtener filos cortantes (choppers).",
  ),
  Question(
    id: 'cs_q4',
    topicId: 'cs_t1',
    text:
        'El dominio del fuego representó una revolución tecnológica que permitió la cocción de alimentos, la protección nocturna y, fundamentalmente, la adaptación a climas más gélidos, propiciando las primeras grandes migraciones intercontinentales. ¿A qué especie se le atribuye este hito biológico y cultural?',
    options: [
      'Australopithecus africanus.',
      'Homo erectus.',
      'Homo antecessor.',
      'Homo floresiensis.',
      'Homo sapiens idaltu.',
    ],
    correctAnswer: 1,
    explanation:
        'El Homo erectus dominó el fuego, lo que facilitó su expansión fuera de África hacia Asia (Hombre de Pekín, Hombre de Java) y Europa.',
  ),
  Question(
    id: 'cs_q5',
    topicId: 'cs_t1',
    text:
        'Durante el Paleolítico Medio, el Homo neanderthalensis habitó vastas regiones de Europa y Asia Occidental, enfrentando duras condiciones glaciares. Además de su robustez física, esta especie evidenció un avance cognitivo sin precedentes relacionado con el pensamiento mágico-religioso. ¿Cuál es la prueba arqueológica concluyente de este avance?',
    options: [
      'La creación de pinturas rupestres policromadas.',
      'El desarrollo de la cerámica utilitaria.',
      'La práctica sistemática de entierros ritualizados con ofrendas.',
      'La construcción de viviendas megalíticas.',
      'El uso del bronce para herramientas de caza.',
    ],
    correctAnswer: 2,
    explanation:
        "Los entierros rituales (ej. Shanidar, donde se encontraron restos de polen sobre un cadáver) demuestran que los Neandertales poseían autoconsciencia, empatía y concepciones sobre el 'más allá'.",
  ),
  Question(
    id: 'cs_q6',
    topicId: 'cs_t1',
    text:
        'El Paleolítico Superior está marcado por la hegemonía del Homo sapiens sapiens y el surgimiento de expresiones culturales altamente simbólicas y abstractas, vinculadas a ceremonias propiciatorias de caza. La manifestación más sublime de esta época, hallada en cuevas como Altamira y Lascaux, es:',
    options: [
      'La arquitectura monumental.',
      'El arte rupestre o parietal.',
      'La metalurgia del hierro.',
      'La invención del tejido de algodón.',
      'El primer sistema de escritura cuneiforme.',
    ],
    correctAnswer: 1,
    explanation:
        'El arte rupestre (pinturas en paredes de cavernas) es característico del Homo sapiens en el Paleolítico Superior, reflejando su compleja cosmovisión y pensamiento abstracto.',
  ),
  Question(
    id: 'cs_q7',
    topicId: 'cs_t1',
    text:
        "Para la antropología y sociología, existe una distinción fundamental entre 'hominización' (evolución biológica) y 'humanización'. ¿A qué se refiere específicamente el proceso de humanización?",
    options: [
      'Al incremento del volumen craneal por el consumo de carne.',
      'A la adaptación genética a climas extremadamente fríos.',
      'A la desaparición del prognatismo facial.',
      'Al proceso de desarrollo social, lenguaje, cultura y transmisión de conocimientos.',
      'A la mutación que permitió la visión estereoscópica en color.',
    ],
    correctAnswer: 3,
    explanation:
        'La humanización abarca la evolución cultural: la capacidad de crear normas sociales, arte, religión y transmitir conocimientos complejos mediante el lenguaje articulado.',
  ),
  Question(
    id: 'cs_q8',
    topicId: 'cs_t1',
    text:
        'El tránsito del Paleolítico al Neolítico representó una transformación radical en el modo de vida de la humanidad (Revolución Neolítica). El cambio estructural más significativo que alteró la economía parasitaria hacia una economía productora fue:',
    options: [
      'El descubrimiento y manipulación de la rueda.',
      'El abandono del politeísmo por religiones monoteístas.',
      'La invención de la agricultura y la ganadería, generando el sedentarismo.',
      'La masificación del uso del arco y la flecha.',
      'El establecimiento de enormes imperios transcontinentales.',
    ],
    correctAnswer: 2,
    explanation:
        'La agricultura y domesticación de animales permitieron generar excedentes alimenticios, poniendo fin al nomadismo forzoso y dando paso al sedentarismo y las primeras aldeas.',
  ),
  Question(
    id: 'cs_q9',
    topicId: 'cs_t1',
    text:
        "La 'Teoría Inmigracionista Asiática' es el postulado más aceptado científicamente para explicar el poblamiento inicial de América. Propuesta por Alex Hrdlicka, sostiene que bandas de cazadores cruzaron por un 'puente' natural durante la última glaciación. ¿Cómo se denomina geológicamente a esta última era glaciar que permitió el paso por el Estrecho de Bering?",
    options: [
      'Glaciación de Günz.',
      'Glaciación de Mindel.',
      'Glaciación de Riss.',
      'Glaciación de Wisconsin.',
      'Glaciación de Würm.',
    ],
    correctAnswer: 3,
    explanation:
        'La Glaciación de Wisconsin (término usado en América, equivalente a Würm en Europa) produjo un descenso del nivel del mar (eustasia glaciar), exponiendo el puente de tierra de Beringia.',
  ),
  Question(
    id: 'cs_q10',
    topicId: 'cs_t1',
    text:
        'El antropólogo Alex Hrdlicka sustentó su teoría asiática en múltiples evidencias antroposomáticas (físicas) que demostraban la similitud entre las poblaciones originarias americanas y los pueblos asiáticos. ¿Cuál de los siguientes rasgos NO fue utilizado por Hrdlicka para fundamentar su tesis?',
    options: [
      'La pigmentación de la piel y el cabello lisotrico (lacio).',
      'Los pómulos salientes y el pliegue epicántico (ojos rasgados).',
      "La presencia de la 'mancha mongólica' en la base de la espalda de los recién nacidos.",
      'La forma de los dientes en pala.',
      'La similitud de vocablos para denominar a las deidades solares.',
    ],
    correctAnswer: 4,
    explanation:
        'Hrdlicka basó su teoría monorracial exclusivamente en rasgos físicos (antroposomáticos) como la mancha mongólica, cabello lacio y pómulos. Las similitudes lingüísticas fueron usadas por otras teorías (como la de Rivet).',
  ),
  Question(
    id: 'cs_q11',
    topicId: 'cs_t1',
    text:
        "La 'Teoría Oceánica', sustentada por el investigador francés Paul Rivet, postula un origen polirracial del hombre americano. Además del ingreso asiático, Rivet argumentó que contingentes humanos navegaron el Océano Pacífico impulsados por las corrientes marinas. Según esta teoría, ¿qué grupos étnicos específicos arribaron a las costas americanas?",
    options: [
      'Celtas y Vikingos.',
      'Melanésicos y Polinésicos.',
      'Mongoles y Tártaros.',
      'Fenicios y Cartagineses.',
      'Egipcios y Sumerios.',
    ],
    correctAnswer: 1,
    explanation:
        'Rivet propuso que, además de los asiáticos, grupos de Melanesia y Polinesia llegaron a América (especialmente a Centro y Sudamérica) cruzando el Pacífico en piraguas de balancín.',
  ),
  Question(
    id: 'cs_q12',
    topicId: 'cs_t1',
    text:
        'Para dar validez a su Teoría Melanésica (parte de la Teoría Oceánica), Paul Rivet presentó pruebas de orden cultural y etnográfico que evidenciaban asombrosas similitudes con pueblos andinos y amazónicos. Un ejemplo clásico de esta herencia melanésica en el antiguo Perú es el uso de:',
    options: [
      'El arco de medio punto en la arquitectura.',
      'La rueda para el transporte de carga.',
      'El horno subterráneo de piedras calientes (pachamanca), la cerbatana y la hamaca.',
      'La domesticación del caballo andaluz.',
      'El hierro fundido para armas punzocortantes.',
    ],
    correctAnswer: 2,
    explanation:
        'Rivet demostró paralelismos culturales notables, como la preparación de alimentos bajo tierra (pachamanca), el uso de la cerbatana, la hamaca y mosquiteros, comunes tanto en Melanesia como en tribus americanas.',
  ),
  Question(
    id: 'cs_q13',
    topicId: 'cs_t1',
    text:
        "El investigador portugués António Mendes Correia formuló la 'Teoría Australiana' del poblamiento americano. Según su hipótesis, grupos aborígenes australianos habrían llegado a la Patagonia y Tierra del Fuego bordeando el continente antártico. Para que este trayecto fuese biológicamente viable, Mendes Correia postuló la existencia de:",
    options: [
      'Un puente de hielo permanente que conectaba Australia con Chile.',
      "Un periodo de calentamiento global conocido como 'Optimum Climaticum'.",
      'Corrientes oceánicas de alta velocidad que arrastraban balsas a la deriva.',
      'La invención temprana de rompehielos de madera.',
      'Un evento tectónico que unió temporalmente todos los continentes (Pangea).',
    ],
    correctAnswer: 1,
    explanation:
        "Mendes Correia argumentó que hace miles de años se produjo un 'Optimum Climaticum' (clima óptimo), un periodo de calentamiento antártico que permitió a los australianos bordear las costas de la Antártida sin morir de frío.",
  ),
  Question(
    id: 'cs_q14',
    topicId: 'cs_t1',
    text:
        "En contraposición a las corrientes inmigracionistas, a fines del siglo XIX surgió la 'Teoría Autoctonista' americana, defendida férreamente por el paleontólogo argentino Florentino Ameghino, quien aseguraba que la humanidad había surgido en las pampas argentinas. Su teoría fue categóricamente refutada tiempo después debido a que:",
    options: [
      'No presentó ninguna osamenta, basándose solo en mitología indígena.',
      'Los fósiles que presentó correspondían a monos platirrinos, felinos y humanos de épocas modernas, no a homínidos primitivos del Terciario.',
      'Aceptó públicamente haber falsificado las pruebas por presiones políticas.',
      'Se demostró que las pampas argentinas estuvieron sumergidas bajo el mar hasta el siglo XV.',
      'Alex Hrdlicka demostró que América no tenía flora ni fauna propia.',
    ],
    correctAnswer: 1,
    explanation:
        "Hrdlicka y otros científicos analizaron los restos óseos presentados por Ameghino (el supuesto 'Homo pampeanus') y demostraron que eran restos mezclados de indígenas modernos y animales, no de la Era Terciaria.",
  ),
  Question(
    id: 'cs_q15',
    topicId: 'cs_t1',
    text:
        "Adentrándonos en la historia originaria del Perú, el primer periodo de poblamiento andino es conocido como el 'Periodo Lítico'. ¿Qué características socioeconómicas definen fundamentalmente el modo de vida de las bandas humanas durante esta etapa temprana?",
    options: [
      'Sedentarismo absoluto, agricultura intensiva y teocracia.',
      'Economía de subsistencia depredadora o parasitaria (caza, recolección), nomadismo y organización en bandas.',
      'Desarrollo de la alfarería policroma y el comercio de trueque interregional.',
      'Construcción de centros urbanos fortificados y estratificación social marcada.',
      'Domesticación exclusiva de camélidos sin conocimiento de herramientas líticas.',
    ],
    correctAnswer: 1,
    explanation:
        'Durante el Periodo Lítico (equivalente al Paleolítico), los primeros peruanos eran nómadas, vivían en cuevas organizados en bandas y su economía era depredadora (cazaban megafauna y recolectaban vegetales).',
  ),
  Question(
    id: 'cs_q16',
    topicId: 'cs_t1',
    text:
        'Ubicado en la región de Ayacucho, en las cuevas de Pikimachay, el arqueólogo Richard MacNeish descubrió las herramientas de piedra que, por mucho tiempo, fueron consideradas las más antiguas del Perú, evidenciando la presencia humana más temprana en el territorio. Este importante complejo arqueológico es conocido como:',
    options: [
      'El Hombre de Paiján',
      'El Hombre de Lauricocha',
      'El Hombre de Pacaicasa',
      'El Hombre de Chivateros',
      'El Hombre de Toquepala',
    ],
    correctAnswer: 2,
    explanation:
        'El Hombre de Pacaicasa (descubierto en la cueva de Pikimachay) representa los vestigios de industria lítica más antiguos encontrados en territorio peruano (aprox. 14,000 a.C.).',
  ),
  Question(
    id: 'cs_q17',
    topicId: 'cs_t1',
    text:
        'En la costa norte peruana (valle de Chicama, La Libertad), el arqueólogo Rafael Larco Hoyle, y posteriormente Claude Chauchat, investigaron un complejo del Periodo Lítico famoso por albergar los restos óseos humanos más antiguos encontrados en la costa peruana, los cuales evidenciaban prácticas de entierro. Nos referimos al:',
    options: [
      'Hombre de Santo Domingo',
      'Hombre de Paiján',
      'Hombre de Chilca',
      'Hombre de Guitarrero',
      'Hombre de Kotosh',
    ],
    correctAnswer: 1,
    explanation:
        'El Hombre de Paiján no solo destaca por sus puntas de proyectil de forma particular (con pedúnculo), sino por poseer los restos óseos humanos (esqueletos) más antiguos de la costa peruana.',
  ),
  Question(
    id: 'cs_q18',
    topicId: 'cs_t1',
    text:
        'Ubicado a más de 4,000 m.s.n.m. en la región de Huánuco, el ingeniero Augusto Cardich realizó excavaciones que revelaron los restos óseos humanos más antiguos de la sierra peruana, acompañados de entierros rituales y deformaciones craneanas incipientes. Este hallazgo crucial corresponde al:',
    options: [
      'Hombre de Lauricocha',
      'Hombre de Pacaicasa',
      'Hombre de Telarmachay',
      'Hombre de Toquepala',
      'Hombre de Jayhuamachay',
    ],
    correctAnswer: 0,
    explanation:
        'El Hombre de Lauricocha destaca por tener los restos humanos más antiguos de la sierra (once esqueletos descubiertos) y evidenciar prácticas funerarias y espirituales en el Periodo Lítico andino.',
  ),
  Question(
    id: 'cs_q19',
    topicId: 'cs_t1',
    text:
        "El arte rupestre andino ofrece una ventana invaluable a la cosmovisión de los cazadores-recolectores. En la región sur (Tacna), la cueva del Diablo alberga pinturas que representan escenas de caza comunal de guanacos, utilizando la técnica del acorralamiento conocida como 'chaco'. Estas pinturas, investigadas por Miomir Bojovich y Emilio González, corresponden al:",
    options: [
      'Hombre de Lauricocha',
      'Hombre de Chivateros',
      'Hombre de Toquepala',
      'Hombre de Paracas',
      'Hombre de Paiján',
    ],
    correctAnswer: 2,
    explanation:
        "Las cuevas de Toquepala (Tacna) contienen el arte rupestre más famoso del Perú, con escenas mágico-religiosas que escenifican el 'chaco' o cacería colectiva.",
  ),
  Question(
    id: 'cs_q20',
    topicId: 'cs_t1',
    text:
        'El arqueólogo Edward Lanning descubrió en la desembocadura del río Chillón (Lima) un inmenso yacimiento del Periodo Lítico que se caracterizaba por la abundancia de preformas y herramientas líticas inconclusas, considerado el taller lítico más grande de la costa peruana. Se trata del:',
    options: [
      'Hombre de Caral',
      'Hombre de Chivateros',
      'Hombre de Chuquitanta',
      'Hombre de Sechín',
      'Hombre de Garagay',
    ],
    correctAnswer: 1,
    explanation:
        'Chivateros es interpretado como un gigantesco taller lítico o cantera donde los antiguos pobladores obtenían cuarcita para fabricar preformas (hachas de mano) que luego terminaban en otros campamentos.',
  ),
  Question(
    id: 'cs_q21',
    topicId: 'cs_t1',
    text:
        "El final del Pleistoceno y el inicio del Holoceno trajo consigo cambios climáticos (calentamiento) que provocaron la extinción de la megafauna en los Andes. El hombre andino tuvo que adaptar su economía de subsistencia, dando paso al 'Periodo Arcaico Inferior'. La principal característica sociológica y económica de esta etapa de transición es:",
    options: [
      'El surgimiento de estados teocráticos-militares fuertemente centralizados.',
      'El inicio de la horticultura (agricultura incipiente) y un estilo de vida seminómada o transhumante.',
      'La invención del torno de alfarero y la fundación de ciudades-estado costeras.',
      'El inicio de las masivas expansiones imperiales hacia la amazonía.',
      'El desarrollo de una compleja red de carreteras pavimentadas.',
    ],
    correctAnswer: 1,
    explanation:
        'El Arcaico Inferior es un periodo de transición donde el hombre andino inicia la domesticación de plantas (horticultura) y animales, volviéndose seminómada, preparándose para la posterior sedentarización.',
  ),
  Question(
    id: 'cs_q22',
    topicId: 'cs_t1',
    text:
        'Durante el Periodo Arcaico Inferior, en la Cueva del Guitarrero (Áncash), el investigador Thomas Lynch halló evidencias de pallares y frijoles cultivados con una antigüedad asombrosa. Por muchos años, y clásicamente en la historiografía peruana, a este habitante se le considera el:',
    options: [
      'Primer constructor de templos piramidales.',
      'Primer agricultor tecnificado (con canales de regadío) de América.',
      'Primer músico del antiguo Perú.',
      'Primer horticultor del Perú y precursor de la agricultura andina.',
      'Primer domesticador de camélidos sudamericanos.',
    ],
    correctAnswer: 3,
    explanation:
        'El Hombre de Guitarrero es reconocido clásicamente en los currículos educativos peruanos como el primer horticultor (cultivador incipiente) del Perú, evidenciando frijoles y pallares primitivos.',
  ),
  Question(
    id: 'cs_q23',
    topicId: 'cs_t1',
    text:
        'La domesticación de animales fue paralela a la de plantas. En las punas de Junín, la arqueóloga francesa Daniéle Lavallée investigó abrigos rocosos donde encontró inmensas cantidades de huesos de vicuñas y alpacas, desde neonatos hasta adultos, evidenciando el cautiverio. Este yacimiento que documenta al primer domesticador de camélidos del Perú es:',
    options: [
      'Jayhuamachay',
      'Pikimachay',
      'Telarmachay',
      'Tres Ventanas',
      'Lauricocha',
    ],
    correctAnswer: 2,
    explanation:
        'Telarmachay es el hito arqueológico que demuestra la domesticación de camélidos andinos (llamas y alpacas), fundamental para la posterior textilería y transporte en el mundo andino.',
  ),
  Question(
    id: 'cs_q24',
    topicId: 'cs_t1',
    text:
        'En la costa peruana, durante el Arcaico Inferior, el arqueólogo Federico Engel realizó un descubrimiento asombroso en la región de Ica: restos humanos acompañados de redes de pescar hechas de fibra de cactus y un instrumento musical (una flauta de hueso de pelícano). A este antiguo poblador se le conoce como el Hombre de:',
    options: [
      'Santo Domingo (o Paracas)',
      'Chilca',
      'Pucusana',
      'Huaca Prieta',
      'Áspero',
    ],
    correctAnswer: 0,
    explanation:
        'El Hombre de Santo Domingo (o Paracas) es célebre por ser considerado el primer pescador a red y el primer músico (por el hallazgo de la flauta de hueso) de nuestro territorio.',
  ),
  Question(
    id: 'cs_q25',
    topicId: 'cs_t1',
    text:
        'Otro hallazgo fundamental de Federico Engel en la costa sur central es el Hombre de Chilca (Lima), quien habitaba en aldeas con chozas cónicas de cañas. Además del seminomadismo costero, en los entierros de Chilca se halló una evidencia biológica que demuestra una estrecha convivencia, considerándose al habitante de Chilca como el:',
    options: [
      'Primer forjador de metales preciosos.',
      'Primer domesticador del perro en el Perú.',
      'Primer constructor de andenes agrícolas.',
      'Primer curaca centralizador de Lima.',
      'Primer usuario de escritura de nudos.',
    ],
    correctAnswer: 1,
    explanation:
        'En Chilca se encontraron restos óseos de cánidos junto a entierros humanos, lo que se interpreta como la evidencia más temprana de domesticación del perro en la costa peruana.',
  ),
  Question(
    id: 'cs_q26',
    topicId: 'cs_t1',
    text:
        "El 'Periodo Arcaico Superior' (o Tardío) representa la culminación del proceso de adaptación iniciado milenios atrás. Durante esta fase se producen cambios socioeconómicos irreversibles. ¿Cuál es el rasgo definitorio de esta etapa que da origen a la civilización andina?",
    options: [
      'La invención de la cerámica policroma y el uso del hierro.',
      'El sedentarismo absoluto, sustentado en la agricultura productiva, permitiendo el surgimiento de la arquitectura monumental y el Estado teocrático.',
      'El abandono de la costa para colonizar exclusivamente las selvas bajas.',
      'El establecimiento del trueque monetizado mediante el uso de conchas Spondylus.',
      'La expansión militar y formación de un Imperio Panandino.',
    ],
    correctAnswer: 1,
    explanation:
        'El Arcaico Superior se define por el sedentarismo basado en una agricultura sólida (ej. algodón, mate). Este excedente permitió construir obras monumentales (centros ceremoniales) y organizar élites (sacerdotes).',
  ),
  Question(
    id: 'cs_q27',
    topicId: 'cs_t1',
    text:
        'La arqueóloga Ruth Shady revolucionó la historia del Perú al investigar un complejo urbano de aproximadamente 3,000 a.C. en el valle de Supe. Su complejidad arquitectónica (pirámides, plazas hundidas circulares) y extensión (66 hectáreas) demostraron que no era una simple aldea, sino el centro del primer Estado prístino de América. Este sitio es:',
    options: ['Kotosh', 'Chavín de Huántar', 'Caral', 'Sechín', 'Pachacámac'],
    correctAnswer: 2,
    explanation:
        'Caral es la ciudad sagrada más antigua de América. Demuestra que la civilización (Estado, división de clases, religión institucionalizada) surgió en Perú milenios antes de lo que se creía, de forma autónoma.',
  ),
  Question(
    id: 'cs_q28',
    topicId: 'cs_t1',
    text:
        'Una de las características más sorprendentes de la civilización de Caral, evidenciada por Ruth Shady y que rompe con esquemas sociológicos europeos sobre la formación de los Estados primitivos, es que su desarrollo y hegemonía territorial se logró, aparentemente:',
    options: [
      'Mediante el uso exclusivo de armas de bronce y una agresiva expansión militar sobre sus vecinos.',
      'Sin el conocimiento de la cerámica ni evidencia concluyente de castas guerreras organizadas, basándose en el prestigio religioso y el intercambio comercial.',
      'A través de la importación masiva de tecnología bélica mesoamericana.',
      'Esclavizando de forma brutal a millones de habitantes de la cordillera.',
      'Implementando un sistema de escritura alfabética para dictar leyes.',
    ],
    correctAnswer: 1,
    explanation:
        "Caral es una civilización 'precerámica' y pacífica. Su poder no residía en el militarismo (no hay murallas ni armas de guerra), sino en la religión, el manejo del calendario agrícola y el comercio interregional.",
  ),
  Question(
    id: 'cs_q29',
    topicId: 'cs_t1',
    text:
        'En la región de Huánuco, una expedición japonesa liderada por Seichi Izumi investigó un antiguo centro ceremonial del Arcaico Superior. Allí descubrieron un templo que albergaba, en un nicho de barro crudo, una escultura en altorrelieve que simboliza la dualidad andina. Este hito arqueológico es conocido como:',
    options: [
      'El Templo Viejo de Chavín.',
      'El Templo de las Manos Cruzadas de Kotosh.',
      'El Castillo de Huarmey.',
      'La Fortaleza de Kuélap.',
      'El complejo de Kuntur Wasi.',
    ],
    correctAnswer: 1,
    explanation:
        'El Templo de las Manos Cruzadas en Kotosh (Huánuco) es célebre por albergar la que se considera la primera escultura de carácter religioso de América, representando la dualidad (macho-hembra, arriba-abajo).',
  ),
  Question(
    id: 'cs_q30',
    topicId: 'cs_t1',
    text:
        'En el norte peruano, Junius Bird realizó excavaciones en un montículo precerámico. El descubrimiento asombró a la comunidad científica al encontrar tejidos de algodón entrelazado sin uso de telar (twining) con figuras de cóndores y serpientes, así como mates pirograbados, evidenciando un complejo arte utilitario temprano. Nos referimos a:',
    options: [
      'Huaca Prieta',
      'Huaca Rajada',
      'El Brujo',
      'Garagay',
      'Sechín Bajo',
    ],
    correctAnswer: 0,
    explanation:
        'Huaca Prieta (La Libertad) es un yacimiento clave del Arcaico Superior, famoso por sus extraordinarios textiles de algodón precerámico y el icónico mate con la figura estilizada de un felino o rostro humano.',
  ),
  Question(
    id: 'cs_q31',
    topicId: 'cs_t1',
    text:
        "Durante el Arcaico Superior, en el valle del río Chillón (Lima), floreció uno de los complejos arquitectónicos más grandes de la costa central, formado por inmensas plataformas en forma de 'U', demostrando una movilización colosal de fuerza de trabajo antes de la invención de la cerámica. Este sitio fue estudiado por Federico Engel y es conocido como:",
    options: [
      'El Paraíso (o Chuquitanta)',
      'Bandurria',
      'Las Haldas',
      'Áspero',
      'Punta Lobos',
    ],
    correctAnswer: 0,
    explanation:
        'El Complejo El Paraíso (Chuquitanta) abarca 50 hectáreas y edificaciones piramidales en forma de U, siendo el monumento arquitectónico precerámico más extenso de la costa peruana central.',
  ),
  Question(
    id: 'cs_q32',
    topicId: 'cs_t1',
    text:
        'Recientes investigaciones arqueológicas dirigidas por Peter Fuchs y Renate Patzschke en Casma (Áncash) descubrieron una plaza circular hundida datada mediante radiocarbono con más de 5,000 años de antigüedad, disputando el título de la arquitectura pública más antigua del continente. Este hallazgo corresponde al sitio de:',
    options: [
      'Moxeke',
      'Cerro Sechín',
      'Sechín Bajo',
      'Las Haldas',
      'Casma Alta',
    ],
    correctAnswer: 2,
    explanation:
        'Sechín Bajo ha revelado una plaza circular hundida datada en el 3500 a.C., anterior a la ciudad de Caral, evidenciando que la tradición arquitectónica monumental peruana es aún más antigua.',
  ),
  Question(
    id: 'cs_q33',
    topicId: 'cs_t1',
    text:
        'A nivel doctrinal sociológico y policial, analizar las causas estructurales que impulsaron a los antiguos humanos a transitar del nomadismo al sedentarismo nos permite entender el origen de la propiedad privada y los conflictos territoriales. ¿Cuál fue el factor determinante, desde la antropología económica, para que los grupos humanos decidieran asentarse permanentemente y delimitar tierras?',
    options: [
      'El descubrimiento de metales preciosos que debían ser custodiados en bóvedas subterráneas.',
      'La amenaza constante de invasiones de homínidos neandertales desde el norte.',
      'La producción controlada de excedentes alimenticios gracias a la agricultura y ganadería, requiriendo su cuidado continuo.',
      'La invención del transporte a vela que permitía el comercio marítimo estacionario.',
      'Órdenes emanadas por jerarcas de civilizaciones extraterrestres plasmadas en geoglifos.',
    ],
    correctAnswer: 2,
    explanation:
        'La agricultura exige permanecer junto a la siembra para cuidarla y cosecharla. Los excedentes generados (alimento sobrante) crean el concepto de propiedad, riqueza acumulable y necesidad de defensa del territorio, germen del Estado.',
  ),
  Question(
    id: 'cs_q34',
    topicId: 'cs_t1',
    text:
        'La tesis de Tom Dillehay en el valle del Alto Zaña (Cajamarca) sostiene el hallazgo de evidencias de calabaza, maní y quinua domesticados con una antigüedad de hasta 7000 a.C., postulando a estos pobladores como los verdaderos primeros horticultores del Perú y América. Este polémico yacimiento es conocido como:',
    options: [
      'Nanchoc',
      'Tres Ventanas',
      'Guitarrero I',
      'Guitarrero II',
      'Paiján Temprano',
    ],
    correctAnswer: 0,
    explanation:
        'Nanchoc ha desplazado en datación absoluta a Guitarrero en cuanto a las primeras evidencias de horticultura en el Perú, convirtiéndolo en un hito crucial del Arcaico Inferior andino.',
  ),
  Question(
    id: 'cs_q35',
    topicId: 'cs_t1',
    text:
        'El estudio de la evolución biológica del hombre (Hominización) demuestra que el crecimiento acelerado del cerebro (encefalización) exigió una enorme cantidad de energía metabólica. Este requerimiento fue solventado gracias a un cambio drástico en la dieta de los primeros integrantes del género Homo. ¿Qué componente dietario posibilitó esta demanda energética?',
    options: [
      'El consumo masivo de tubérculos crudos y raíces venenosas.',
      'La ingesta exclusiva de frutas cítricas ricas en vitamina C.',
      'La incorporación sistemática de proteínas y grasas animales (carroñeo y caza) en la dieta diaria.',
      'La masticación continua de hojas de coca silvestre y lianas fibrosas.',
      'La asimilación de minerales extraídos de manantiales sulfurosos.',
    ],
    correctAnswer: 2,
    explanation:
        'El cerebro humano consume el 20% de la energía corporal. Evolutivamente, fue imposible sostener este órgano sin la alta densidad calórica y nutricional que aportó el consumo recurrente de carne y médula ósea.',
  ),
  Question(
    id: 'cs_q36',
    topicId: 'cs_t1',
    text:
        'La domesticación del fuego no solo brindó abrigo, sino que tuvo un impacto directo en la morfología del aparato digestivo y masticatorio de los homínidos. Al cocinar los alimentos (especialmente la carne y tubérculos), se produjo una consecuencia anatómica progresiva que facilitó la evolución del lenguaje articulado. Esta consecuencia fue:',
    options: [
      'La atrofia de las cuerdas vocales por el humo de las fogatas.',
      'La disminución del tamaño de las mandíbulas, reducción de los músculos masticadores y pérdida del prognatismo.',
      'El crecimiento desmesurado de los colmillos para rasgar la carne asada.',
      'El ensanchamiento del tórax para almacenar mayores volúmenes de aire.',
      'La fusión permanente de los huesos craneales parietales y temporales.',
    ],
    correctAnswer: 1,
    explanation:
        'Al cocinar los alimentos, se ablandan. La necesidad biológica de poseer mandíbulas macizas (prognatismo) y dientes enormes desapareció, permitiendo que la cara se retraiga y el cráneo cambie de forma, optimizando la cavidad bucal para la articulación de sonidos complejos.',
  ),
  Question(
    id: 'cs_q37',
    topicId: 'cs_t1',
    text:
        'Dentro del proceso de poblamiento de América, la teoría de Mendes Correia (Australiana) sugiere un puente terrestre que unía a Sudamérica con la Antártida. A nivel geográfico contemporáneo, ¿cuál es el archipiélago o formación de tierra más extremo en el sur del continente americano que habría servido de puerta de entrada según esta teoría?',
    options: [
      'Las Islas Galápagos.',
      'El Archipiélago Juan Fernández.',
      'Tierra del Fuego y el Cabo de Hornos.',
      'Las Islas Malvinas.',
      'El Golfo de Guayaquil.',
    ],
    correctAnswer: 2,
    explanation:
        'Tierra del Fuego (extremo sur de Chile y Argentina) es el punto continental más cercano a la península antártica y habría sido el área de asentamiento inicial para los migrantes australianos que bordearon el hielo.',
  ),
  Question(
    id: 'cs_q38',
    topicId: 'cs_t1',
    text:
        "La 'Revolución Neolítica' (paso a la economía productora) no se produjo de forma simultánea en todo el mundo, sino en 'núcleos originarios'. El núcleo más antiguo y famoso del planeta, donde se domesticó tempranamente el trigo y la cebada (asentamientos como Jericó o Çatalhöyük), abarcaba el territorio de Mesopotamia y Egipto. A esta región se le denomina históricamente:",
    options: [
      'El Anillo de Fuego del Pacífico.',
      'La Media Luna Fértil (Creciente Fértil).',
      'La Meseta de Anatolia.',
      'El Valle del Indo.',
      'La Fosa Tectónica del Rift.',
    ],
    correctAnswer: 1,
    explanation:
        "El 'Creciente Fértil' (Oriente Próximo, desde el Golfo Pérsico hasta el Delta del Nilo) es la cuna de la agricultura mundial, donde surgió la Revolución Neolítica hace aproximadamente 10,000 años.",
  ),
  Question(
    id: 'cs_q39',
    topicId: 'cs_t1',
    text:
        'En el Perú precerámico (Arcaico Superior), la construcción de grandes centros ceremoniales como Caral o Áspero no habría sido posible sin el dominio de una tecnología fundamental que permitió la recolección, pesca a gran escala y la vestimenta, reemplazando las pieles de animales. Nos referimos a la domesticación y uso sistemático de:',
    options: [
      'La lana de alpaca para finos telares de cintura.',
      'El cultivo y entrelazado (sin telar) de la planta de algodón (Gossypium barbadense).',
      'La fibra sintética derivada del procesamiento de petróleo primitivo.',
      'El cuero de guanaco teñido con minerales tóxicos.',
      'La corteza de los árboles de quina importada de la selva.',
    ],
    correctAnswer: 1,
    explanation:
        'El algodón fue el motor económico y textil de la civilización andina primigenia. Permitía tejer ropa, elaborar grandes redes para la masiva pesca de anchoveta y fue un bien de intercambio invaluable (trueque).',
  ),
  Question(
    id: 'cs_q40',
    topicId: 'cs_t1',
    text:
        'El hombre andino del Periodo Lítico desarrolló tecnologías especializadas para la caza de megafauna extinta (como el megaterio o mastodonte) y camélidos. La técnica de fabricación de sus puntas líticas de proyectil alcanzó altos niveles de eficacia, destacan por su diseño simétrico en forma de hoja. Un yacimiento representativo de esta fina lítica en La Libertad es:',
    options: ['Kotosh', 'Paiján', 'Guitarrero', 'Chilca', 'Caral'],
    correctAnswer: 1,
    explanation:
        "Las 'Puntas de Paiján' son célebres en la arqueología peruana; son delgadas, con un pedúnculo en la base para ser amarradas fuertemente a una lanza, y demuestran gran destreza en el tallado a presión.",
  ),
  Question(
    id: 'cs_q41',
    topicId: 'cs_t1',
    text:
        'Una característica peculiar de los entierros de los primeros cazadores peruanos (como los de Lauricocha) y que se asemeja a rituales del Paleolítico en el viejo mundo, es que los cadáveres eran cubiertos con un polvo mineral de color rojizo vivo, lo que denota un fuerte simbolismo religioso o creencia en la vida post-mortem. Este mineral es:',
    options: [
      'El cinabrio o arcilla con ocre rojo.',
      'La pirita o el oro en polvo.',
      'El lapislázuli triturado.',
      'La cal viva para descomposición rápida.',
      'El carbón de leña mezclado con ceniza volcánica.',
    ],
    correctAnswer: 0,
    explanation:
        'El uso del ocre rojo (o cinabrio) en los entierros es una práctica ritual universal en la prehistoria, que simbolizaba la sangre y, por extensión, la vida o la resurrección.',
  ),
  Question(
    id: 'cs_q42',
    topicId: 'cs_t1',
    text:
        'Si analizamos sociológicamente la formación del Estado en Caral (3000 a.C.), notamos que la casta dominante que dirigía los destinos de la ciudad y monopolizaba los conocimientos (astronomía, agricultura, edificación) no estaba conformada por militares armados, sino por:',
    options: [
      'Comerciantes marítimos extranjeros.',
      'Guerreros sanguinarios y verdugos.',
      'Cazadores de élite nómadas.',
      'Sacerdotes - astrónomos (Élite teocrática).',
      'Esclavos liberados de civilizaciones andinas del sur.',
    ],
    correctAnswer: 3,
    explanation:
        'El Estado prístino andino fue de naturaleza teocrática. Los sacerdotes basaban su inmenso poder coercitivo en el control del conocimiento astronómico, vital para predecir las lluvias y garantizar el éxito agrícola del pueblo.',
  ),
  Question(
    id: 'cs_q43',
    topicId: 'cs_t1',
    text:
        "El yacimiento precerámico de Áspero (Supe), contemporáneo a Caral, es frecuentemente denominado la 'ciudad pesquera'. Su existencia e interdependencia con Caral demuestra tempranamente en el antiguo Perú un concepto económico fundamental que sustenta a las civilizaciones complejas. Este concepto es:",
    options: [
      'El monopolio de la moneda de oro.',
      'La división social del trabajo y el intercambio complementario (trueque costa-valle).',
      'La imposición de tributos bélicos a naciones vencidas.',
      'El aislamiento autárquico de cada pequeña aldea.',
      'La industrialización del procesamiento de conservas de pescado.',
    ],
    correctAnswer: 1,
    explanation:
        'Áspero (costa) producía pescado seco (anchoveta) y Caral (valle adentro) producía algodón y vegetales. Intercambiaban estos productos (división del trabajo), lo que generó prosperidad y crecimiento urbano en ambos.',
  ),
  Question(
    id: 'cs_q44',
    topicId: 'cs_t1',
    text:
        'La arqueóloga Josefina Ramos de Cox, junto a Mercedes Cárdenas, descubrieron en el balneario de Ancón y en la zona de Tablada de Lurín (Lima) un inmenso yacimiento funerario y campamentos de pobladores del Arcaico. Sin embargo, el sitio de la costa limeña que destaca por albergar a pescadores-marisqueros que dejaban inmensos montículos de conchas (conchales) y restos de la dieta marina se asocia primordialmente a las costumbres de:',
    options: [
      'Los horticultores de Kotosh.',
      'Los cazadores de Telarmachay.',
      'Los hombres de Chilca y Santo Domingo.',
      'Los constructores de Caral.',
      'Los orfebres de Vicús.',
    ],
    correctAnswer: 2,
    explanation:
        "La formación de 'conchales' (basurales prehistóricos de conchas) es la huella arqueológica inconfundible del Hombre de Chilca, Santo Domingo y otros pobladores costeros del Arcaico, denotando dependencia marítima.",
  ),
  Question(
    id: 'cs_q45',
    topicId: 'cs_t1',
    text:
        'El estudio de la paleopatología en restos óseos andinos revela que el tránsito de la economía cazadora a la economía agrícola trajo consigo ciertos problemas de salud producto del sedentarismo y la dieta alta en carbohidratos, problemas que no sufrían los cazadores del Periodo Lítico. Una evidencia patológica típica del paso al Arcaico Superior es:',
    options: [
      'La desaparición repentina de la artritis por falta de movimiento.',
      'El aumento masivo de caries dentales y desgaste por moler granos y comer almidón.',
      'El alargamiento anormal y extremo de los huesos de las piernas.',
      'La curación total y espontánea de fracturas craneales.',
      'La inmunidad adquirida frente a todas las enfermedades virales modernas.',
    ],
    correctAnswer: 1,
    explanation:
        'La agricultura incrementó el consumo de carbohidratos complejos (maíz, tubérculos procesados). Esto incrementó drásticamente la tasa de caries y deterioro dental en comparación con los cazadores-recolectores con dieta proteica.',
  ),
  Question(
    id: 'cs_q46',
    topicId: 'cs_t1',
    text:
        'Dentro de la Teoría Autoctonista de Florentino Ameghino (refutada), él postulaba que la humanidad había surgido en la Era Terciaria (Cenozoica). Sin embargo, la paleontología y geología modernas demuestran contundentemente que los primeros homínidos de la evolución, y por ende el género Homo, aparecieron realmente durante la era:',
    options: [
      'Era Paleozoica',
      'Era Mesozoica (Jurásico)',
      'Era Cuaternaria (Pleistoceno)',
      'Era Arcaica',
      'Era Azoica',
    ],
    correctAnswer: 2,
    explanation:
        'El género Homo (habilis, erectus, sapiens) se desarrolló evolutivamente y protagonizó las grandes migraciones mundiales durante el periodo del Pleistoceno de la Era Cuaternaria (marcada por las glaciaciones).',
  ),
  Question(
    id: 'cs_q47',
    topicId: 'cs_t1',
    text:
        'La Teoría Oceánica de Paul Rivet postula que los antiguos polinésicos llegaron a América por vía marítima, y para validar esta increíble proeza naval en mar abierto, Thor Heyerdahl organizó en 1947 una expedición para demostrar que era posible cruzar el Pacífico en una rudimentaria balsa de troncos utilizando las corrientes marinas. ¿Con qué nombre pasó a la historia esta famosa expedición científica?',
    options: [
      'El viaje de Magallanes.',
      'La balsa Kon-Tiki.',
      'La expedición Beagle.',
      'El viaje de la Santa María.',
      'El proyecto Apolo.',
    ],
    correctAnswer: 1,
    explanation:
        "Thor Heyerdahl construyó la balsa 'Kon-Tiki' y zarpó del Perú logrando llegar a la Polinesia (en sentido inverso, para probar la migración americana hacia el oeste, aunque también avaló la capacidad navegante del mundo antiguo en el Pacífico).",
  ),
  Question(
    id: 'cs_q48',
    topicId: 'cs_t1',
    text:
        'Los Paranthropus (ej. Paranthropus boisei) fueron una rama paralela y contemporánea a los primeros integrantes del género Homo en África. A pesar de compartir un ancestro común, los Paranthropus se extinguieron sin dejar descendencia debido a una especialización biológica extrema que los condenó ante el cambio climático. ¿En qué consistió dicha especialización?',
    options: [
      'Desarrollaron extremidades palmeadas para vivir exclusivamente en océanos profundos.',
      'Desarrollaron una dieta vegetariana extremadamente especializada (hojas duras, semillas) con un aparato masticador gigante (mandíbulas y molares masivos).',
      'Perdieron totalmente la visión y dependían de la ecolocalización en cuevas.',
      'Desarrollaron alas membranosas perdiendo la capacidad de caminar.',
      'Fueron masacrados sistemáticamente por dinosaurios carnívoros.',
    ],
    correctAnswer: 1,
    explanation:
        'Los Paranthropus eran hiperespecializados: sus cráneos tenían crestas sagitales para músculos masticadores inmensos, adaptados a comer raíces duras. Al secarse la sabana africana y desaparecer ese alimento, se extinguieron al no poder adaptarse como el Homo habilis, que comía carne.',
  ),
  Question(
    id: 'cs_q49',
    topicId: 'cs_t1',
    text:
        "El poblamiento de América del Norte implicó el paso de cazadores por Beringia, persiguiendo enormes manadas de mamuts. Estos primeros pobladores desarrollaron la 'Cultura Clovis', famosa en Estados Unidos y México por dejar un rastro arqueológico inconfundible que revolucionó la cacería de la megafauna pleistocénica. Nos referimos a:",
    options: [
      'Cabañas de hielo en forma de iglú.',
      'Grandes balsas de vela para caza de ballenas.',
      'Puntas de proyectil de piedra acanaladas y extremadamente filosas (Puntas Clovis).',
      'Domesticación y crianza en corrales de osos polares.',
      'Metalurgia del hierro forjado y armaduras de placas.',
    ],
    correctAnswer: 2,
    explanation:
        "Las 'Puntas Clovis' tienen una acanaladura central (para insertar el astil de madera). Representan la primera gran tecnología balística y de caza de precisión originada de forma independiente en Norteamérica para derribar grandes herbívoros.",
  ),
  Question(
    id: 'cs_q50',
    topicId: 'cs_t1',
    text:
        'Para un futuro Oficial PNP, analizar la transición prehistórica de sociedades igualitarias de cazadores hacia sociedades estratificadas (Arcaico Superior, ej. Caral) ayuda a comprender el origen del orden jerárquico. En la prehistoria andina, la aparición de murallas defensivas, la monopolización del excedente alimenticio y la creación de un sistema religioso punitivo, marcaron invariablemente el nacimiento de:',
    options: [
      'El comunismo originario igualitario andino.',
      'La sociedad anarquista sin control centralizado.',
      'El Estado, como institución de control social y administración de la coerción y los recursos.',
      'Un gobierno parlamentario democrático con división de poderes.',
      'La abolición completa de las diferencias de género en el mundo andino.',
    ],
    correctAnswer: 2,
    explanation:
        'Las grandes construcciones y diferencias de entierros evidencian una casta dominante que se separa del pueblo productor. Este control del excedente agrícola y la religión marcan el origen del Estado como ente de poder e incipiente autoridad punitiva/administrativa.',
  ),
  Question(
    id: 'cs_q51',
    topicId: 'cs_t1',
    text:
        'En el marco de la hominización, la industria lítica no es un fenómeno homogéneo. La transición del Paleolítico Inferior al Medio se marca por el paso de la talla mediante percusión directa y obtención de choppers, hacia una técnica que predetermina la forma de la lasca antes de extraerla del núcleo. Esta revolucionaria técnica, asociada primariamente a los Neandertales, es conocida como:',
    options: [
      'Técnica de Achelense superior.',
      'Técnica Levallois.',
      'Técnica Solutrense.',
      'Microlitismo geométrico.',
      'Técnica Clovis.',
    ],
    correctAnswer: 1,
    explanation:
        'La técnica Levallois (Paleolítico Medio / Musteriense) implica una preparación compleja del núcleo de piedra para obtener lascas de forma predeterminada, evidenciando un salto cognitivo en la planificación espacial del Homo neanderthalensis.',
  ),
  Question(
    id: 'cs_q52',
    topicId: 'cs_t1',
    text:
        'El estudio de la dentición de los homínidos proporciona evidencia directa sobre su dieta y adaptaciones ecológicas. La reducción del tamaño de los caninos y el engrosamiento del esmalte dental en géneros tempranos como el *Ardipithecus* y *Australopithecus* sugieren:',
    options: [
      'Una adaptación exclusiva al consumo de carne cruda y carroñeo.',
      'La pérdida del bipedismo en favor de un desplazamiento braquiador.',
      'Una dieta progresivamente menos dependiente de hojas tiernas y más centrada en alimentos duros y abrasivos (semillas, raíces) de la sabana.',
      'La necesidad de armas biológicas más efectivas para la caza mayor.',
      'Una mutación provocada por la ingesta de fuego en etapas pre-habilis.',
    ],
    correctAnswer: 2,
    explanation:
        'Al cambiar el entorno de selva a sabana, los homínidos tempranos se adaptaron a consumir recursos más correosos y duros, lo que se refleja en molares grandes y esmalte grueso (megadoncia), perdiendo los caninos grandes típicos de los simios folívoros/frugívoros.',
  ),
  Question(
    id: 'cs_q53',
    topicId: 'cs_t1',
    text:
        'El *Homo antecessor*, cuyos restos más emblemáticos fueron hallados en la Gran Dolina (Atapuerca, España), posee una importancia filogenética capital en la paleoantropología europea. Según sus descubridores, su principal rol evolutivo sería:',
    options: [
      'Ser el ancestro directo exclusivo del Homo sapiens asiático.',
      'Representar al último eslabón de los australopitecos fuera de África.',
      'Ser el antepasado común más plausible entre el Homo neanderthalensis (linaje europeo) y el Homo sapiens (linaje africano).',
      'Haber sido el primer homínido en domesticar lobos para la cacería.',
      'Constituir una rama extinta sin descendencia, paralela al Homo erectus en África.',
    ],
    correctAnswer: 2,
    explanation:
        'Los fósiles de H. antecessor (aprox. 800,000 años) muestran una morfología facial sorprendentemente moderna, y se postula que es el ancestro común (o cercano a él) que divergió dando lugar a los neandertales en Europa y a los sapiens en África.',
  ),
  Question(
    id: 'cs_q54',
    topicId: 'cs_t1',
    text:
        "El bipedismo obligó a un reordenamiento del canal de parto en las hembras homínidas, haciéndolo más estrecho, lo cual, sumado al aumento de la capacidad craneal del feto, generó el llamado 'Dilema obstétrico'. La solución evolutiva a este conflicto biomecánico consistió en:",
    options: [
      'El nacimiento de crías completamente desarrolladas e independientes (precociales).',
      'El acortamiento del periodo de gestación, pariendo crías neurológicamente inmaduras (altriciales) que requieren un cuidado parental prolongado.',
      'La regresión temporal del tamaño del cerebro durante los primeros tres años de vida.',
      'El desarrollo de caderas extremadamente anchas que limitaban la capacidad de correr.',
      'La adopción de una dieta exclusivamente vegetariana durante el embarazo.',
    ],
    correctAnswer: 1,
    explanation:
        "El dilema obstétrico se resolvió pariendo bebés 'prematuros' neurológicamente. El cerebro humano crece mayormente fuera del útero materno (altricialidad secundaria), lo que fomenta el desarrollo de vínculos sociales fuertes (cuidado aloparental).",
  ),
  Question(
    id: 'cs_q55',
    topicId: 'cs_t1',
    text:
        'Durante el Mesolítico se produjo un cambio climático drástico (Holoceno) que transformó las estepas tundras en bosques y extinguió a la megafauna pleistocénica. Frente a la desaparición de sus grandes presas, el hombre mesolítico desarrolló tecnológicamente:',
    options: [
      'El uso exclusivo del cobre para la guerra entre clanes.',
      'El microlitismo (pequeñas herramientas de piedra para armar arcos y flechas) y una economía de recolección de amplio espectro.',
      'La construcción de grandes pirámides para la adoración solar.',
      'El abandono de la caza y una dependencia absoluta e inmediata de la agricultura.',
      'La domesticación del caballo como medio de transporte nómada.',
    ],
    correctAnswer: 1,
    explanation:
        'Al extinguirse la megafauna, los cazadores debieron adaptarse a cazar presas más pequeñas y esquivas (como ciervos) en zonas boscosas. El microlitismo (puntas de flecha, arpones) fue la respuesta tecnológica a este nuevo entorno.',
  ),
  Question(
    id: 'cs_q56',
    topicId: 'cs_t1',
    text:
        "La Revolución Neolítica no ocurrió simultáneamente en todo el planeta. Uno de los primeros y más importantes focos originarios de domesticación de plantas y animales fue la 'Media Luna Fértil'. En esta región, las especies fundadoras que cimentaron la economía agrícola incluyeron:",
    options: [
      'Maíz, papa, quinua, llama y cuy.',
      'Arroz, mijo, cerdo y gusano de seda.',
      'Trigo, cebada, ovejas, cabras y vacas.',
      'Sorgo, ñame, gallina y camello.',
      'Yuca, maní, pavo y perro.',
    ],
    correctAnswer: 2,
    explanation:
        'La Media Luna Fértil (Cercano Oriente / Mesopotamia y Levante) domesticó el trigo y la cebada (cereales), así como a los ovinos, caprinos, bóvidos y suidos, sentando las bases de la civilización occidental.',
  ),
  Question(
    id: 'cs_q57',
    topicId: 'cs_t1',
    text:
        'El proceso de domesticación vegetal implica la selección artificial por parte del ser humano. En el caso del maíz (Zea mays), cultivado magistralmente en América precolombina, la domesticación provocó una mutación clave respecto a su ancestro silvestre (el teosinte). Esta característica indispensable para la agricultura fue:',
    options: [
      'La pérdida del mecanismo de dispersión natural de las semillas (raquis no quebradizo), haciendo que la planta dependa del humano para reproducirse.',
      'La capacidad de germinar en agua salada de mar.',
      'El cambio de color de las hojas para hacer fotosíntesis nocturna.',
      'El desarrollo de espinas venenosas para alejar a los roedores.',
      'La maduración de la mazorca bajo tierra como los tubérculos.',
    ],
    correctAnswer: 0,
    explanation:
        "El 'síndrome de domesticación' incluye evitar que la espiga se quiebre (raquis duro) al madurar. El teosinte dispersa sus semillas al caer; el maíz domesticado las retiene en la mazorca, obligando al agricultor a desgranarlo y sembrarlo.",
  ),
  Question(
    id: 'cs_q58',
    topicId: 'cs_t1',
    text:
        "Las teorías sobre el poblamiento de América debaten sobre las rutas migratorias. La 'Teoría del corredor libre de hielo' postula que los primeros humanos cruzaron Beringia y avanzaron hacia el sur por un pasillo abierto entre dos grandes placas de hielo (Laurentino y Cordillerano). Sin embargo, hallazgos recientes han desafiado esta teoría al sugerir que:",
    options: [
      'Los humanos llegaron volando en primitivos globos aerostáticos.',
      'El corredor de hielo se abrió mucho después (aprox. 13,000 AP) de que ya existieran asentamientos humanos consolidados en Sudamérica (ej. Monte Verde en Chile, 14,500 AP).',
      'Los neandertales ocupaban dicho corredor, impidiendo el paso a los sapiens.',
      'El corredor estaba inundado de lava volcánica, haciéndolo intransitable.',
      'No existía Beringia, sino un puente de tierra desde la Antártida hasta Tierra del Fuego.',
    ],
    correctAnswer: 1,
    explanation:
        'Evidencias como Monte Verde (Chile) o Huaca Prieta (Perú) son anteriores a la apertura ecológicamente viable del corredor libre de hielo, lo que da gran fuerza a la teoría de la migración costera del Pacífico (uso de embarcaciones bordeando la costa).',
  ),
  Question(
    id: 'cs_q59',
    topicId: 'cs_t1',
    text:
        "En el contexto de la hominización, la posición del 'foramen magnum' (orificio occipital) en el cráneo es un indicador clave para los paleontólogos. Su desplazamiento evolutivo hacia la base central del cráneo (como en humanos modernos) en contraposición a su posición posterior (como en chimpancés), es la prueba biomecánica innegable de:",
    options: [
      'La adaptación a una dieta estrictamente carnívora.',
      'El aumento exponencial del volumen de la corteza prefrontal.',
      'La adquisición del bipedismo habitual y la postura erguida, permitiendo que el cráneo se balancee en equilibrio sobre la columna vertebral.',
      'La capacidad biológica para articular un lenguaje sintáctico complejo.',
      'El desarrollo de la visión estereoscópica tridimensional.',
    ],
    correctAnswer: 2,
    explanation:
        'El foramen magnum central permite que la cabeza se apoye verticalmente sobre la columna, ahorrando energía muscular al caminar erguido (bipedismo). En los cuadrúpedos, se ubica hacia atrás.',
  ),
  Question(
    id: 'cs_q60',
    topicId: 'cs_t1',
    text:
        "El *Homo floresiensis*, descubierto en la isla de Flores (Indonesia), apodado 'Hobbit', presentó un desafío a las teorías evolutivas tradicionales debido a su pequeña estatura (1 metro) y su diminuto cerebro, coexistiendo cronológicamente con el Homo sapiens moderno. La hipótesis biológica más aceptada para explicar su morfología es:",
    options: [
      'Es una población de Homo sapiens que padecía microcefalia y enanismo hipofisario masivo.',
      "Es el resultado de un aislamiento geográfico prolongado que generó 'enanismo insular', una adaptación ecológica típica de mamíferos grandes confinados en islas con recursos limitados.",
      'Fueron extraterrestres que dejaron descendencia en la polinesia.',
      'Resultó de la hibridación entre humanos y primates actuales menores como los macacos.',
      'Es un Australopithecus africano que migró flotando sobre balsas hacia Asia.',
    ],
    correctAnswer: 1,
    explanation:
        'El enanismo insular es un fenómeno evolutivo comprobado (ej. elefantes pigmeos en la misma isla). Poblaciones aisladas de homínidos (posiblemente de H. erectus o H. habilis) redujeron su tamaño durante milenios para sobrevivir con menos comida.',
  ),
  Question(
    id: 'cs_q61',
    topicId: 'cs_t1',
    text:
        "El Paleolítico Superior se caracteriza por una explosión de la capacidad simbólica y artística, representada emblemáticamente por el 'Arte Parietal' (pinturas rupestres en cuevas como Altamira y Lascaux). Según las interpretaciones antropológicas predominantes, este arte cumplía un rol fundamentalmente:",
    options: [
      'Exclusivamente decorativo para embellecer los espacios habitacionales.',
      'Magico-religioso (magia simpática), intentando propiciar el éxito en la caza y el control sobre los animales representados.',
      'Como registro contable de las deudas entre clanes comerciales.',
      'De mapas cartográficos a escala real para invasiones territoriales.',
      'Únicamente como pasatiempo lúdico para los niños de la tribu.',
    ],
    correctAnswer: 1,
    explanation:
        'La antropología sugiere que pintar al animal herido o preñado era un acto chamánico (magia propiciatoria) para asegurar el alimento y la reproducción de las manadas, no simple decoración (pues se ubicaban en zonas profundas y oscuras de las cuevas).',
  ),
  Question(
    id: 'cs_q62',
    topicId: 'cs_t1',
    text:
        "El debate sobre el origen del hombre moderno (Homo sapiens) tiene dos grandes modelos teóricos contrapuestos: el modelo 'Multirregional' (evolución simultánea en varios continentes) y el modelo 'Fuera de África' (Out of Africa). La genética moderna, a través del análisis del ADN mitocondrial (la 'Eva mitocondrial'), ha brindado un apoyo abrumador al modelo:",
    options: [
      'Multirregional, demostrando que chinos, europeos y africanos provienen de ancestros distintos (Homo erectus de cada zona).',
      'Fuera de África, demostrando que todos los humanos actuales descendemos de una población fundadora originaria de África hace aproximadamente 200,000 años.',
      'Híbrido de origen europeo, indicando que los sapiens nacieron en España.',
      'Asiático, señalando a la India como cuna exclusiva de la humanidad.',
      'Policéntrico puro, donde el sapiens evolucionó de forma convergente y sin cruzarse con otros linajes.',
    ],
    correctAnswer: 1,
    explanation:
        'El ADN mitocondrial demuestra que la mayor diversidad genética humana está en África subsahariana, indicando que es nuestra cuna más antigua. Todos los demás humanos son un subgrupo que migró de África (modelo Out of Africa o Reemplazo).',
  ),
  Question(
    id: 'cs_q63',
    topicId: 'cs_t1',
    text:
        'El periodo Neolítico en el Antiguo Perú (Arcaico Superior) presenta una de las revoluciones urbanas más singulares del mundo (ej. Caral), debido a que el desarrollo de la arquitectura monumental, clases sociales y un estado teocrático se logró de manera prístina:',
    options: [
      'Basado en una economía sustentada enteramente en la domesticación del caballo y el hierro.',
      'Sin la invención ni el conocimiento previo de la alfarería (cerámica), desafiando el modelo evolutivo del viejo mundo.',
      'Gracias a la influencia directa de navegantes mesoamericanos olmecas.',
      'Mediante la esclavitud militarizada de tribus amazónicas traídas a la fuerza.',
      'Con un sistema de escritura alfabético plenamente desarrollado en papiro.',
    ],
    correctAnswer: 1,
    explanation:
        "Caral (3000 a.C.) es excepcional porque es una civilización compleja, urbana, agrícola y con estado, pero es 'precerámica' (Arcaico Superior). En el Viejo Mundo, la cerámica siempre precedió a la civilización urbana.",
  ),
  Question(
    id: 'cs_q64',
    topicId: 'cs_t1',
    text:
        'El descubrimiento de la estructura molecular del ADN de fósiles de neandertales revolucionó nuestra comprensión de las migraciones humanas. ¿Qué hito comprobado genéticamente alteró el paradigma de que el *Homo sapiens* simplemente exterminó y reemplazó a las demás especies sin mezclarse?',
    options: [
      'Se descubrió que los sapiens provienen evolutivamente del Homo floresiensis.',
      'Se comprobó que existe introgresión (hibridación); las poblaciones no africanas actuales poseen entre un 1.5% y un 2% de ADN neandertal.',
      'Se demostró que el ADN del hombre moderno es 100% distinto al de los neandertales, confirmando el aislamiento reproductivo absoluto.',
      'Los neandertales son los ancestros biológicos de todos los pueblos subsaharianos.',
      'El ADN confirmó que los neandertales fueron creados genéticamente por hibridación con chimpancés.',
    ],
    correctAnswer: 1,
    explanation:
        'El genetista Svante Pääbo (Premio Nobel) demostró que cuando el H. sapiens salió de África, se encontró con los neandertales en Medio Oriente/Europa y se reprodujeron. Ese legado genético pervive en humanos euroasiáticos, pero no en poblaciones africanas originarias.',
  ),
  Question(
    id: 'cs_q65',
    topicId: 'cs_t1',
    text:
        'Durante el poblamiento temprano del territorio andino (Periodo Lítico), los primeros pobladores (ej. Hombre de Lauricocha, Guitarrero I, Paiján) se enfrentaron a un entorno pleistocénico agresivo. Su modelo de subsistencia principal consistía en:',
    options: [
      'La agricultura de terrazas (andenes) y el comercio interregional.',
      'La caza, pesca y recolección indiferenciada y nómada, organizada socialmente en bandas.',
      'La crianza masiva de camélidos en corrales de piedra y la textilería fina.',
      'El establecimiento de ciudades amuralladas para defenderse de tribus caníbales.',
      'La minería extractiva de cobre para exportación a la costa.',
    ],
    correctAnswer: 1,
    explanation:
        'En el Periodo Lítico Peruano (12,000 - 8,000 a.C.), el humano andino era exclusivamente nómada y predador. No producía alimentos, sino que extraía lo que la naturaleza proveía mediante la caza (megafauna/cérvidos) y recolección (bandas cazadoras-recolectoras).',
  ),
  Question(
    id: 'cs_q66',
    topicId: 'cs_t1',
    text:
        "La 'Cultura Clovis' (aprox. 13,000 años AP) fue considerada durante décadas como la cultura indígena más antigua de América. Su característica tecnológica definitoria, que da nombre a su tradición lítica, es:",
    options: [
      'El uso intensivo de arpones de hueso para la caza de ballenas.',
      'La construcción de dólmenes funerarios megalíticos.',
      'Una punta de lanza bifacial de sílex, con una acanaladura en su base para facilitar el enmangue, diseñada para cazar mamuts.',
      'El uso de cerbatanas con veneno extraído de ranas amazónicas.',
      'La alfarería decorada con motivos geométricos rojos sobre blanco.',
    ],
    correctAnswer: 2,
    explanation:
        "La 'Punta Clovis' es un hito tecnológico norteamericano. Su diseño acanalado permitía fijarla firmemente a un astil de madera, convirtiéndola en un arma letal para abatir la megafauna pleistocénica (mamuts, mastodontes).",
  ),
  Question(
    id: 'cs_q67',
    topicId: 'cs_t1',
    text:
        "El estudio de la dentición de fósiles del *Paranthropus* (como *P. boisei* o *P. robustus*, a veces llamados australopitecos robustos) revela una especialización evolutiva extrema divergente a la de nuestro género *Homo*. Su rasgo craneal más conspicuo, una 'cresta sagital' en la parte superior del cráneo, servía para:",
    options: [
      'Atraer a las hembras durante el cortejo, funcionando como dimorfismo sexual puramente visual.',
      'Romper caparazones de tortugas mediante cabezazos directos.',
      'Servir de anclaje para enormes músculos temporales de masticación, necesarios para triturar fibras vegetales duras y raíces.',
      'Disipar el calor corporal en la calurosa sabana africana.',
      'Proteger el encéfalo de los ataques de grandes felinos depredadores.',
    ],
    correctAnswer: 2,
    explanation:
        'El linaje Paranthropus se hiperespecializó en una dieta herbívora coriácea. La cresta sagital es el punto de inserción de músculos masticatorios masivos (como los gorilas modernos), lo que los condenó a la extinción ante cambios climáticos.',
  ),
  Question(
    id: 'cs_q68',
    topicId: 'cs_t1',
    text:
        "El yacimiento arqueológico de 'Çatalhöyük', ubicado en la actual Turquía (Anatolia), es considerado por muchos arqueólogos como uno de los proto-asentamientos urbanos más antiguos del mundo (aprox. 7100 a.C.). Una de sus peculiaridades arquitectónicas más fascinantes es que:",
    options: [
      'Las casas estaban construidas sobre pilotes en medio de un inmenso lago artificial.',
      'Carecía por completo de calles y puertas a nivel del suelo; las casas estaban adosadas y el acceso se realizaba por trampillas en los techos planos mediante escaleras.',
      'Estaba rodeada por una muralla de bronce inexpugnable de 10 metros de altura.',
      'Todas las casas tenían forma de pirámide invertida para recolectar agua de lluvia.',
      'Fue la primera ciudad en utilizar ladrillos de vidrio templado en la historia.',
    ],
    correctAnswer: 1,
    explanation:
        'En Çatalhöyük, la aglomeración de casas de adobe conformaba una estructura continua sin calles. La vida cívica y el tránsito se daban sobre los techos, y se entraba a las viviendas por el techo. Además, enterraban a sus muertos bajo el suelo de sus casas.',
  ),
  Question(
    id: 'cs_q69',
    topicId: 'cs_t1',
    text:
        'El uso controlado del fuego representó un hito trascendental en la hominización. Más allá del aporte calórico al cocinar los alimentos, el dominio igneo otorgó una ventaja evolutiva clave en la sociabilidad de los homínidos (especialmente el Homo erectus) porque:',
    options: [
      'Permitió la invención inmediata de la metalurgia del hierro.',
      'Alargó el periodo de vigilia, proporcionando un núcleo de calor, protección contra depredadores nocturnos y un espacio focal (el hogar) para la interacción social y el desarrollo incipiente del lenguaje.',
      'Se usó exclusivamente para esterilizar las puntas líticas antes de las operaciones quirúrgicas trepanatorias.',
      'Causó incendios forestales intencionales masivos que extinguieron rápidamente a los neandertales.',
      'Les permitió enviar señales de humo complejas a nivel intercontinental.',
    ],
    correctAnswer: 1,
    explanation:
        "El fuego modificó la ecología social humana. El 'hogar' (campamento alrededor del fuego) espantaba a las fieras y creaba un espacio seguro nocturno donde los lazos sociales y posiblemente la comunicación vocal se afianzaron fuertemente.",
  ),
  Question(
    id: 'cs_q70',
    topicId: 'cs_t1',
    text:
        'El poblamiento temprano de la costa central y norte del Perú (ej. Paiján, Huaca Prieta) muestra una adaptación marítima muy especializada. Los pobladores del Arcaico desarrollaron una tecnología específica que les permitía extraer recursos biológicos de las profundidades marinas o marismas, como:',
    options: [
      'Embarcaciones transoceánicas de madera de balsa de gran eslora.',
      'Redes confeccionadas con fibras de algodón silvestre y mates (calabazas) usados como flotadores.',
      'Trajes de buceo confeccionados rudimentariamente con vejigas de lobos marinos.',
      'La domesticación de defines para pastorear cardúmenes de anchoveta.',
      'La dinamita rudimentaria a base de guano de isla.',
    ],
    correctAnswer: 1,
    explanation:
        'En el Arcaico Peruano, sitios costeros evidencian un profundo dominio del mar. El cultivo temprano del algodón no fue para hacer ropa fina, sino primariamente para tejer redes de pesca (tecnología extractiva) que revolucionó su dieta proteica.',
  ),
  Question(
    id: 'cs_q71',
    topicId: 'cs_t1',
    text:
        "El concepto de 'Revolución Neolítica' (acuñado por Vere Gordon Childe) denota el paso de una economía depredadora a una productora. Este cambio no solo alteró la dieta, sino que tuvo como consecuencia demográfica inmediata:",
    options: [
      'Una drástica reducción de la población por nuevas pandemias asociadas a los rebaños.',
      'Un estancamiento demográfico producto de dietas pobres en nutrientes variados.',
      'La sedentarización permanente, la aparición del excedente productivo y una explosión demográfica sin precedentes.',
      'La obligatoriedad de controlar la natalidad mediante el infanticidio institucionalizado.',
      'La dispersión total de la humanidad en clanes aislados y solitarios de no más de 5 personas.',
    ],
    correctAnswer: 2,
    explanation:
        'La agricultura asegura una reserva predecible de calorías (cereales almacenables). Esto permite asentamientos fijos (sedentarismo), reduce el espaciamiento de nacimientos (las mujeres no tienen que cargar bebés largas distancias) y dispara el crecimiento poblacional.',
  ),
  Question(
    id: 'cs_q72',
    topicId: 'cs_t1',
    text:
        "Las pinturas de 'Tassili n'Ajjer' en el corazón del actual desierto del Sahara revelan un asombroso registro de la prehistoria del norte de África, demostrando que:",
    options: [
      'El desierto del Sahara nunca estuvo habitado por humanos prehistóricos.',
      'Existían civilizaciones extraterrestres conviviendo con los aborígenes africanos.',
      'El Sahara fue, durante la época húmeda holocénica, una sabana fértil habitada por pastores de ganado vacuno, antes de su acelerada desertificación actual.',
      'Los faraones egipcios obligaron a esclavos a tallar el desierto hace un millón de años.',
      'La megafauna americana cruzó a África nadando el Atlántico.',
    ],
    correctAnswer: 2,
    explanation:
        "El arte rupestre del Sahara (Periodo Bovidiense) muestra ríos, hipopótamos y pastores cuidando rebaños de vacas donde hoy hay dunas. Prueba un cambio climático radical (el fin del 'Sahara verde' hace unos 5,000 años).",
  ),
  Question(
    id: 'cs_q73',
    topicId: 'cs_t1',
    text:
        "Dentro del linaje evolutivo, existe un homínido temprano hallado en Chad (África Central), con una antigüedad cercana a los 7 millones de años, conocido como *Sahelanthropus tchadensis* (cráneo de 'Toumaï'). Su relevancia científica reside en que:",
    options: [
      'Es el ancestro directo exclusivo del gorila oriental.',
      'Podría ser el representante más antiguo del clado hominino, muy próximo temporalmente a la divergencia evolutiva entre la línea de los chimpancés y los humanos.',
      'Fue el primer homínido en dominar plenamente la metalurgia del bronce.',
      'Su esqueleto demuestra que nunca caminó erguido.',
      'Pertenece a una especie de simio sudamericano extinto.',
    ],
    correctAnswer: 1,
    explanation:
        'Toumaï (~7 millones AP) se sitúa justo en la época teórica (basada en el reloj molecular) en la que el linaje de los grandes simios africanos se separó del linaje humano. Su foramen magnum sugiere bipedismo incipiente.',
  ),
  Question(
    id: 'cs_q74',
    topicId: 'cs_t1',
    text:
        "La tesis sobre el 'poblamiento autóctono' de América (Hombre Pampeano) formulada por el erudito argentino Florentino Ameghino a fines del siglo XIX, sostenía que el ser humano originario de América surgió en la pampa argentina durante la era Terciaria. Esta teoría fue definitivamente descartada por la ciencia moderna porque:",
    options: [
      'El gobierno argentino prohibió las excavaciones en la pampa por motivos políticos.',
      'Se comprobó que los fósiles presentados pertenecían a homínidos europeos importados.',
      'Alex Hrdlicka demostró que los estratos geológicos eran más recientes (Cuaternario) y que los fósiles óseos correspondían a fauna extinta (megaterios) mezclada con humanos modernos (sapiens) y simios.',
      'Ameghino no publicó sus estudios en revistas científicas inglesas.',
      'La Iglesia Católica condenó la teoría por no ajustarse al relato del Génesis.',
    ],
    correctAnswer: 2,
    explanation:
        'Hrdlicka, antropólogo físico, refutó a Ameghino demostrando errores groseros en la datación estratigráfica y en la identificación osteológica. No existe evolución de homínidos (Australopithecus, H. erectus) en América; todos los fósiles humanos americanos son Homo sapiens.',
  ),
  Question(
    id: 'cs_q75',
    topicId: 'cs_t1',
    text:
        'El yacimiento peruano de Telarmachay, ubicado en la puna de Junín (más de 4,400 m.s.n.m.), excavado por la arqueóloga Danièle Lavallée, reviste una importancia mundial para el estudio del periodo Arcaico porque alberga la evidencia más temprana y contundente de:',
    options: [
      'La invención del tejido a telar de pedal con fibra de alpaca.',
      'La escritura ideográfica en piedras pulidas.',
      'La domesticación inicial y crianza en corrales de camélidos sudamericanos (alpacas y llamas), reflejada en la abundancia de huesos de fetos y neonatos.',
      'La utilización de la coca como moneda de cambio con la costa.',
      'La construcción de pirámides ceremoniales de bloques de basalto.',
    ],
    correctAnswer: 2,
    explanation:
        'Telarmachay es el hito del paso de la caza (vicuña/guanaco) al pastoreo (llama/alpaca). La enorme cantidad de huesos de fetos indica que los animales morían en cautiverio (problemas zoonóticos o sacrificios por frío), evidenciando corrales y domesticación.',
  ),
  Question(
    id: 'cs_q76',
    topicId: 'cs_t1',
    text:
        'Un subproducto sociológico fascinante de la transición hacia la vida urbana neolítica fue el surgimiento de la élite teocrática (sacerdocio). En focos civilizatorios tempranos (ej. Mesopotamia, Egipto, Andes Centrales), este grupo adquirió un inmenso poder político inicial fundamentado en:',
    options: [
      'Su fuerza bruta para someter esclavos mediante el uso del arco y la flecha.',
      'Su exclusividad en el comercio de piedras preciosas con tribus lejanas.',
      'Su rol como intermediarios con las deidades y su profundo conocimiento empírico de la astronomía y los ciclos meteorológicos para predecir inundaciones y organizar la siembra.',
      'Su monopolio sobre la técnica de momificación de animales sagrados.',
      'El derecho de nacimiento impuesto por linajes monárquicos previos al neolítico.',
    ],
    correctAnswer: 2,
    explanation:
        'En las sociedades de base agrícola, conocer el calendario (cuándo sembrar, cuándo lloverá) es cuestión de supervivencia. Quienes observaban los astros (astronomía empírica) vincularon ese saber a mandatos divinos, concentrando el poder civil y religioso (Estado prístino).',
  ),
  Question(
    id: 'cs_q77',
    topicId: 'cs_t1',
    text:
        "Entre las herramientas de piedra, los 'Bifaces' o hachas de mano (como la característica 'amígdala') son el fósil guía de la industria Achelense, la tradición lítica de mayor duración en la prehistoria. ¿A qué especie del género Homo se le atribuye la invención y expansión masiva de esta simétrica y polivalente herramienta?",
    options: [
      'Homo habilis.',
      'Australopithecus afarensis.',
      'Homo ergaster / Homo erectus.',
      'Homo floresiensis.',
      'Homo sapiens sapiens.',
    ],
    correctAnswer: 2,
    explanation:
        'El Achelense (Modo 2) representa un gran salto cognitivo por la simetría y preconcepción de la herramienta. Es la tecnología emblemática del H. ergaster (África) y H. erectus, acompañándolo durante más de 1.5 millones de años.',
  ),
  Question(
    id: 'cs_q78',
    topicId: 'cs_t1',
    text:
        "En la Prehistoria peruana, el complejo arqueológico de 'Sechín Bajo' (Valle de Casma) es fundamental porque desafía la cronología de las estructuras públicas monumentales. Según sus excavadores, en sus fases iniciales muestra plazas circulares hundidas que evidencian:",
    options: [
      'Influencia directa y tardía de la cultura Tiahuanaco en la costa norte.',
      'Arquitectura pública y ceremonial monumental (Aprox. 3500 a.C.) que rivaliza en antigüedad con Caral, evidenciando un desarrollo arquitectónico complejo desde el Arcaico Superior.',
      'Restos de metalurgia del hierro importado de Asia Menor.',
      'Un fuerte uso como coliseo para batallas de gladiadores esclavizados.',
      'Que fue un puerto incaico sumergido por el Fenómeno del Niño.',
    ],
    correctAnswer: 1,
    explanation:
        'Sechín Bajo contiene estructuras fechadas en más de 3,500 a.C. (Plaza Circular Hundida más antigua del Perú), demostrando que la civilización, el urbanismo ceremonial y el esfuerzo colectivo organizado tienen raíces antiquísimas en la costa peruana.',
  ),
  Question(
    id: 'cs_q79',
    topicId: 'cs_t1',
    text:
        'En las frías estepas de Europa y Asia central, las evidencias arqueológicas apuntan a que los Neandertales poseían una cultura compleja que iba más allá de la mera supervivencia biológica. Un hito que demuestra el desarrollo del pensamiento abstracto y compasión en esta especie es:',
    options: [
      'La invención del torno de alfarero para producción en masa de cerámica utilitaria.',
      'El descubrimiento de enterramientos intencionales acompañados de ofrendas florales (ej. Cueva de Shanidar) y el cuidado de individuos ancianos y lisiados.',
      'La redacción de un sistema legal tallado en estelas de mármol.',
      'El uso cotidiano del cobre y bronce para armaduras ceremoniales.',
      'La domesticación exitosa del mamut lanudo para transporte de carga.',
    ],
    correctAnswer: 1,
    explanation:
        'Shanidar (Irak) reveló restos de un neandertal (Shanidar 1) viejo, ciego de un ojo y con un brazo amputado que sobrevivió años, indicando cuidado comunitario (altruismo). Además, análisis de polen sugieren enterramientos con flores, denotando comportamiento funerario simbólico.',
  ),
  Question(
    id: 'cs_q80',
    topicId: 'cs_t1',
    text:
        'El estudio de la genética de poblaciones nativas americanas ha establecido fuertemente su ascendencia norasiática (Siberia). ¿Qué rasgo fenotípico y odontológico (rasgo somático), común en poblaciones indígenas andinas y amazónicas, sirvió clásicamente como prueba física de este linaje mongoloide asiático?',
    options: [
      'Piel extremadamente pálida con ausencia de melanina y ojos azules.',
      'Incisivos en forma de pala, escaso vello corporal (lampiños) y la mancha mongólica en recién nacidos.',
      'Cabello ensortijado o crespo y contextura grácil alta.',
      'Ausencia genética de las muelas del juicio en toda la población.',
      'Cráneos dolicocéfalos puros con huesos parietales prominentes.',
    ],
    correctAnswer: 1,
    explanation:
        'La antropología biológica (como la descrita por Alex Hrdlicka) utiliza fenotipos compartidos entre asiáticos orientales e indígenas americanos: mancha mongólica lumbosacra en bebés, pelo lacio (lecotrico), pliegue epicántico en los ojos e incisivos espatulados.',
  ),
  Question(
    id: 'cs_q81',
    topicId: 'cs_t1',
    text:
        "La tesis 'Oceánica' de Paul Rivet sobre el poblamiento de América postula un origen múltiple. Rivet sostiene que, además de la vía de Beringia, hubieron flujos migratorios marítimos desde el Pacífico. Para defender la migración 'Melanésica', Rivet se basó fuertemente en:",
    options: [
      'Similitudes en herramientas de bronce y hierro forjado en yunque.',
      'Semejanzas lingüísticas indoeuropeas con las lenguas de Mesoamérica.',
      'Semejanzas antropológicas (tipo racial de Lagoa Santa, Brasil), culturales (uso de cerbatana, horno bajo tierra, hamaca) y enfermedades comunes.',
      'La existencia de pirámides escalonadas idénticas en Melanesia y México.',
      'Documentos escritos hallados en urnas funerarias polinésicas.',
    ],
    correctAnswer: 2,
    explanation:
        'Rivet argumentó fuertes analogías culturales (pachamanca/horno subterráneo, cerbatana, porras estrelladas) y similitudes óseas craneales entre los antiguos habitantes de Lagoa Santa (Brasil) y las poblaciones negroides de Melanesia (Oceanía).',
  ),
  Question(
    id: 'cs_q82',
    topicId: 'cs_t1',
    text:
        'La domesticación del perro (Canis lupus familiaris) es un caso único en la prehistoria, ya que ocurrió mucho antes de la Revolución Neolítica agrícola. ¿En qué contexto socioeconómico se produjo esta alianza evolutiva humano-lobo?',
    options: [
      'Durante la era industrial, para vigilar minas de carbón.',
      'En el seno de las sociedades cazadoras-recolectoras del Paleolítico Superior, donde el lobo menos agresivo colaboraba en la caza, el rastreo y la vigilancia de campamentos.',
      'Solamente tras la invención de la ganadería vacuna, para usar al perro como pastor.',
      'En el Neolítico mesoamericano, exclusivamente como fuente principal de proteína cárnica.',
      'En tiempos del Imperio Romano para utilizarlos como gladiadores.',
    ],
    correctAnswer: 1,
    explanation:
        'El perro es el primer animal domesticado de la historia (hace 15,000 - 30,000 años), domesticado por cazadores nómadas del Paleolítico en Eurasia. Se asociaron mutuamente para cooperar en la caza y defensa, mucho antes de inventarse la agricultura.',
  ),
  Question(
    id: 'cs_q83',
    topicId: 'cs_t1',
    text:
        "En la región de Atapuerca (España), el sitio conocido como 'Sima de los Huesos' es el mayor depósito de fósiles humanos del Pleistoceno Medio a nivel mundial. La gran mayoría de estos restos pertenecen a la especie:",
    options: [
      'Homo neanderthalensis (fase clásica).',
      'Homo heidelbergensis (prenéandertales).',
      'Australopithecus sediba.',
      'Homo habilis europeos.',
      'Homo sapiens arcaicos cro-magnon.',
    ],
    correctAnswer: 1,
    explanation:
        'La Sima de los Huesos alberga restos de unos 30 individuos de H. heidelbergensis (~430,000 años), que ya muestran incipientes rasgos neandertales, sugiriendo posiblemente un acto intencional de arrojar los cadáveres (comportamiento funerario temprano).',
  ),
  Question(
    id: 'cs_q84',
    topicId: 'cs_t1',
    text:
        'La Teoría Australiana de Mendes Correia propuso una vía migratoria audaz hacia América: navegando hacia el sur desde Australia, atravesando islas hasta alcanzar la Antártida, y luego bordeando su costa para ingresar por Tierra del Fuego. Para justificar que homínidos primitivos sobrevivieran cruzando el polo sur, Mendes argumentó:',
    options: [
      'La invención del uso intensivo de grasa de ballena como aislante térmico en trajes y embarcaciones.',
      "La ocurrencia de un 'Óptimo Climático', un periodo de calentamiento global temporal que desheló las costas antárticas haciéndolas transitables hace unos 6,000 años.",
      'Que los australianos mutaron genéticamente desarrollando pelo espeso similar al oso polar.',
      'Que excavaron túneles subterráneos debajo del hielo antártico impulsados por la geotermia.',
      'La asistencia de corrientes oceánicas termales que derretían el hielo a su paso.',
    ],
    correctAnswer: 1,
    explanation:
        "Mendes Correia planteó que las condiciones climáticas no fueron siempre glaciales. El 'Óptimo Climático' (clima más cálido de lo normal) habría permitido a los aborígenes australianos bordear las costas de una Antártida libre de hielo marino en sus orillas.",
  ),
  Question(
    id: 'cs_q85',
    topicId: 'cs_t1',
    text:
        "El estudio de la hominización se beneficia enormemente del registro fósil del Gran Valle del Rift, en África Oriental (Kenia, Tanzania, Etiopía). La razón geológica por la cual esta región concentra tantos hallazgos fósiles, como la famosa 'Lucy' (A. afarensis), es:",
    options: [
      'Era el único lugar de África con lagos de agua dulce, lo que obligaba a los homínidos a morir allí.',
      'La constante caída de meteoritos en la zona petrificó instantáneamente a los seres vivos.',
      'Es una falla tectónica activa donde la erosión rápida expone estratos sedimentarios antiguos muy ricos en fósiles, sumado a capas de ceniza volcánica que permiten dataciones radiométricas muy precisas (K-Ar).',
      'El gobierno africano trasladó todos los fósiles continentales allí para su protección en el siglo XIX.',
      'El alto contenido de sal de las minas locales momificó a todos los habitantes.',
    ],
    correctAnswer: 2,
    explanation:
        "El Valle del Rift es el 'laboratorio de la evolución' porque la separación tectónica deforma la tierra, exponiendo estratos antiquísimos. Además, los volcanes (como el Sadiman) cubrieron de cenizas los huesos, permitiendo usar el método del Potasio-Argón para fecharlos con asombrosa precisión.",
  ),
  Question(
    id: 'cs_q86',
    topicId: 'cs_t1',
    text:
        'La subsistencia en el Paleolítico Medio (neandertales) implicaba un alto riesgo y cercanía con la presa. Sin embargo, en el Paleolítico Superior, el *Homo sapiens* logró abatir presas a una distancia segura y con gran potencia de penetración gracias al desarrollo de una innovación balística decisiva conocida como:',
    options: [
      'La catapulta de asedio.',
      'El búmeran de hueso.',
      'El propulsor (atlatl) o lanzadardos.',
      'La cerbatana envenenada.',
      'La ballesta de repetición con engranajes de madera.',
    ],
    correctAnswer: 2,
    explanation:
        'El propulsor o lanzadardos es un brazo de palanca que multiplica la velocidad, alcance y fuerza de impacto de una jabalina. Fue la principal arma a distancia (antes de popularizarse el arco) y aseguró la supervivencia en las estepas heladas.',
  ),
  Question(
    id: 'cs_q87',
    topicId: 'cs_t1',
    text:
        'El paso del nomadismo al sedentarismo (Arcaico Peruano) no fue un acto repentino, sino un proceso mediado por la horticultura y la estabilización de los ecosistemas. Un factor geográfico-ecológico decisivo en la costa peruana que favoreció el sedentarismo temprano, incluso antes que la agricultura intensiva, fue:',
    options: [
      'La masiva presencia de árboles maderables gigantes para construir fuertes contra la neblina.',
      'La domesticación de la papa en los desiertos cálidos.',
      'La enorme biomasa del mar de Humboldt (riqueza ictiológica marina y marisqueo) que proveía proteínas todo el año de forma predecible sin necesidad de migrar.',
      'Las inundaciones monzónicas semestrales que traían limo fértil a los valles costeros.',
      'La existencia de valles profundos repletos de oro aluvial fácil de intercambiar.',
    ],
    correctAnswer: 2,
    explanation:
        'En la costa peruana, comunidades como Paloma o Chilca lograron sedentarizarse (vivir en aldeas fijas) antes de ser grandes agricultores, gracias a que el mar frío del Perú les ofrecía alimento (peces, moluscos) abundante todo el año, un fenómeno muy inusual a nivel mundial.',
  ),
  Question(
    id: 'cs_q88',
    topicId: 'cs_t1',
    text:
        "En el debate arqueológico contemporáneo sobre el poblamiento originario, el sitio de 'Pedra Furada' (Brasil), estudiado intensamente por la arqueóloga Niède Guidon, ha generado enorme controversia mundial porque:",
    options: [
      'Descubrieron herramientas de bronce que refutan la Edad de Piedra americana.',
      'Sus hallazgos postulan dataciones de ocupación humana asombrosamente antiguas (más de 30,000 a 40,000 años AP), lo cual destrozaría el consenso conservador Clovis.',
      'Demostró que la selva amazónica fue un desierto estéril hasta el siglo XV.',
      'Los cráneos encontrados presentan deformaciones artificiales extraterrestres.',
      'Contiene las primeras pruebas de escritura cuneiforme en Sudamérica.',
    ],
    correctAnswer: 1,
    explanation:
        'Guidon ha defendido mediante dataciones de C-14 en restos de carbón (supuestos hogares) que el humano habitó Piauí (Brasil) hace 40 mil años. Los críticos conservadores alegan que el carbón proviene de incendios forestales naturales, no humanos.',
  ),
  Question(
    id: 'cs_q89',
    topicId: 'cs_t1',
    text:
        "La dieta cárnica jugó un rol crucial en la expansión cerebral (encefalización) del género *Homo*, ya que el tejido cerebral es metabólicamente muy costoso. ¿Qué innovación biológica del cuerpo humano, secundaria a esta nueva dieta altamente digerible, permitió 'redestinar' energía metabólica hacia el cerebro (Hipótesis del Tejido Costoso)?",
    options: [
      'La reducción drástica de la masa muscular de los miembros inferiores.',
      'El aumento del tamaño del hígado para procesar toxinas de la carne descompuesta.',
      'La elongación y engrosamiento masivo del colon para fermentar celulosa.',
      'La marcada reducción del tamaño del tracto gastrointestinal (intestino), que gasta mucha energía en los herbívoros.',
      'La pérdida total del vello corporal para evitar parásitos en la carne.',
    ],
    correctAnswer: 3,
    explanation:
        'La Hipótesis del Tejido Costoso (Aiello y Wheeler) postula que no puedes tener simultáneamente dos órganos que gasten muchísima energía. Al comer carne y cocinar, la digestión se facilita; el intestino humano se acortó, liberando energía metabólica que se destinó a mantener un cerebro enorme.',
  ),
  Question(
    id: 'cs_q90',
    topicId: 'cs_t1',
    text:
        "Las 'Venus paleolíticas' son pequeñas estatuillas femeninas de piedra, hueso o marfil, caracterizadas por una exageración hipertrófica de sus rasgos anatómicos vinculados a la reproducción (senos, vientre, caderas prominentes). El consenso arqueológico interpreta estas estatuillas de la Edad de Hielo (ej. Venus de Willendorf) primariamente como:",
    options: [
      'Retratos fidedignos de reinas matriarcales obesas.',
      'Símbolos propiciatorios de la fecundidad (humana y de la naturaleza) en un periodo de baja demografía y duras condiciones glaciares.',
      'Juguetes didácticos para la educación sexual de los pre-adolescentes.',
      'Representaciones burlescas de diosas castigadoras.',
      'Moldes de costura para confeccionar pieles a medida.',
    ],
    correctAnswer: 1,
    explanation:
        'La exageración de los rasgos reproductivos (esteatopigia) sugiere que eran ídolos mágicos o amuletos de fertilidad. En una Edad de Hielo, la supervivencia de la banda dependía de la capacidad reproductiva y del éxito de los nacimientos.',
  ),
  Question(
    id: 'cs_q91',
    topicId: 'cs_t1',
    text:
        'Durante el Arcaico Inferior andino (hace unos 6000 a.C.), se produce un fenómeno sociodemográfico crucial: la domesticación de animales como el cuy y las primeras evidencias de horticultura incipiente. Uno de los sitios arqueológicos peruanos más representativos de esta fase, con entierros humanos y viviendas circulares incipientes, es:',
    options: [
      'Machu Picchu.',
      'Chavín de Huántar.',
      'Chan Chan.',
      'Chilca.',
      'Cahuachi.',
    ],
    correctAnswer: 3,
    explanation:
        'La aldea de Chilca (valle al sur de Lima) es clave para entender el Arcaico Inferior y Medio. Muestra las primeras chozas circulares semisubterráneas, sedentarismo temprano por pesca, y restos del primer perro peruano, además de entierros bajo las casas.',
  ),
  Question(
    id: 'cs_q92',
    topicId: 'cs_t1',
    text:
        'La Revolución Neolítica no solo domesticó alimentos, sino que inventó un material sintético revolucionario moldeable con agua y fuego, que permitía almacenar granos a prueba de roedores, transportar líquidos y hervir la comida. Esta invención tecnológica fundamental es:',
    options: [
      'La forja del bronce.',
      'La cerámica (alfarería cocida).',
      'El vidrio soplado translúcido.',
      'El tejido de malla metálica.',
      'La producción de polímeros de caucho silvestre.',
    ],
    correctAnswer: 1,
    explanation:
        'La invención de la cerámica (barro cocido al fuego) alteró drásticamente la nutrición y el almacenamiento. Se convirtió en la primera alteración química de materiales a gran escala hecha por el hombre, fundamental para hervir cereales y conservar provisiones secas.',
  ),
  Question(
    id: 'cs_q93',
    topicId: 'cs_t1',
    text:
        'La migración humana fuera de África tuvo múltiples oleadas. El primer homínido documentado en salir exitosamente de África, expandiéndose por Asia tropical y llegando hasta las islas de Indonesia (ej. Hombre de Java), en una epopeya de colonización adaptativa de cientos de miles de años, fue el:',
    options: [
      'Australopithecus sediba.',
      'Homo neanderthalensis.',
      'Homo erectus.',
      'Homo sapiens arcaico.',
      'Paranthropus robustus.',
    ],
    correctAnswer: 2,
    explanation:
        'El Homo erectus (o su variante temprana ergaster) fue el primer explorador global. Salió de África hace aprox. 1.8 millones de años, poseía fuego, tecnología Achelense y piernas largas aptas para largas marchas (ej. fósiles de Dmanisi, Sangiran, Zhoukoudian).',
  ),
  Question(
    id: 'cs_q94',
    topicId: 'cs_t1',
    text:
        "Según el registro prehistórico andino, el 'Hombre de Toquepala' (Tacna) es famoso por sus notables pinturas rupestres en las cuevas del Diablo. ¿Cuál es el tema central representado que refleja la táctica de caza andina del Periodo Lítico?",
    options: [
      'El sacrificio humano a los dioses de las montañas.',
      'Batallas entre diferentes tribus usando hondas.',
      "El 'Chaco', técnica comunitaria donde un grupo de cazadores acorrala a manadas de guanacos o vicuñas.",
      'Pescadores en caballitos de totora cazando ballenas.',
      'La adoración del jaguar (Chavín) mediante el consumo de San Pedro.',
    ],
    correctAnswer: 2,
    explanation:
        "Toquepala, fechada en el Arcaico temprano/Lítico, exhibe escenas vibrantes de cazadores arriando camélidos silvestres. El 'Chaco' (acorralamiento) requiere coordinación social y es una tradición que persiste hasta hoy en los andes para esquilar vicuñas.",
  ),
  Question(
    id: 'cs_q95',
    topicId: 'cs_t1',
    text:
        'El estudio de la genética moderna (ADN antiguo) y del genoma humano ha descubierto un segundo grupo de homínidos arcaicos emparentados con los neandertales, que habitaron Asia y dejaron un legado genético importante en las actuales poblaciones tibetanas y melanesias. Se les conoce como:',
    options: [
      'Los Cromañones del Este.',
      'Los Denisovanos (Hombre de Denisova).',
      'Los Hobbits de Flores.',
      'Los Homininos de Dmanisi.',
      'Los Sinántropos asiáticos.',
    ],
    correctAnswer: 1,
    explanation:
        'Descubiertos en la cueva de Denisova (Rusia) a partir de un pequeño hueso de dedo, los Denisovanos son un grupo hermano de los neandertales. Se cruzaron con los sapiens, dotando a los tibetanos modernos de adaptación biológica a las grandes altitudes.',
  ),
  Question(
    id: 'cs_q96',
    topicId: 'cs_t1',
    text:
        'Dentro del esquema de evolución cultural post-neolítico en el Viejo Mundo, las sociedades alcanzaron la Edad de los Metales. El inicio de la metalurgia real, no solo martillando el mineral nativo frío, sino sometiéndolo a fundición en hornos, comenzó con la llamada:',
    options: [
      'Edad del Hierro meteórico.',
      'Edad del Cobre (Calcolítico o Eneolítico).',
      'Edad del Acero templado.',
      'Edad del Titanio forjado.',
      'Edad de las Aleaciones de Platino.',
    ],
    correctAnswer: 1,
    explanation:
        'El Calcolítico es la fase de transición. El ser humano descubre que aplicando altas temperaturas al mineral de cobre, este se licúa y puede verterse en moldes, abriendo la puerta a la metalurgia formal que luego culminaría en el Bronce.',
  ),
  Question(
    id: 'cs_q97',
    topicId: 'cs_t1',
    text:
        "El cambio anatómico en las cuerdas vocales, el descenso de la laringe en el cuello y la flexión de la base del cráneo permitieron al ser humano moderno un rasgo único inigualable por otros primates: la articulación de un lenguaje hablado complejo. ¿Cuál es el 'costo' anatómico o peligro biológico que asumió nuestra especie a cambio de esta ventaja?",
    options: [
      'La pérdida total de la capacidad de morder alimentos duros.',
      'La atrofia de las cuerdas vocales al alcanzar la pubertad.',
      'El incremento masivo del riesgo de atragantamiento (asfixia) al cruzar la vía respiratoria y la digestiva.',
      'La vulnerabilidad del cráneo a fracturas por impacto del aire frío.',
      'La pérdida del olfato, atrofiando el lóbulo frontal permanentemente.',
    ],
    correctAnswer: 2,
    explanation:
        'Para tener el rango vocal necesario para el lenguaje, la laringe humana bajó en la garganta. Esto significa que la comida y el aire comparten un camino común más largo; si la epiglotis falla, nos ahogamos. Es un gran costo biológico tolerado solo por el inmenso beneficio de hablar.',
  ),
  Question(
    id: 'cs_q98',
    topicId: 'cs_t1',
    text:
        'La sedentarización forjó la idea moderna de territorialidad. En el Cercano Oriente prehistórico (ej. Jericó), el ser humano construyó por primera vez impresionantes murallas de piedra maciza y torres de vigilancia. Esto denota un contexto sociopolítico de:',
    options: [
      'Paz perpetua impulsada por el trueque de cereales.',
      'Defensa frente a otras comunidades por la acumulación de riqueza (excedente agrícola y ganado) o el control de recursos clave (manantiales).',
      'La necesidad de protegerse exclusivamente de los osos de las cavernas remanentes.',
      'Aislamiento religioso, prohibiendo la visión del exterior a sus habitantes.',
      'Preparación ante cataclismos sísmicos periódicos predecibles.',
    ],
    correctAnswer: 1,
    explanation:
        'Las riquezas del Neolítico (granos almacenados, tierras fértiles, agua dulce como el manantial de Jericó) atraen el pillaje. Las murallas evidencian el surgimiento de la guerra organizada (conflicto intergrupal) por la defensa o apropiación de excedentes productivos.',
  ),
  Question(
    id: 'cs_q99',
    topicId: 'cs_t1',
    text:
        "La arqueología peruana, en el estudio del formativo y arcaico andino, identifica a Kotosh (Huánuco) como un sitio cumbre por su 'Templo de las Manos Cruzadas'. El significado sociológico de este hallazgo arquitectónico del Arcaico Superior estriba en que evidencia:",
    options: [
      'El uso masivo de esclavos afrodescendientes para tallar la piedra.',
      'Prácticas mágico-religiosas sofisticadas y dualismo andino, sustentado por una sociedad sedentaria precerámica capaz de movilizar mano de obra para fines puramente ceremoniales.',
      'Un templo de adoración exclusiva a dioses marinos traídos desde la costa.',
      'La existencia del primer mercado monetario con monedas en forma de manos.',
      'Un fuerte uso de armas de bronce para decapitar a los enemigos capturados.',
    ],
    correctAnswer: 1,
    explanation:
        'El Templo de las Manos Cruzadas de Kotosh (Fase Mito) alberga fogones ceremoniales ventilados subterráneamente y nichos con escultura en barro crudo. Demuestra una religión organizada, jerarquía y conceptos de dualidad andina consolidados siglos antes de la existencia de la cerámica y de Chavín.',
  ),
  Question(
    id: 'cs_q100',
    topicId: 'cs_t1',
    text:
        'El estudio de la evolución biocultural humana demuestra que el factor decisivo que garantizó el éxito del *Homo sapiens sapiens* en poblar todos los ecosistemas del planeta, desde los desiertos gélidos del Ártico hasta la selva amazónica, no fue su fortaleza física, sino:',
    options: [
      'Su inmunidad innata a todas las bacterias prehistóricas.',
      'La hibridación con osos pardos para desarrollar pelaje grueso de invierno.',
      'Su inmensa plasticidad biológica unida a la capacidad de transmitir información compleja intergeneracionalmente mediante el lenguaje y la cultura material (tecnología, ropas, abrigos).',
      'Su dieta estrictamente vegana, que impedía enfermedades metabólicas y de coagulación.',
      'El uso persistente de la fuerza bruta y el exterminio total de la megafauna en un par de semanas tras su arribo.',
    ],
    correctAnswer: 2,
    explanation:
        "El hombre anatómicamente moderno no tuvo que esperar mutaciones biológicas lentas (como criar pelaje grueso) para sobrevivir en el frío; usó su inteligencia para despellejar un animal, coser la piel (aguja de hueso) e inventar la ropa, es decir, usó la 'Evolución Cultural' adaptativa extracorpórea.",
  ),
  Question(
    id: 'cs_q101',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 1)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q102',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 2)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q103',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 3)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q104',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 4)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q105',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 5)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q106',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 6)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q107',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 7)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q108',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 8)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q109',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 9)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q110',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 10)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q111',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 11)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q112',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 12)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q113',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 13)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q114',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 14)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q115',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 15)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q116',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 16)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q117',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 17)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q118',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 18)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q119',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 19)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q120',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 20)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q121',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 21)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q122',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 22)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q123',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 23)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q124',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 24)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q125',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 25)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q126',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 26)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q127',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 27)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q128',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 28)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q129',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 29)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q130',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 30)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q131',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 31)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q132',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 32)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q133',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 33)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q134',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 34)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q135',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 35)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q136',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 36)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q137',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 37)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q138',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 38)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q139',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 39)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q140',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 40)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q141',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 41)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q142',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 42)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q143',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 43)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q144',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 44)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q145',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 45)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q146',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 46)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q147',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 47)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q148',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 48)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q149',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 49)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q150',
    topicId: 'cs_t1',
    text: 'FIJA HISTORIA: Proceso evolutivo del hombre: (Var 50)',
    options: ['Hominización', 'Revolución', 'Sedentarismo', 'Colonización'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q151',
    topicId: 'cs_t2',
    text:
        'La macroeconomía del Imperio Incaico operaba sin moneda, mercados ni tributos en especie obligatorios. En su lugar, el Estado basó su poder logístico en un sofisticado sistema de tributación consistente única y exclusivamente en:',
    options: [
      'El pago de impuestos mediante la entrega de metales preciosos fundidos.',
      'La prestación de fuerza de trabajo humano obligatorio, rotativo y por turnos (Mita).',
      'La confiscación total de las tierras agrícolas de las etnias sometidas.',
      'La entrega anual de prisioneros de guerra para el sacrificio en la capital.',
      'El intercambio de productos manufacturados por oro con culturas vecinas.',
    ],
    correctAnswer: 1,
    explanation:
        'El Estado inca no exigía tributo en bienes, sino en trabajo (la Mita). A través de este trabajo rotativo se construían obras públicas, se cultivaban las tierras estatales y se llenaban las Colcas.',
  ),
  Question(
    id: 'cs_q152',
    topicId: 'cs_t2',
    text:
        'El andamiaje socioeconómico andino se sustentaba en dos principios ineludibles. Uno de ellos implicaba que el Estado, tras acopiar gigantescos excedentes productivos mediante la Mita, proveía sustento a la población en épocas de sequía, viudez o guerra. Este principio político-económico, base de la legitimidad imperial, se denomina:',
    options: [
      'Reciprocidad simétrica.',
      'Asistencialismo feudal.',
      'Redistribución.',
      'Economía autárquica local.',
      'Proteccionismo mercantil.',
    ],
    correctAnswer: 2,
    explanation:
        'La redistribución es el principio por el cual el centro de poder (el Inca) devuelve a la población (en forma de alimentos, lana o chicha) una parte de los excedentes generados por su propio trabajo.',
  ),
  Question(
    id: 'cs_q153',
    topicId: 'cs_t2',
    text:
        'La estructura política del Imperio Incaico delegaba gran poder a líderes étnicos locales que habían sido asimilados pacífica o militarmente. Esta autoridad, nexo indispensable entre el ayllu y el aparato estatal central, organizaba el trabajo comunal y administraba justicia menor. Era el:',
    options: [
      'Tucuy Ricuy.',
      'Curaca.',
      'Apocuna.',
      'Quipucamayoc.',
      'Willac Umu.',
    ],
    correctAnswer: 1,
    explanation:
        'El Curaca (o cacique, término traído por los españoles) era la autoridad máxima del Ayllu. Sin el curaca, el Inca no podía movilizar la fuerza de trabajo de las etnias anexadas.',
  ),
  Question(
    id: 'cs_q154',
    topicId: 'cs_t2',
    text:
        'En el contexto de la administración imperial, el Cusco enviaba periódicamente a un inspector de máxima confianza. Este funcionario viajaba de incógnito por los suyus, observando el cumplimiento de las leyes, el estado de los caminos y fiscalizando el desempeño de los curacas, teniendo además potestad para celebrar matrimonios (huarmicoco) y ejercer de juez (taripa camayoc). Su título era:',
    options: [
      'El Tahuantinsuyo Camachic.',
      'El Auqui.',
      'El Sinchi.',
      'El Tucuy Ricuy.',
      'El Michic.',
    ],
    correctAnswer: 3,
    explanation:
        "El Tucuy Ricuy ('el que todo lo ve y todo lo oye') era el fiscalizador del imperio, los ojos del Inca. Actuaba como juez itinerante y casamentero oficial.",
  ),
  Question(
    id: 'cs_q155',
    topicId: 'cs_t2',
    text:
        'El Imperio se dividió geopolíticamente en cuatro grandes suyus que convergían en la plaza de Huacaypata (Cusco). El suyu demográficamente más poblado, que abarcaba la extensa y rica costa peruana hasta el actual Ecuador, vital por su producción agrícola, marítima y red vial, era el:',
    options: [
      'Collasuyu.',
      'Antisuyu.',
      'Contisuyu.',
      'Chinchaysuyu.',
      'Omagua.',
    ],
    correctAnswer: 3,
    explanation:
        'El Chinchaysuyu (hacia el noroeste) abarcaba la costa y sierra central y norte, siendo la región más próspera, poblada y de mayor importancia estratégica tras la anexión del señorío Chimú y Chincha.',
  ),
  Question(
    id: 'cs_q156',
    topicId: 'cs_t2',
    text:
        "John Murra, antropólogo fundamental para la historiografía peruana, acuñó el término 'Control Vertical de Pisos Ecológicos'. Este sistema de subsistencia, originado antes de los incas pero masificado por ellos, permitía a un ayllu:",
    options: [
      'Monopolizar el comercio marítimo mediante la creación de puertos interconectados.',
      'Acceder a recursos de diversas altitudes estableciendo colonias multiétnicas (archipiélagos) sin depender del libre comercio.',
      'Construir andenes exclusivamente en las laderas más empinadas de los Andes.',
      'Mover toda su población estacionalmente persiguiendo manadas de camélidos.',
      'Cobrar peaje por el tránsito en los diferentes tramos altitudinales del Qhapaq Ñan.',
    ],
    correctAnswer: 1,
    explanation:
        'El control vertical permitía que un núcleo poblacional (ej. en la puna) enviara colonos a la costa (para extraer sal/pescado) o a la selva alta (coca/madera), obteniendo recursos variados sin recurrir a mercados externos.',
  ),
  Question(
    id: 'cs_q157',
    topicId: 'cs_t2',
    text:
        'La sociedad incaica poseía una compleja estratificación de clases. Existe un grupo particular compuesto por individuos desvinculados de su ayllu de origen, perdiendo sus derechos de reciprocidad comunal, para servir de manera perpetua y hereditaria a las panacas nobles, al sacerdocio o al Inca. ¿Cómo se denominaba a este estrato social?',
    options: ['Mitmaqkuna.', 'Yanaconas.', 'Piñas.', 'Hatun runas.', 'Acllas.'],
    correctAnswer: 1,
    explanation:
        'Los Yanaconas eran los sirvientes perpetuos o servidores del Estado/Nobleza. Al perder sus lazos con el ayllu, ya no tenían derecho a recibir tierras comunales ni ayuda en reciprocidad.',
  ),
  Question(
    id: 'cs_q158',
    topicId: 'cs_t2',
    text:
        'Como parte de su estrategia geopolítica y de pacificación, el Estado cusqueño implementó una masiva política de traslados poblacionales. Grupos enteros de familias eran movilizados a fronteras recientes para culturizar a los conquistados, o los rebeldes eran trasladados a zonas seguras. A estas poblaciones desarraigadas por el Estado se les llamaba:',
    options: [
      'Curacas.',
      'Chasquis.',
      'Yanaconas.',
      'Mitmaqkuna (Mitimaes).',
      'Sinchis.',
    ],
    correctAnswer: 3,
    explanation:
        'Los Mitmaqkuna eran los colonos estatales. Servían para consolidar la expansión demográfica, económica y militar, evitando rebeliones al romper la unidad territorial de pueblos belicosos.',
  ),
  Question(
    id: 'cs_q159',
    topicId: 'cs_t2',
    text:
        "Dentro del ayllu, el trabajo agrícola y de construcción de viviendas se fundamentaba en un principio moral de ayuda mutua, donde las familias se prestaban fuerza laboral bajo la promesa de retribuirla en igualdad de condiciones ('hoy por ti, mañana por mí'). Esta manifestación de la reciprocidad simétrica es conocida como:",
    options: ['Mita.', 'Minca.', 'Ayni.', 'Chunca.', 'Minka estatal.'],
    correctAnswer: 2,
    explanation:
        'El Ayni es el intercambio recíproco de trabajo entre unidades familiares dentro de un mismo ayllu, esencial para sobrevivir en la agreste geografía andina.',
  ),
  Question(
    id: 'cs_q160',
    topicId: 'cs_t2',
    text:
        "La 'Minca' o 'Minka', a diferencia del Ayni (que era interfamiliar), era un sistema de trabajo colectivo que beneficiaba directamente a:",
    options: [
      'Exclusivamente a la nobleza de sangre residente en el Cusco.',
      'Toda la comunidad (ayllu) o a los dioses locales (huacas).',
      'Las provincias lejanas que sufrían desastres naturales.',
      'El ejército imperial durante sus campañas de conquista.',
      'Los prisioneros de guerra condenados a la selva.',
    ],
    correctAnswer: 1,
    explanation:
        'La Minca era el trabajo comunal obligatorio para obras de beneficio local, como construir un puente para el ayllu o trabajar las tierras de la huaca local, acompañado generalmente de festividades.',
  ),
  Question(
    id: 'cs_q161',
    topicId: 'cs_t2',
    text:
        'Para asegurar el éxito de la redistribución, la inmensa cantidad de bienes (maíz, quinua, charqui, chuño, tejidos, armas) producidos a lo largo del imperio debía almacenarse con técnicas avanzadas de conservación. El Estado construyó gigantescos depósitos de piedra en laderas ventiladas, conocidos como:',
    options: ['Piruas.', 'Tambos.', 'Colcas.', 'Llactas.', 'Kallancas.'],
    correctAnswer: 2,
    explanation:
        'Las Colcas eran los grandes almacenes estatales. Los Tambos, en cambio, eran posadas más pequeñas a lo largo de los caminos para el descanso de los ejércitos y chasquis.',
  ),
  Question(
    id: 'cs_q162',
    topicId: 'cs_t2',
    text:
        'La contabilidad estatal, los censos demográficos y la narrativa histórica se conservaban mediante un complejo sistema mnemotécnico y contable basado en cuerdas de lana o algodón con diversos nudos, colores y longitudes. ¿Qué funcionario estatal era adiestrado rigurosamente para operar este sistema?',
    options: [
      'El Amauta.',
      'El Quipucamayoc.',
      'El Willac Umu.',
      'El Chasqui.',
      'El Apocuna.',
    ],
    correctAnswer: 1,
    explanation:
        'El Quipucamayoc era el especialista que dominaba la lectura y confección de los quipus, siendo una pieza clave en el sistema burocrático y tributario incaico.',
  ),
  Question(
    id: 'cs_q163',
    topicId: 'cs_t2',
    text:
        "La base de la organización social, territorial y económica en el mundo andino era el Ayllu. Este se caracterizaba por poseer diversos vínculos que unían a sus integrantes. El vínculo de 'Marka' hace referencia específica a:",
    options: [
      'La creencia en un ancestro mítico común (Totem).',
      'El compartir una misma religión y lengua.',
      'La tenencia compartida y derecho de uso de un mismo territorio agrícola.',
      'La consanguinidad absoluta de todos sus miembros.',
      'El sometimiento a un mismo castigo penal dictado por el curaca.',
    ],
    correctAnswer: 2,
    explanation:
        "El vínculo de 'Marka' representa el lazo territorial: el conjunto de familias del ayllu poseía y explotaba en común un territorio determinado, distribuyéndose los topos de tierra.",
  ),
  Question(
    id: 'cs_q164',
    topicId: 'cs_t2',
    text:
        'El Imperio de los Incas tuvo su fase de mayor expansión territorial y esplendor a partir del siglo XV. Según la periodificación histórica andina tradicional, el soberano inca que fundó formalmente el Imperio (Tahuantinsuyo) al derrotar a los Chancas en la batalla de Yahuarpampa fue:',
    options: [
      'Manco Cápac.',
      'Inca Roca.',
      'Pachacútec.',
      'Túpac Yupanqui.',
      'Huayna Cápac.',
    ],
    correctAnswer: 2,
    explanation:
        'Pachacútec (Cusi Yupanqui) derrotó a los Chancas (aprox. 1438 d.C.), transformando el pequeño señorío cusqueño en un imperio panandino, reestructurando el Cusco y creando el sistema de mitmaqkunas.',
  ),
  Question(
    id: 'cs_q165',
    topicId: 'cs_t2',
    text:
        "El auge de las expansiones militares continuó con el hijo de Pachacútec, quien es considerado el 'Alejandro Magno' de los Andes por haber conquistado hasta el río Maule (Chile) por el sur y haberse adentrado en expediciones marítimas a las islas de Oceanía. Este inca navegante y conquistador fue:",
    options: [
      'Sinchi Roca.',
      'Túpac Inca Yupanqui.',
      'Huayna Cápac.',
      'Huáscar.',
      'Atahualpa.',
    ],
    correctAnswer: 1,
    explanation:
        'Túpac Yupanqui fue el inca conquistador por excelencia. Consolidó el imperio al sur, sometió a los Chimú en el norte, y organizó una célebre expedición marítima (islas de Ahuachumbi y Ninachumbi).',
  ),
  Question(
    id: 'cs_q166',
    topicId: 'cs_t2',
    text:
        'Para la nobleza imperial (la familia del Inca), mantener su pureza de sangre y recordar las proezas de sus antepasados era vital. Cada nuevo Inca fundaba su propia familia extendida, encargada de cuidar su momia (mallqui) tras su muerte y preservar su memoria. A esta familia real o linaje se le denominaba:',
    options: [
      'Ayllu real.',
      'Panaca.',
      'Realeza periférica.',
      'Pacarina.',
      'Huaca consanguínea.',
    ],
    correctAnswer: 1,
    explanation:
        'La Panaca era la familia extendida del Inca (esposas, hijos, descendientes, excepto el heredero principal que formaría su propia panaca). Cuidaban el cuerpo momificado del Inca y sus tierras.',
  ),
  Question(
    id: 'cs_q167',
    topicId: 'cs_t2',
    text:
        "La 'Nobleza de Privilegio' estaba constituida por personas que, sin ser familiares de sangre del Inca, eran ascendidos a un estatus noble. ¿Qué grupos solían formar parte de esta nobleza?",
    options: [
      'Prisioneros de guerra perdonados y esclavos (piñas) leales.',
      'Hatun runas que destacaban en el ejército, obras civiles, y curacas de naciones aliadas.',
      'Comerciantes marítimos de la cultura Chincha exclusivamente.',
      'Los artesanos extranjeros que introdujeron el bronce al imperio.',
      'Cualquier ciudadano que lograra descifrar un quipu imperial.',
    ],
    correctAnswer: 1,
    explanation:
        'La nobleza de privilegio recompensaba a plebeyos por hazañas excepcionales (nobles de recompensa) y asimilaba a los líderes de otras culturas anexadas (nobles advenedizos) para mantener la gobernabilidad.',
  ),
  Question(
    id: 'cs_q168',
    topicId: 'cs_t2',
    text:
        'La cosmovisión andina concebía el universo en una estructura tripartita. El mundo de los muertos, de las semillas en germinación y las fuerzas del subsuelo (y de deidades como Supay), era conocido como:',
    options: [
      'Hanan Pacha.',
      'Kay Pacha.',
      'Uku Pacha.',
      'Inti Pacha.',
      'Wamani Pacha.',
    ],
    correctAnswer: 2,
    explanation:
        'Uku Pacha era el inframundo o mundo subterráneo. Kay Pacha era el mundo terrenal (aquí y ahora), y Hanan Pacha era el mundo celestial (donde habitaban los dioses astros como el Inti o Quilla).',
  ),
  Question(
    id: 'cs_q169',
    topicId: 'cs_t2',
    text:
        'Para la élite incaica existían dos instituciones educativas fundamentales. Los jóvenes nobles varones eran instruidos en historia, milicia, quipus y religión en un recinto específico a cargo de los Amautas. Este recinto era:',
    options: [
      'El Acllahuasi.',
      'El Yachayhuasi.',
      'El Coricancha.',
      'El Tambo Machay.',
      'El Sunturhuasi.',
    ],
    correctAnswer: 1,
    explanation:
        "El Yachayhuasi ('Casa del Saber') era la institución educativa para la nobleza de sangre y privilegio. El Acllahuasi ('Casa de las Escogidas') era para la instrucción de las mujeres.",
  ),
  Question(
    id: 'cs_q170',
    topicId: 'cs_t2',
    text:
        "En el Acllahuasi (Casa de las Escogidas), las niñas de distintas provincias eran reclutadas por el Estado por su belleza o habilidades. Eran instruidas por las 'Mamaconas'. ¿Cuál era la función económica principal de la gran mayoría de estas 'Acllas' dentro de la logística del imperio?",
    options: [
      'Formar cuerpos de combate femeninos para la guardia del Inca.',
      'Ser sacrificadas obligatoriamente al cumplir los 18 años.',
      'Confeccionar textiles finos (cumbi) y preparar la chicha para rituales y redistribución.',
      'Operar como espías en el aparato de inteligencia del Tucuy Ricuy.',
      'Cuidar los rebaños de alpacas en el Collasuyu profundo.',
    ],
    correctAnswer: 2,
    explanation:
        'Aunque algunas acllas eran dadas en matrimonio o sacrificadas, la inmensa mayoría servía como fuerza laboral especializada de élite, tejiendo la ropa del Inca (cumbi) y fermentando bebidas ceremoniales.',
  ),
  Question(
    id: 'cs_q171',
    topicId: 'cs_t2',
    text:
        'En materia de tenencia de tierras, el Estado imperial dividía conceptualmente los campos agrícolas para la tributación. Las tierras destinadas al sustento exclusivo de los sacerdotes, la manutención del Coricancha y la realización de ofrendas eran denominadas:',
    options: [
      'Tierras del Ayllu.',
      'Tierras del Inca.',
      'Tierras de la Panaca.',
      'Tierras del Sol.',
      'Tierras del Curaca.',
    ],
    correctAnswer: 3,
    explanation:
        'Las Tierras del Sol estaban dedicadas a la religión imperial. Las Tierras del Inca abastecían al Estado y al ejército. Las Tierras del Ayllu (topos) eran para el sustento del pueblo común.',
  ),
  Question(
    id: 'cs_q172',
    topicId: 'cs_t2',
    text:
        'Las imponentes construcciones militares e imperiales incaicas (como Sacsayhuamán) destacan mundialmente por una técnica arquitectónica basada en el tallado y ensamblaje perfecto de inmensas rocas sin uso de argamasa, encajando los bloques como un rompecabezas. Este estilo de mampostería es conocido como:',
    options: [
      'Arquitectura de mampostería ordinaria con adobe.',
      'Arquitectura ciclópea poligonal almohadillada.',
      'Arquitectura de bóveda de cañón abovedada.',
      'Arquitectura gótica andina.',
      'Arquitectura monolítica de sillar volcánico.',
    ],
    correctAnswer: 1,
    explanation:
        'El ensamblaje exacto de rocas poligonales (de muchos lados) inmensas (ciclópeas), que protruyen ligeramente (almohadilladas) confiriendo resistencia sísmica, es el sello de la alta arquitectura incaica.',
  ),
  Question(
    id: 'cs_q173',
    topicId: 'cs_t2',
    text:
        "La deidad principal del Imperio Incaico, impuesta a todos los pueblos conquistados como dios oficial del Estado teocrático, era el Inti (el Sol). Sin embargo, existía otra deidad creadora abstracta, considerada el 'Hacedor del Mundo', adorada especialmente por la nobleza y muy antigua en los Andes. Esta deidad es:",
    options: [
      'Pachacámac.',
      'Apu Kon Titi Wiracocha.',
      'Illapa (el Rayo).',
      'Pachamama (la Tierra).',
      'Mama Cocha (el Mar).',
    ],
    correctAnswer: 1,
    explanation:
        'Wiracocha era la deidad ordenadora del mundo, preincaica e invisible. El culto al Inti era más político, mientras que Wiracocha representaba un concepto teológico superior y civilizador.',
  ),
  Question(
    id: 'cs_q174',
    topicId: 'cs_t2',
    text:
        "Un aspirante a Oficial PNP debe comprender la logística antigua. El 'Qhapaq Ñan' (Gran Camino Inca) fue una de las obras de ingeniería vial más impresionantes de la humanidad. ¿Cuál fue el principal propósito político-militar de esta colosal red de caminos que atravesaba el imperio?",
    options: [
      'Permitir que el pueblo viaje libremente para realizar trueque vacacional.',
      'Fomentar carreras deportivas inter-suyus durante los solsticios.',
      'Facilitar el tránsito de carretas impulsadas por rebaños de llamas.',
      'Acelerar el desplazamiento de las legiones del ejército, mensajeros (chasquis) y burócratas para asegurar el control estatal.',
      'Servir exclusivamente como ruta de peregrinaje para sacrificios humanos.',
    ],
    correctAnswer: 3,
    explanation:
        'El Qhapaq Ñan fue una infraestructura de dominación estatal. Solo los autorizados (militares, chasquis, curacas, administradores) transitaban por él, asegurando la rápida respuesta ante sublevaciones y la fluidez logística.',
  ),
  Question(
    id: 'cs_q175',
    topicId: 'cs_t2',
    text:
        'El derecho consuetudinario inca (derecho basado en la costumbre y la moral) era drástico en sus sanciones para garantizar el orden. Existían tres máximas morales resumidas en quechua que todo ciudadano debía seguir. ¿Cuáles eran estos tres preceptos fundamentales?',
    options: [
      'Ama Sua (No seas ladrón), Ama Llulla (No seas mentiroso), Ama Quella (No seas ocioso).',
      'Ama Runa (No mates), Ama Kausay (No vivas), Ama Chaski (No corras).',
      'Ama Hucha (No peques), Ama Qori (No robes oro), Ama Supay (No seas demonio).',
      'Ama Pacha (No ensucies), Ama Yawar (No sangres), Ama Inti (No mires al sol).',
      'Ama Killa (No adores la luna), Ama Llaqta (No dejes tu pueblo), Ama Ayni (No niegues ayuda).',
    ],
    correctAnswer: 0,
    explanation:
        "El 'Ama Sua, Ama Llulla, Ama Quella' constituían la base de la ética social comunitaria, fuertemente penalizada con castigos físicos y letales por el Estado.",
  ),
  Question(
    id: 'cs_q176',
    topicId: 'cs_t2',
    text:
        'A nivel religioso, existía en la costa central (actual Lima) un santuario preincaico de inmenso poder, cuyo ídolo principal era considerado el dios de los terremotos y creador de los pueblos costeños. Los incas, debido al terror y respeto que infundía, lo respetaron y asimilaron a su panteón imperial. Nos referimos a:',
    options: [
      'El señor de Sipán.',
      'Wiracocha.',
      'Pachacámac.',
      'Ai Apaec.',
      'Catequil.',
    ],
    correctAnswer: 2,
    explanation:
        "El Oráculo de Pachacámac, temido como 'El que anima el mundo' y causante de los temblores, fue el centro religioso más influyente de la costa central y respetado religiosamente por los Incas.",
  ),
  Question(
    id: 'cs_q177',
    topicId: 'cs_t2',
    text:
        'El sumo sacerdote del Imperio, considerado el intermediario entre el Inca y las divinidades, líder supremo del Coricancha y segundo en jerarquía religiosa tras el Sapa Inca, ostentaba el título de:',
    options: [
      'Huillac Umu.',
      'Amauta.',
      'Apocuna.',
      'Quipucamayoc.',
      'Sinchi.',
    ],
    correctAnswer: 0,
    explanation:
        'El Willac Umu (o Huillac Umu) era el máximo pontífice solar del Tahuantinsuyo. Usualmente era hermano o familiar directo (panaca) del Inca.',
  ),
  Question(
    id: 'cs_q178',
    topicId: 'cs_t2',
    text:
        "Las 'Llactas' eran centros administrativos construidos por el Estado Inca en provincias clave para controlar vastos territorios. Su función principal era asentar a burócratas, almacenar la tributación en las colcas y proyectar el poder de Cusco. Un ejemplo arquitectónico famoso de una llacta de paso y administración es:",
    options: [
      'Huaca del Sol.',
      'Machu Picchu.',
      'Huanuco Pampa.',
      'Chan Chan.',
      'Kuelap.',
    ],
    correctAnswer: 2,
    explanation:
        'Huánuco Pampa (Huánuco Viejo) fue una llacta monumental en el Chinchaysuyu, construida explícitamente a gran escala por el Estado para fines administrativos y logísticos del ejército imperial.',
  ),
  Question(
    id: 'cs_q179',
    topicId: 'cs_t2',
    text:
        'La cerámica característica del periodo incaico fue producida en masa para fines rituales y de almacenamiento de la chicha. Su forma es fácilmente reconocible: base cónica (para enterrarla en la arena/tierra), cuello largo y cuerpo globular con asas laterales. Esta pieza se denomina:',
    options: [
      'Huaco retrato.',
      'Aríbalo (o Urpu).',
      'Kero.',
      'Pucos policromos.',
      'Huaco silbador.',
    ],
    correctAnswer: 1,
    explanation:
        'El Aríbalo (urpu en quechua) es la máxima expresión alfarera incaica, cuyo diseño estandarizado fue difundido por todo el imperio para la fermentación masiva de chicha de jora.',
  ),
  Question(
    id: 'cs_q180',
    topicId: 'cs_t2',
    text:
        'Existía un tipo particular de sirvientes (esclavos) del Imperio Incaico, conformados por prisioneros de guerra empedernidos que se negaban a someterse pacíficamente. Eran castigados y enviados de por vida a los cocales de la densa y mortífera selva alta para trabajos forzados a favor del Estado. A estos individuos se les conocía como:',
    options: ['Yanaconas.', 'Mitmaqkuna.', 'Piñas.', 'Acllas.', 'Hatun runas.'],
    correctAnswer: 2,
    explanation:
        'Los Piñas (o pinacuna) representaban el estrato más bajo (esclavos o prisioneros de guerra). Se les confinaba al Antisuyu (selva) para las duras labores de cultivo de coca, de la cual el Inca tenía monopolio.',
  ),
  Question(
    id: 'cs_q181',
    topicId: 'cs_t2',
    text:
        "Para asegurar una sucesión ordenada y preparar al futuro gobernante en el arte de la guerra y la administración, el Inca solía designar en vida a su príncipe heredero, quien cogobernaba junto a él (correinado). Este príncipe heredero, que no siempre era el primogénito sino el 'más hábil', recibía el título de:",
    options: [
      'Curaca.',
      'Auqui.',
      'Apocuna.',
      'Tucuy Ricuy.',
      'Tahuantinsuyo Camachic.',
    ],
    correctAnswer: 1,
    explanation:
        'El Auqui era el príncipe heredero electo. El sistema de correinado permitió afinar las capacidades militares del sucesor, como lo demostraron brillantemente Pachacútec y Túpac Yupanqui.',
  ),
  Question(
    id: 'cs_q182',
    topicId: 'cs_t2',
    text:
        'El Consejo Imperial incaico, que asesoraba al Sapa Inca en decisiones de alta política y guerra, estaba conformado por los representantes máximos de cada uno de los cuatro suyus, actuando como un consejo de ministros. ¿Con qué nombre se conocía a este asamblea y a sus miembros?',
    options: [
      'El Yachayhuasi y los Amautas.',
      'El Tahuantinsuyo Camachic y los Apocunas (o Suyuyuc Apu).',
      'El Panaca y los Sinchis.',
      'El Huarochirí y los Curacas.',
      'El Cumbi y los Yanaconas.',
    ],
    correctAnswer: 1,
    explanation:
        'El Tahuantinsuyo Camachic era el consejo imperial. Los cuatro jefes de los suyus, llamados Apocunas o Suyuyuc Apu, conformaban el grupo de asesores directos del Sapa Inca.',
  ),
  Question(
    id: 'cs_q183',
    topicId: 'cs_t2',
    text:
        'El sistema de comunicaciones rápidas del Imperio recaía en mensajeros jóvenes, altamente entrenados desde niños para correr enormes distancias por los caminos de herradura relevándose mediante postas. Además de transmitir mensajes verbales, ellos llevaban los quipus. Estos corredores eran los:',
    options: [
      'Quipucamayoc.',
      'Sinchis.',
      'Chasquis.',
      'Tucuy Ricuy.',
      'Acllas.',
    ],
    correctAnswer: 2,
    explanation:
        'Los Chasquis eran los veloces corredores de relevos. Gracias a ellos, el Inca podía recibir información vital (o pescado fresco desde la costa) en el Cusco en un lapso de 4 a 5 días.',
  ),
  Question(
    id: 'cs_q184',
    topicId: 'cs_t2',
    text:
        'En tiempo de guerra o invasión inminente, el control pacífico del Curaca en el Ayllu era temporalmente reemplazado por un jefe militar fuerte, escogido excepcionalmente por sus hazañas bélicas para liderar a las milicias locales. A este caudillo guerrero temporal se le conocía como:',
    options: ['Sinchi.', 'Auqui.', 'Willac Umu.', 'Yanacona.', 'Chasqui.'],
    correctAnswer: 0,
    explanation:
        'El Sinchi era el jefe guerrero del ayllu. Solo adquiría máxima autoridad en tiempos de guerra; en tiempos de paz, la autoridad administrativa recaía en el Curaca.',
  ),
  Question(
    id: 'cs_q185',
    topicId: 'cs_t2',
    text:
        'Para entender la organización agraria, es fundamental conocer la unidad de medida superficial que el Estado asignaba a los plebeyos (Hatun runas) al casarse para su subsistencia. Su tamaño variaba dependiendo de la fertilidad de la tierra (más grande en la puna, más pequeña en los fértiles valles). ¿Cómo se llamaba esta porción de tierra?',
    options: ['Hacienda.', 'Topo (o Tupu).', 'Chacra.', 'Ayllu.', 'Tambo.'],
    correctAnswer: 1,
    explanation:
        'El Topo era la parcela de tierra otorgada anualmente. Se entregaba un topo completo al varón y medio topo a la mujer (por sus diferencias en demanda alimentaria y de trabajo bruto).',
  ),
  Question(
    id: 'cs_q186',
    topicId: 'cs_t2',
    text:
        'Un aspecto distintivo del Imperio Incaico fue su origen mítico, utilizado para divinizar a sus fundadores y legitimar su autoridad. La Leyenda de los Hermanos Ayar, recopilada por el cronista Juan de Betanzos, es uno de estos mitos. Según este relato, los cuatro hermanos fundadores y sus esposas salieron de una pacarina (lugar de origen) ubicada en:',
    options: [
      'Las aguas profundas del Lago Titicaca.',
      'La cueva de Capac Tocco en el cerro Tamputocco (Pacaritambo).',
      'El volcán Misti en Arequipa.',
      'El templo principal de Chavín de Huántar.',
      'El desierto de Nasca bajo la mirada del dios Sol.',
    ],
    correctAnswer: 1,
    explanation:
        'En el mito de los Hermanos Ayar, Ayar Manco (Manco Cápac) y sus hermanos emergen de la cueva en el cerro Tamputocco. El mito del Titicaca, en cambio, es el de Manco Cápac y Mama Ocllo (recopilado por Garcilaso).',
  ),
  Question(
    id: 'cs_q187',
    topicId: 'cs_t2',
    text:
        'La caída del Imperio Incaico (1532) se precipitó, entre otros factores biológicos, por una devastadora guerra civil que dividió al ejército y las panacas cusqueñas a la muerte de Huayna Cápac. Los dos medio hermanos que se enfrentaron sangrientamente por la mascapaicha (corona) fueron:',
    options: [
      'Manco Inca y Túpac Amaru.',
      'Huáscar y Atahualpa.',
      'Pachacútec y Wiracocha.',
      'Sinchi Roca y Lloque Yupanqui.',
      'Calcuchímac y Quizquiz.',
    ],
    correctAnswer: 1,
    explanation:
        'Huáscar (coronado en Cusco) y Atahualpa (quien tenía a los generales veteranos en Quito) protagonizaron la guerra civil pan-incaica que facilitó enormemente la invasión española liderada por Pizarro.',
  ),
  Question(
    id: 'cs_q188',
    topicId: 'cs_t2',
    text:
        'La textilería en el Tahuantinsuyo no solo era para abrigo, sino que poseía un altísimo valor de prestigio y ritual. Existían dos calidades principales de tejido. La prenda extremadamente fina, tejida por las acllas utilizando exquisita lana de vicuña o alpaca bebé y reservada exclusivamente para el Inca y su élite, se llamaba:',
    options: ['Abasca.', 'Tocapu.', 'Kero.', 'Cumbi.', 'Chusi.'],
    correctAnswer: 3,
    explanation:
        'El Cumbi era el tejido imperial de lujo, a menudo adornado con plumas o hilos de oro. El pueblo llano vestía ropa de Abasca, hecha de lana de llama o algodón áspero.',
  ),
  Question(
    id: 'cs_q189',
    topicId: 'cs_t2',
    text:
        'En los finos textiles incas (cumbis) a menudo se observan cuadrados geométricos repetitivos con diseños abstractos. Muchos antropólogos y etnohistoriadores modernos sugieren que estos diseños no eran meramente decorativos, sino que constituían un sistema de escritura ideográfica paralela a los quipus. Estos cuadretes se denominan:',
    options: [
      'Líneas de Nasca.',
      'Tocapus.',
      'Geoglifos.',
      'Keros.',
      'Mitmaqkunas.',
    ],
    correctAnswer: 1,
    explanation:
        'Los Tocapus son los símbolos cuadrados geométricos tejidos o pintados. Aunque no se han descifrado completamente, se cree firmemente que representaban linajes, conceptos heráldicos o un lenguaje ideográfico incipiente.',
  ),
  Question(
    id: 'cs_q190',
    topicId: 'cs_t2',
    text:
        'El calendario agrícola y ritual estaba íntimamente ligado al movimiento de los astros. La festividad sagrada más grande del imperio, en honor al Dios Sol y celebrada masivamente en la plaza principal de Cusco durante el solsticio de invierno (junio), era:',
    options: [
      'La Coya Raymi.',
      'La Qoyllur Riti.',
      'El Inti Raymi.',
      'El Huarachico.',
      'El Capac Raymi.',
    ],
    correctAnswer: 2,
    explanation:
        'El Inti Raymi (Fiesta del Sol) era el pináculo ceremonial inca, donde las panacas y curacas reafirmaban su lealtad al Sapa Inca y al Sol en el solsticio de invierno.',
  ),
  Question(
    id: 'cs_q191',
    topicId: 'cs_t2',
    text:
        'Para mantener su monopolio de dominación, el Estado inca no permitía que las etnias subyugadas se integraran demasiado libremente. A nivel de infraestructura demográfica, ¿cómo marcaban y controlaban los incas la procedencia étnica de los pobladores conquistados?',
    options: [
      'Les tatuaban el símbolo de la panaca en el rostro.',
      'Los obligaban a llevar vestimenta con cortes, colores o tocados distintivos de su origen que no podían cambiar bajo pena severa.',
      'Los encadenaban a sus pueblos impidiendo cualquier tipo de movilización.',
      'Les prohibían el uso de la lengua quechua (Runa Simi).',
      'Los forzaban a usar anillos de oro y plata grabados.',
    ],
    correctAnswer: 1,
    explanation:
        'El Estado obligaba a cada etnia a conservar su indumentaria y tocado tradicional. Mudar de traje originario era un delito castigado, pues el Estado necesitaba censar e identificar rápidamente la procedencia de cada masa trabajadora.',
  ),
  Question(
    id: 'cs_q192',
    topicId: 'cs_t2',
    text:
        'El instrumento de labranza principal del campesino incaico (Hatun Runa) era una especie de arado de pie, adaptado perfectamente a las laderas andinas donde el uso de animales de tiro o el arado de bueyes era imposible. Esta herramienta de madera, con un estribo para empujar con el pie humano, es la:',
    options: [
      'Chaquitaclla.',
      'Porra estrellada.',
      'Hoz de bronce.',
      'Macana.',
      'Azada de hierro.',
    ],
    correctAnswer: 0,
    explanation:
        'La Chaquitaclla o arado de pie andino es el ícono de la agricultura prehispánica. Permitía romper los duros terrones de la sierra utilizando únicamente la fuerza motriz humana.',
  ),
  Question(
    id: 'cs_q193',
    topicId: 'cs_t2',
    text:
        'A nivel táctico, el ejército imperial estaba altamente organizado y jerarquizado. Su estrategia no consistía primordialmente en exterminar al enemigo al primer contacto. ¿Cuál era la directriz geopolítica típica y preferida por el Inca antes de desatar un ataque destructivo contra una cultura vecina?',
    options: [
      'Enviar asesinos en la noche para matar a toda la élite rival de sorpresa.',
      'Ofrecer reiteradamente propuestas de anexión pacífica y reciprocidad, mediante el envío de regalos fastuosos a los líderes rivales.',
      'Envenenar los cursos de agua que abastecían a las ciudades enemigas.',
      'Incendiar inmediatamente los templos religiosos del rival para desmoralizarlos.',
      'Desafiar al líder rival a un combate singular a muerte.',
    ],
    correctAnswer: 1,
    explanation:
        "La 'conquista pacífica' mediante la asimetría de la reciprocidad era el paso uno. El Inca enviaba mujeres finas, cumbi y chicha a los curacas rivales; si aceptaban el regalo, quedaban endeudados políticamente y sometidos al Cusco sin derramar sangre.",
  ),
  Question(
    id: 'cs_q194',
    topicId: 'cs_t2',
    text:
        "El Tahuantinsuyo logró expandirse hacia ecosistemas inhóspitos para ampliar su frontera agrícola. La ingeniería hidráulica andina destacó por la construcción de 'camellones' o 'Waru Waru', unas plataformas de tierra elevada rodeadas de canales de agua. Esta técnica fue masivamente utilizada en:",
    options: [
      'El desierto costero peruano para aprovechar ríos subterráneos.',
      'Las laderas empinadas del Cusco para evitar huaicos.',
      'La selva baja amazónica para secar humedales.',
      'El Altiplano y cuenca del Titicaca para mitigar las heladas nocturnas y absorber calor.',
      'Los santuarios sagrados exclusivamente como ornamentos acuáticos.',
    ],
    correctAnswer: 3,
    explanation:
        'Los Waru Waru son típicos de la gélida meseta del Collao. El agua de los canales almacenaba calor solar de día y lo irradiaba de noche, creando un microclima que evitaba que la papa y quinua murieran congeladas.',
  ),
  Question(
    id: 'cs_q195',
    topicId: 'cs_t2',
    text:
        'Al heredar la mascapaicha, el nuevo Inca no heredaba la riqueza material de su predecesor (tierras, palacios y tesoros), pues estos pasaban a pertenecer a la panaca del Inca difunto. Esta particular regla de sucesión originó una de las principales dinámicas imperiales:',
    options: [
      'La pobreza extrema cíclica de los soberanos incas.',
      'La pacificación completa y el fin de las guerras, pues no había motivos económicos.',
      'El impulso insaciable de conquistas expansionistas, ya que el nuevo Inca debía anexar nuevas tierras para formar su propio patrimonio.',
      'El colapso rápido del imperio por falta de liquidez monetaria.',
      'La disolución de los ejércitos al morir cada monarca.',
    ],
    correctAnswer: 2,
    explanation:
        'Esta institución (denominada herencia partida) forzaba al nuevo Inca a emprender campañas militares agresivas de expansión para conquistar nuevos topos de tierra y poblaciones, pues las antiguas pertenecían a la nobleza momificada.',
  ),
  Question(
    id: 'cs_q196',
    topicId: 'cs_t2',
    text:
        'En la jerarquía jurídica y judicial del Tahuantinsuyo, los castigos por alterar el orden público eran ejemplares y disuasivos. Por ejemplo, los crímenes de rebelión contra el Estado o el robo a las colcas imperiales se sancionaban casi invariablemente con:',
    options: [
      'La prisión preventiva por 10 años en mazmorras.',
      'El pago de multas mediante oro fundido y metales.',
      'El trabajo comunitario adicional por una luna.',
      'La pena de muerte (despeñamiento, ahorcamiento o muerte a golpes).',
      'El destierro en balsas hacia Oceanía.',
    ],
    correctAnswer: 3,
    explanation:
        "El sistema penal inca era intimidatorio y draconiano. Al no existir el concepto de 'cárceles' de reclusión (salvo mazmorras de tortura pasajeras), la traición, rebelión o robo al Estado terminaba en pena capital ineludible.",
  ),
  Question(
    id: 'cs_q197',
    topicId: 'cs_t2',
    text:
        'La dualidad fue un principio filosófico en la organización andina, evidenciándose no solo en la religión sino en la administración espacial del Cusco, que estaba dividido en dos mitades, reflejando poder político y poder sacerdotal. Estas dos mitades antagónicas y complementarias se llamaban:',
    options: [
      'Chinchaysuyu y Collasuyu.',
      'Hanan Cusco y Hurin Cusco.',
      'Cusco imperial y Cusco provincial.',
      'Ayllu rico y Ayllu pobre.',
      'Inca y Auqui.',
    ],
    correctAnswer: 1,
    explanation:
        'El modelo dual andino estructuró el imperio. El Hanan (arriba/dominante/político-militar) y el Hurin (abajo/religioso). Las panacas y autoridades se agrupaban en estas dos grandes parcialidades.',
  ),
  Question(
    id: 'cs_q198',
    topicId: 'cs_t2',
    text:
        'Además del Aríbalo, la cultura Inca produjo otro recipiente artesanal icónico, usualmente tallado finamente en madera de chonta y adornado con incisiones polícromas, utilizado ceremonialmente para brindar chicha en actos de reciprocidad política. Este vaso ceremonial es el:',
    options: [
      'Kero.',
      'Huaco retrato.',
      'Vaso ceremonial Chimú.',
      'Pajcha.',
      'Tumy.',
    ],
    correctAnswer: 0,
    explanation:
        'El Kero (vaso ceremonial de origen Tiahuanaco y masificado por los incas) era un símbolo de estatus. Brindar (tincar) con dos keros sellaba acuerdos políticos de reciprocidad.',
  ),
  Question(
    id: 'cs_q199',
    topicId: 'cs_t2',
    text:
        "En la religiosidad andina, los 'ceques' eran líneas imaginarias radiales que partían del Coricancha (Cusco) hacia todas direcciones del imperio. Sobre estas líneas o rutas sagradas se ubicaban geográficamente los cientos de puntos sagrados, rocas, manantiales y santuarios adorados por los incas. Estos lugares de adoración en conjunto se denominan:",
    options: ['Llactas.', 'Tambos.', 'Huacas.', 'Acllahuasis.', 'Chullpas.'],
    correctAnswer: 2,
    explanation:
        "Una 'Huaca' es cualquier objeto, lugar o persona que posee sacralidad en los Andes (una roca de forma inusual, un nevado, una cueva, el cuerpo del Inca). El sistema de ceques interconectaba las huacas de Cusco.",
  ),
  Question(
    id: 'cs_q200',
    topicId: 'cs_t2',
    text:
        'Para mantener unida la gigantesca amalgama de más de 200 etnias, lenguas y culturas distintas bajo el dominio del Cusco, el Estado Inca estableció dos grandes medidas de imposición administrativa obligatoria a los pueblos recién conquistados. Estas medidas fueron:',
    options: [
      'El pago del quinto real en plata y la conversión al cristianismo.',
      'La destrucción inmediata de sus huacas locales y el asesinato de sus curacas nativos.',
      'El establecimiento del uso oficial de la escritura en papiro y la creación de un senado.',
      'La asimilación de su élite al Yachayhuasi y la expropiación pacífica de tierras por parte de la Iglesia Católica.',
      'La imposición del Runa Simi (quechua) como idioma oficial de administración y la adoración al Sol (Inti) como deidad suprema, respetando divinidades menores.',
    ],
    correctAnswer: 4,
    explanation:
        'La estandarización lingüística (quechua) y la imposición del culto solar, por encima de los dioses locales, fueron las grandes herramientas cohesionadoras y homogenizadoras del Imperio Incaico, garantizando el control burocrático y espiritual.',
  ),
  Question(
    id: 'cs_q201',
    topicId: 'cs_t2',
    text:
        'En la jerarquía eclesiástica del Imperio Incaico, el sumo sacerdote del Sol y máxima autoridad religiosa, quien generalmente era hermano o pariente muy cercano del Sapa Inca, y que residía en el Coricancha, recibía el título de:',
    options: [
      'Willac Umu.',
      'Tucuy Ricuy.',
      'Apu Quispay.',
      'Taripa Camayoc.',
      'Apocuna.',
    ],
    correctAnswer: 0,
    explanation:
        'El Willac Umu (cabeza que habla) era el Sumo Sacerdote del culto solar. Al ser usualmente un familiar directo del Inca, se garantizaba que el inmenso poder religioso estuviera subordinado a los intereses políticos del Estado y de la panaca reinante.',
  ),
  Question(
    id: 'cs_q202',
    topicId: 'cs_t2',
    text:
        'El control demográfico y tributario del Tahuantinsuyo era extraordinariamente preciso pese a no existir escritura alfabética. El funcionario encargado de leer e interpretar los registros contables y estadísticos anudados (quipus) era el:',
    options: [
      'Amauta.',
      'Chasqui.',
      'Quipucamayoc.',
      'Mitmaqkuna.',
      'Auca Runa.',
    ],
    correctAnswer: 2,
    explanation:
        'El Quipucamayoc era el especialista estatal entrenado desde niño para codificar (anudar) y decodificar (leer) la información cuantitativa (censos, cosechas, tributos) en los quipus, siendo el pilar de la burocracia inca.',
  ),
  Question(
    id: 'cs_q203',
    topicId: 'cs_t2',
    text:
        'La cosmovisión andina dividía el espacio y el tiempo de manera dual y tripartita. El mundo de abajo o de los muertos, asociado a la humedad, las semillas en germinación y las fuerzas subterráneas de las huacas, era conocido como:',
    options: [
      'Hanan Pacha.',
      'Kay Pacha.',
      'Uku Pacha.',
      'Chinchaysuyo.',
      'Inti Raymi.',
    ],
    correctAnswer: 2,
    explanation:
        'El Uku Pacha es el mundo interior (inframundo). A diferencia del infierno judeocristiano, no es un lugar de castigo, sino el espacio de origen (pacarinas), de la fertilidad de la tierra y del descanso de los ancestros.',
  ),
  Question(
    id: 'cs_q204',
    topicId: 'cs_t2',
    text:
        'La caída demográfica del Tahuantinsuyo durante la invasión española no se debió exclusivamente a las batallas y a la guerra civil. El factor más letal y devastador que aniquiló a millones de indígenas andinos, incluso antes de que Pizarro llegara físicamente al Cusco, fue:',
    options: [
      'El envenenamiento masivo de los ríos por parte de los conquistadores.',
      'Las epidemias de enfermedades euroasiáticas (como la viruela, el sarampión y la influenza) para las cuales la población nativa carecía de inmunidad biológica.',
      'El suicidio colectivo inducido por los sacerdotes del Sol tras la muerte de Atahualpa.',
      'La hambruna producida por un mega Fenómeno del Niño de 10 años continuos.',
      'La erupción simultánea de todos los volcanes del sur andino.',
    ],
    correctAnswer: 1,
    explanation:
        "El 'choque biológico' o epidemiológico fue catastrófico. Virus como la viruela diezmaron al imperio, matando incluso al Inca Huayna Cápac y a su sucesor Ninan Cuyuchi, desencadenando la guerra civil.",
  ),
  Question(
    id: 'cs_q205',
    topicId: 'cs_t2',
    text:
        "En el sistema de trabajo andino precolombino, existía un mecanismo de ayuda mutua al interior del Ayllu, regido por el principio de reciprocidad simétrica estricta. 'Hoy por ti, mañana por mí'. Si una familia necesitaba techar su casa, los demás miembros del Ayllu colaboraban bajo la figura del:",
    options: ['Mita.', 'Ayni.', 'Minca (Minka).', 'Chunca.', 'Mita de tambo.'],
    correctAnswer: 1,
    explanation:
        'El Ayni es la reciprocidad familiar (simétrica) entre individuos del mismo Ayllu. Se paga devolviendo exactamente la misma cantidad de trabajo o bienes en el futuro.',
  ),
  Question(
    id: 'cs_q206',
    topicId: 'cs_t2',
    text:
        'A diferencia del Ayni, la Minca (o Minka) representaba una forma de reciprocidad asimétrica colectiva. ¿Cuál de las siguientes actividades se realizaba típicamente bajo el sistema de Minka en el Tahuantinsuyo?',
    options: [
      'Techar la vivienda particular de un campesino recién casado.',
      'Extraer minerales en los socavones profundos de Potosí para el Inca.',
      'Sembrar y cosechar las tierras del sol o del curaca (autoridad local), y construir canales comunales de regadío en beneficio de todo el Ayllu.',
      'El servicio militar obligatorio de la nobleza de sangre.',
      'Servir como aclla tejiendo ropa fina (cumbi) para el Inca en el acllahuasi.',
    ],
    correctAnswer: 2,
    explanation:
        'La Minka es el trabajo colectivo obligatorio en beneficio del bien común (puentes, canales) o de la autoridad local (Curaca) e instituciones (Sol). A cambio, las autoridades proveían chicha, comida y música a los trabajadores.',
  ),
  Question(
    id: 'cs_q207',
    topicId: 'cs_t2',
    text:
        "La 'Mita' era el sistema tributario por excelencia del Estado Inca. A diferencia de los tributos europeos pagados en moneda o especie, el hatun runa tributaba al Estado aportando:",
    options: [
      'El 10% (diezmo) de sus hijos primogénitos para sacrificios humanos.',
      'Exclusivamente oro y plata en lingotes fundidos.',
      'Su energía humana (fuerza de trabajo) por turnos, laborando temporalmente para el Estado en la construcción de caminos, fortalezas, o sirviendo en el ejército.',
      'Un porcentaje de la cosecha obtenida en las tierras de su propio topo (tierra familiar).',
      'Esclavos amazónicos capturados en batalla.',
    ],
    correctAnswer: 2,
    explanation:
        "El Tahuantinsuyo no cobraba tributo en bienes de la parcela del campesino, sino en 'turnos de trabajo' (Mita). El Estado se apropiaba de la plusvalía laboral para llenar sus colcas y expandir la infraestructura imperial.",
  ),
  Question(
    id: 'cs_q208',
    topicId: 'cs_t2',
    text:
        'El Ayllu andino no solo compartía vínculos de consanguinidad. Para mantener la cohesión, todos los miembros del ayllu adoraban a un mismo antepasado común o divinidad tutelar, del cual creían descender, y que justificaba su derecho sobre las tierras que ocupaban. Este vínculo se denomina:',
    options: [
      'Vínculo de Pacarina.',
      'Vínculo de Marka.',
      'Vínculo de Totem / Mallqui.',
      'Vínculo de Sangre.',
      'Vínculo de Reciprocidad.',
    ],
    correctAnswer: 2,
    explanation:
        'El vínculo religioso-identitario en el Ayllu se daba por la adoración del Mallqui (momia del ancestro) o el Tótem tutelar. Adicionalmente, creían provenir de un mismo lugar de origen sagrado (vínculo de pacarina).',
  ),
  Question(
    id: 'cs_q209',
    topicId: 'cs_t2',
    text:
        "La educación incaica era profundamente elitista. Los hijos varones de la nobleza cuzqueña y de los curacas sometidos estudiaban en el 'Yachayhuasi' (Casa del Saber) para ser preparados como futuros administradores del Estado. ¿Qué personaje era el encargado principal de impartir estos conocimientos y la historia imperial?",
    options: [
      'El Haravicu.',
      'El Mamacona.',
      'El Amauta.',
      'El Apocuna.',
      'El Sinchi.',
    ],
    correctAnswer: 2,
    explanation:
        'El Amauta era el maestro o sabio del Yachayhuasi. Su rol era instruir a la élite en religión, historia, estrategia militar y lectura de quipus para garantizar la continuidad hegemónica del imperio.',
  ),
  Question(
    id: 'cs_q210',
    topicId: 'cs_t2',
    text:
        "Las Acllas (mujeres escogidas) cumplían un rol vital en la economía y diplomacia incaica. Recluidas en los 'Acllahuasis', bajo la tutela de las Mamaconas, su principal función productiva de alto valor para el Estado consistía en:",
    options: [
      'Entrenar artes marciales para conformar la guardia personal del Sapa Inca.',
      'Tejer la finísima ropa de cumbi (usada por el Inca e ídolos) y preparar masivamente la chicha de jora para las festividades estatales de redistribución.',
      'Memorizar los quipus bélicos y estadísticos del imperio.',
      'Cultivar exclusivamente la planta de coca en las yungas.',
      'Construir los puentes colgantes de ichu sobre el río Apurímac.',
    ],
    correctAnswer: 1,
    explanation:
        "El Estado inca utilizaba a las Acllas como fuerza laboral hiperespecializada. El cumbi (tejido fino) y la chicha eran bienes de prestigio indispensables para que el Inca pudiera 'redistribuir' y asegurar la lealtad de los curacas sometidos.",
  ),
  Question(
    id: 'cs_q211',
    topicId: 'cs_t2',
    text:
        "La nobleza incaica se dividía claramente en 'Nobleza de Sangre' (las Panacas cuzqueñas) y 'Nobleza de Privilegio'. Esta última estaba conformada por:",
    options: [
      'Esclavos (Piñas) que lograban comprar su libertad con oro.',
      'Reyes de otras naciones que lograban derrotar militarmente al Inca.',
      'Hatun runas destacados por sus hazañas militares o servicios excepcionales al Estado, y que eran ennoblecidos por gracia del Inca (ej. los orejones de privilegio).',
      'Los comerciantes chinchanos que monopolizaban el mullu (Spondylus).',
      'Los prisioneros de guerra amazónicos.',
    ],
    correctAnswer: 2,
    explanation:
        "El Inca premiaba a individuos comunes (Hatun Runas) que demostraban valentía en batalla o inventaban técnicas útiles, elevándolos a la 'Nobleza de Privilegio' o 'Advenediza', asimilándolos a la burocracia estatal.",
  ),
  Question(
    id: 'cs_q212',
    topicId: 'cs_t2',
    text:
        "El 'Cápac Ñan' no era un simple sendero; era el sistema de integración logística más grande de América antigua, con más de 30,000 km. Para garantizar el éxito de este sistema vial, el Estado ordenó la construcción de una vasta red de almacenes e infraestructuras a lo largo del camino, espaciados a un día de marcha, llamados:",
    options: ['Colcas.', 'Tambos.', 'Llactas.', 'Chullpas.', 'Huacas.'],
    correctAnswer: 1,
    explanation:
        'Los Tambos (Tampu) eran posadas y centros de acopio estratégicos a la orilla del Cápac Ñan. Abastecían a los ejércitos incaicos en movimiento, a la élite viajera y servían como refugio a los veloces chasquis.',
  ),
  Question(
    id: 'cs_q213',
    topicId: 'cs_t2',
    text:
        "Para los Incas, la conquista de nuevos territorios (expansión) priorizaba inicialmente una 'Estrategia Diplomática' sobre la guerra abierta. El Inca ofrecía regalos suntuosos (ropa de cumbi, mullu, mujeres de la nobleza) a los curacas locales. Si el curaca aceptaba, se sometía pacíficamente; esto se basa en el principio andino de:",
    options: [
      'Tributación mercantil.',
      'Guerra Florida.',
      'Reciprocidad Asimétrica (o Redistribución).',
      'Monopolio comercial forzoso.',
      'Limpieza étnica pacífica.',
    ],
    correctAnswer: 2,
    explanation:
        "El Estado aplicaba la reciprocidad a escala imperial. Al dar regalos valiosos que el curaca no podía devolver igualar (asimetría), el curaca quedaba 'en deuda' con el Inca, pagando esa deuda con la mano de obra de su pueblo.",
  ),
  Question(
    id: 'cs_q214',
    topicId: 'cs_t2',
    text:
        'Cuando una nación o etnia se rebelaba contra el Imperio, o cuando se requería poblar una nueva región por motivos de seguridad o producción agrícola, el Estado trasladaba forzosamente a comunidades enteras (incluso miles de personas) a vivir a cientos de kilómetros de su origen. Estas poblaciones desarraigadas se denominaban:',
    options: [
      'Hatun Runas.',
      'Yanaconas.',
      'Mitmaqkuna (Mitimaes).',
      'Piñas.',
      'Curacas.',
    ],
    correctAnswer: 2,
    explanation:
        'La institución de los Mitimaes servía para quebrar rebeliones (dispersando pueblos belicosos), colonizar zonas despobladas para aumentar la frontera agrícola, y asimilar culturalmente a los recién conquistados.',
  ),
  Question(
    id: 'cs_q215',
    topicId: 'cs_t2',
    text:
        'El Imperio Incaico, pese a su poderío, mantenía un grupo social en el estrato más bajo, conformado por prisioneros de guerra de las etnias más rebeldes y belicosas (ej. Cañaris, Chachapoyas). Fueron convertidos en esclavos del Estado, destinados a los trabajos más duros (como en los cocales de ceja de selva). Este grupo se denominaba:',
    options: [
      'Yanas.',
      'Piñacuna (Piñas).',
      'Acllas.',
      'Mitayos.',
      'Chasquis.',
    ],
    correctAnswer: 1,
    explanation:
        'Los Piñas (o Piñacunas) perdían todo derecho y protección del Ayllu. Eran el escalón más bajo (esclavos) y su condición era hereditaria, usados generalmente en zonas cálidas insalubres.',
  ),
  Question(
    id: 'cs_q216',
    topicId: 'cs_t2',
    text:
        "Los 'Yanaconas' eran servidores perpetuos de la nobleza incaica. A diferencia del Hatun Runa común, el Yanacona se caracterizaba socialmente porque:",
    options: [
      'Tenía el deber ineludible de cumplir con la Mita en la construcción de caminos.',
      'Había perdido sus vínculos de reciprocidad con su Ayllu originario, dependiendo exclusivamente del Inca o de la panaca a la que servía.',
      'Poseía tierras en propiedad privada absolutas, al igual que los curacas.',
      'Tenía el derecho exclusivo de gobernar las cuatro regiones del imperio (Suyos).',
      'Estaba exento de pagar cualquier tributo, pero debía viajar a España anualmente.',
    ],
    correctAnswer: 1,
    explanation:
        "El Yanacona era un 'desarraigado'. Al no pertenecer a un Ayllu, no participaba en el ayni ni en la minka, no tributaba mita estatal, sino que servía eternamente (y su descendencia) a la élite cusqueña, a cambio de su sustento.",
  ),
  Question(
    id: 'cs_q217',
    topicId: 'cs_t2',
    text:
        'La base de la organización social del Tahuantinsuyo fue el Ayllu, pero administrativamente, para fines de censo y reclutamiento (mita militar), el imperio empleó un sistema de empadronamiento decimal. La máxima unidad civil, equivalente a 10,000 familias (huno), estaba a cargo de un jefe llamado:',
    options: [
      'Purec.',
      'Pisca Camayoc.',
      'Huno Camayoc.',
      'Pachaca Camayoc.',
      'Guaranga Camayoc.',
    ],
    correctAnswer: 2,
    explanation:
        'El sistema decimal facilitaba el control burocrático: Purec (1 familia), Pisca (5), Chunca (10), Pisca Chunca (50), Pachaca (100), Guaranga (1,000) y Huno Camayoc (10,000 familias o tributarios).',
  ),
  Question(
    id: 'cs_q218',
    topicId: 'cs_t2',
    text:
        'En el arte textil inca, existía una indumentaria reservada exclusivamente para el Sapa Inca y la alta nobleza, tejida por las acllas con las fibras más finas (vicuña, alpaca) y adornada con plumas o hilos de oro. ¿Cómo se denominaba a este tejido de élite?',
    options: ['Abasca.', 'Cumbi (Qompi).', 'Uncu.', 'Llauto.', 'Mascapaicha.'],
    correctAnswer: 1,
    explanation:
        'El Cumbi era el tejido de altísima calidad y simetría geométrica (tocapus). En contraste, el tejido burdo y áspero hecho de llama, usado por los hatun runas (pueblo común), se llamaba Abasca.',
  ),
  Question(
    id: 'cs_q219',
    topicId: 'cs_t2',
    text:
        'El Sapa Inca utilizaba múltiples símbolos de poder absoluto. El más importante, que fungía como corona y que el Inca recibía de manos del sumo sacerdote como señal de su estatus divino y gobierno sobre el mundo andino, era:',
    options: [
      'El cetro de oro (Tumi).',
      'Las plumas del cóndor sagrado.',
      'La Mascapaicha roja.',
      'El Llauto de plata pura.',
      'La lanza de chonta selvática.',
    ],
    correctAnswer: 2,
    explanation:
        'La Mascapaicha era una borla de fina lana roja con hilos de oro que pendía sobre la frente del Inca, sujeta al llauto. Era el máximo emblema de poder, equivalente a la corona de los monarcas europeos.',
  ),
  Question(
    id: 'cs_q220',
    topicId: 'cs_t2',
    text:
        'La economía inca carecía de moneda y mercado, pero existió un grupo de navegantes excepcionales en la costa sur que utilizaron primitivas hachuelas de cobre y dominaron el intercambio de larga distancia del preciado Spondylus (Mullu) con el Ecuador precolombino. Esta excepción mercantil correspondió a los señores de:',
    options: [
      'Chan Chan (Chimú).',
      'Chincha.',
      'Cajamarca.',
      'Pachacamac (Ichma).',
      'Wari.',
    ],
    correctAnswer: 1,
    explanation:
        'Los Chinchas conformaron una poderosa red comercial marítima con balsas a vela triangular. El imperio Inca respetó a su curaca (Chinchay Cápac) debido a la tremenda importancia religiosa y logística de su comercio del Mullu (alimento de los dioses).',
  ),
  Question(
    id: 'cs_q221',
    topicId: 'cs_t2',
    text:
        'El Panteón inca era politeísta y animista. Si bien el Sol (Inti) era la deidad oficial del Estado imperial, el dios creador del universo, ordenador del mundo y formador del hombre, de origen anterior a los Incas (culto tiahuanacota) era:',
    options: [
      'Illapa (el Rayo).',
      'Wiracocha (Apu Qun Tiqsi Wiraqucha).',
      'Pachacámac.',
      'Quilla (la Luna).',
      'Pariacaca.',
    ],
    correctAnswer: 1,
    explanation:
        'Wiracocha era la deidad panandina creadora por excelencia. Según el mito, esculpió a los primeros humanos en piedra en Tiahuanaco y ordenó a los astros salir del lago Titicaca, siendo una deidad más abstracta e invisible que el Sol.',
  ),
  Question(
    id: 'cs_q222',
    topicId: 'cs_t2',
    text:
        "Para mantener el control y cohesión del Estado, los Incas permitieron a los pueblos conquistados adorar a sus deidades locales, pero exigían la adoración obligatoria al Dios Sol y enviaban una réplica del ídolo local al Cusco (al Coricancha). El propósito político subyacente de este 'panteón de rehenes' era:",
    options: [
      'Estudiar la composición química de los ídolos de oro.',
      'Destruirlos en ceremonias secretas para humillar a los vencidos.',
      'Asegurar la lealtad de la provincia conquistada, pues amenazaban con dañar o maldecir a su deidad protectora si se rebelaban.',
      'Repartir a los dioses entre las panacas cusqueñas para su protección en las batallas.',
      'Generar un mercado negro de ídolos sagrados.',
    ],
    correctAnswer: 2,
    explanation:
        'Al tener el ídolo principal de la etnia cautivo en el Cusco, el Inca no solo asimilaba el poder espiritual de la nación conquistada, sino que disuadía fuertemente cualquier intento de sedición (chantaje divino).',
  ),
  Question(
    id: 'cs_q223',
    topicId: 'cs_t2',
    text:
        'La arquitectura civil incaica es asombrosamente sismorresistente. Una característica geométrica esencial de los muros incas de sillería (piedras perfectamente encajadas), como los de Sacsayhuamán o el Coricancha, que les otorga esa resistencia a los terremotos, es:',
    options: [
      'El uso masivo de arcilla líquida como pegamento entre las enormes rocas.',
      'La construcción de muros en forma de pirámide invertida.',
      'El uso de grapas de cobre gigantes entre todas las uniones externas.',
      'La forma trapezoidal de puertas, nichos y ventanas, y la inclinación de los muros hacia adentro.',
      'La colocación de ruedas de madera en la base de las piedras angulares.',
    ],
    correctAnswer: 3,
    explanation:
        'La geometría trapezoidal baja el centro de gravedad, y la inclinación de los muros hacia el interior crea un efecto de auto-compresión que absorbe y disipa estupendamente la energía sísmica, sin usar argamasa.',
  ),
  Question(
    id: 'cs_q224',
    topicId: 'cs_t2',
    text:
        'El Sapa Inca Pachacútec no solo conquistó vastos territorios, sino que fue el gran urbanista del Cusco. Decidió reconstruir la ciudad capital dándole mágicamente la forma del animal tutelar de la nobleza andina, que representaba el poder en el Uku Pacha y Kay Pacha. Este animal era:',
    options: [
      'La Serpiente (Amaru).',
      'El Cóndor (Kuntur).',
      'El Puma.',
      'El Llama sagrado.',
      'El Otorongo (Jaguar amazónico).',
    ],
    correctAnswer: 2,
    explanation:
        'El diseño urbano del Cusco imperial representaba el contorno de un puma. La fortaleza de Sacsayhuamán fungía como la cabeza (los muros en zigzag serían sus dientes), y el Coricancha se ubicaba cerca de la cola.',
  ),
  Question(
    id: 'cs_q225',
    topicId: 'cs_t2',
    text:
        'El derecho a la sucesión imperial incaica causó sangrientas guerras civiles (ej. Huáscar y Atahualpa). La regla de sucesión no se basaba estrictamente en la primogenitura (el hijo mayor), sino en:',
    options: [
      'La elección democrática por asamblea popular de los Ayllus.',
      'El derecho divino revelado mediante trances a los adivinos ciegos.',
      'El hijo nacido de esclava capturada, para fortalecer las fronteras.',
      "El principio del 'más capaz' o habilidoso, usualmente elegido entre los hijos del Inca con la Coya (esposa principal), mediante pruebas como el Huarachico.",
      'Un torneo a muerte entre los generales del ejército del Collasuyo.',
    ],
    correctAnswer: 3,
    explanation:
        'El Auqui (príncipe heredero) debía demostrar aptitudes militares, administrativas e inteligencia política. Si el primogénito era inepto, se elegía a otro hijo de la Coya (o incluso de concubinas si destacaba mucho) para asegurar el éxito del Estado.',
  ),
  Question(
    id: 'cs_q226',
    topicId: 'cs_t2',
    text:
        "Los 'Chasquis' eran los veloces corredores y mensajeros del imperio. Su eficiencia radicaba en un sistema de postas. Cuando el Chasqui anunciaba su llegada al siguiente tambo para transferir oralmente el mensaje o entregar el quipu, utilizaba un instrumento sonoro de viento hecho de una caracola marina gigante llamado:",
    options: ['Antara.', 'Pututu.', 'Quena de hueso.', 'Zampoña.', 'Tinya.'],
    correctAnswer: 1,
    explanation:
        'El Pututu, elaborado del caracol marino Spondylus o Strombus, emitía un sonido profundo y potente que alertaba al chasqui de relevo para que estuviera listo en la posta, evitando perder segundos en la entrega del mensaje.',
  ),
  Question(
    id: 'cs_q227',
    topicId: 'cs_t2',
    text:
        'La ingeniería agrícola incaica enfrentó el desafío de la accidentada topografía andina y la escasez de tierras planas irrigables. La principal solución tecnológica para expandir masivamente la frontera agrícola y evitar la erosión del suelo en las laderas de los cerros fue:',
    options: [
      'La construcción de islas flotantes artificiales gigantes en los lagos andinos.',
      'El cultivo hidropónico sin tierra mediante canales de piedra colgantes.',
      'La deforestación total de los bosques para crear llanuras inmensas.',
      "La construcción de 'Andenes' (terrazas escalonadas de piedra) provistas de canales de riego y drenaje.",
      'El cultivo subterráneo en cuevas acondicionadas térmicamente.',
    ],
    correctAnswer: 3,
    explanation:
        'Los andenes permitieron aprovechar la pendiente, retener el agua (evitando la erosión torrencial) y crear microclimas (al absorber el calor del sol en sus piedras). Pisac y Moray son ejemplos cumbres de esta biotecnología andina.',
  ),
  Question(
    id: 'cs_q228',
    topicId: 'cs_t2',
    text:
        'Para conservar excedentes alimenticios durante años en las Colcas (y soportar sequías o alimentar a la milicia en campaña), los antiguos peruanos perfeccionaron una técnica milenaria de liofilización natural y deshidratación, aprovechando el fuerte contraste térmico del altiplano (sol ardiente de día, helada nocturna). El producto más icónico y vital de este proceso es:',
    options: [
      'La chicha de jora fermentada al vacío.',
      'El Chuño (papa deshidratada) y el Charqui (carne salada seca).',
      'El maíz morado tostado.',
      'El ceviche curado en salitre.',
      'El cuy macerado en manteca de llama.',
    ],
    correctAnswer: 1,
    explanation:
        'La liofilización natural del chuño (y del charqui) elimina el agua mediante la congelación nocturna extrema y la evaporación diurna. Esto permite almacenar carbohidratos y proteínas durante años sin que se pudran, piedra angular de la logística incaica.',
  ),
  Question(
    id: 'cs_q229',
    topicId: 'cs_t2',
    text:
        "En la economía vertical andina (Control de Pisos Ecológicos, teoría de John Murra), las etnias no buscaban concentrar grandes bloques territoriales contiguos, sino poseer 'archipiélagos' de tierras en diferentes altitudes (costa, quechua, puna, selva alta). El objetivo estratégico de esta dispersión era:",
    options: [
      'Escapar del control del tributario del Imperio Incaico dividiendo a la familia.',
      'Asegurar el control de canteras de oro en todos los pisos.',
      'Tener acceso directo y autosuficiente a una diversidad de productos alimenticios (pescado, papa, chuño, maíz, coca) sin depender de un mercado comercial formal.',
      'Preparar a la población para sobrevivir al hundimiento de la cordillera.',
      'Garantizar que todos aprendieran diferentes idiomas para comerciar.',
    ],
    correctAnswer: 2,
    explanation:
        'Al tener colonos (mitimaes) en la puna obtenían carne y chuño; en el valle templado, maíz; en la selva, madera y coca. Todo volvía al núcleo central (autosuficiencia), mitigando el riesgo de perder una cosecha por heladas y anulando la necesidad de dinero.',
  ),
  Question(
    id: 'cs_q230',
    topicId: 'cs_t2',
    text:
        "El ordenamiento judicial y legal en el Imperio Incaico era draconiano y ejemplar. Las normas morales universales se sintetizaban en tres axiomas fundamentales ('Ama Sua, Ama Llulla, Ama Quella'). Si un funcionario del Estado ('Curaca') robaba bienes de las Colcas, su castigo difería del impuesto a un hombre común ('Hatun Runa') porque:",
    options: [
      'El curaca era perdonado por su estatus divino y se le obligaba a rezar.',
      'Al tener mayor rango y responsabilidad moral, la ley inca castigaba al funcionario de manera mucho más severa y atroz (a menudo con la muerte y destrucción de su linaje) frente a la misma falta cometida por un plebeyo.',
      'El hombre común era sentenciado a muerte, pero el noble solo pagaba una multa en oro.',
      'La nobleza estaba exenta de cumplir las leyes gracias a un fuero especial otorgado por el Sol.',
      'Ambos eran enviados al destierro amazónico por 5 años.',
    ],
    correctAnswer: 1,
    explanation:
        'La jurisprudencia incaica era implacable con la corrupción. Exigía mayor rectitud a quienes tenían mayor educación y poder. El robo estatal cometido por un funcionario era alta traición al Inca y se castigaba inexorablemente con la pena capital.',
  ),
  Question(
    id: 'cs_q231',
    topicId: 'cs_t2',
    text:
        "El 'Camayoc' era un sufijo que denotaba especialización. En el complejo engranaje productivo y redistributivo del imperio, existían funcionarios encargados de contabilizar meticulosamente y administrar el depósito de las inmensas reservas de ropa y alimento del Estado. A este administrador se le conocía como:",
    options: [
      'Collca Camayoc.',
      'Llacta Camayoc.',
      'Tocricuc.',
      'Chasqui Camayoc.',
      'Ayllu Camayoc.',
    ],
    correctAnswer: 0,
    explanation:
        'El Collca Camayoc era el administrador (almacenero) estatal de las Colcas. Su honestidad y capacidad estadística garantizaban la supervivencia del sistema de redistribución frente a hambrunas.',
  ),
  Question(
    id: 'cs_q232',
    topicId: 'cs_t2',
    text:
        'En el mundo precolombino peruano, antes del surgimiento hegemónico del Tahuantinsuyo, hubo un imperio andino anterior que logró la primera unificación panandina (Horizonte Medio), expandiendo el modelo de ciudad planificada, el uso de andenes a gran escala y una extensa red de caminos de los que se valdrían posteriormente los incas. Este imperio fue:',
    options: [
      'Imperio Chimú.',
      'Imperio Wari.',
      'Reino Chanca.',
      'Federación Moche.',
      'Cultura Paracas.',
    ],
    correctAnswer: 1,
    explanation:
        'Wari (Huari) fue el Primer Imperio Panandino (siglos VII - XII d.C.). Los incas asimilaron de ellos la construcción de caminos (Qhapaq Ñan primitivo), la planificación urbana (centros administrativos ortogonales como Pikillaqta) y la ingeniería de andenes.',
  ),
  Question(
    id: 'cs_q233',
    topicId: 'cs_t2',
    text:
        'El mítico enfrentamiento que marca el inicio del Imperio histórico Inca y la gran expansión desde un curacazgo regional hacia el Tahuantinsuyo, fue la encarnizada batalla de Yahuarpampa, donde las tropas cuzqueñas (lideradas por Cusi Yupanqui) derrotaron definitivamente a su más feroz enemigo y rival geopolítico regional:',
    options: [
      'Los Collas.',
      'Los Chancas.',
      'Los Chimús.',
      'Los Huancas.',
      'Los Chachapoyas.',
    ],
    correctAnswer: 1,
    explanation:
        'La invasión de la confederación Chanca (de Andahuaylas) al Cusco casi destruye a la etnia inca. La milagrosa victoria de Cusi Yupanqui (quien asumió el nombre de Pachacútec tras la batalla) originó la fase imperialista y fundó el Tahuantinsuyo.',
  ),
  Question(
    id: 'cs_q234',
    topicId: 'cs_t2',
    text:
        'El oráculo de Pachacámac, deidad de los terremotos y del mar, gozaba de un prestigio continental tan grande en la costa central que incluso el poderoso ejército incaico invasor no se atrevió a destruirlo, optando por:',
    options: [
      'Exterminar a sus sacerdotes en secreto mediante envenenamiento.',
      'Destruir la ciudad y obligar a construir el santuario del Titicaca.',
      'Respetar profundamente el oráculo, asimilarlo a la religión estatal construyendo un Templo del Sol y un Acllahuasi a su lado (sincretismo político), logrando una alianza con los Ychsmas.',
      'Exigir tributo en humanos masivamente para el Apu Ausangate.',
      'Bloquear las rutas de agua para asediar el santuario de manera indirecta.',
    ],
    correctAnswer: 2,
    explanation:
        'Pachacámac era demasiado temido y venerado (panandino). Pachacútec y Túpac Yupanqui aplicaron una brillante estrategia diplomática-religiosa: asimilar la huaca y superponer la arquitectura inca (El Templo del Sol y Mamaconas) pacificando la costa sin disparar una flecha.',
  ),
  Question(
    id: 'cs_q235',
    topicId: 'cs_t2',
    text:
        'La caída de la capital imperial del Chimú, la formidable metrópolis de barro de Chan Chan, ante las huestes incaicas lideradas por el auqui Túpac Yupanqui (enviado de Pachacútec), no se logró mediante un asalto frontal a sus gruesas murallas de adobe, sino a través de un asedio logístico magistral que consistió en:',
    options: [
      'Lanzar fuego incendiario griego contra los techos de paja secos de Chan Chan.',
      'Cortar el suministro vital de agua desviando las bocatomas y acueductos en la parte alta de la sierra, rindiendo de sed a la élite costeña en pleno desierto.',
      'Excavar un túnel subterráneo desde los andes hasta el centro de la ciudad.',
      'Sobornar con oro puro al gran Minchancaman para que entregara la corona chimú.',
      'Usar catapultas de bronce diseñadas por prisioneros extranjeros.',
    ],
    correctAnswer: 1,
    explanation:
        'La debilidad estratégica de la costa es su dependencia extrema de los ríos (agua de la sierra). Los incas simplemente tomaron las partes altas de los valles del Moche y Chicama, bloquearon o desviaron los canales que irrigaban Chan Chan, forzando la rendición incondicional del Chimú Cápac.',
  ),
  Question(
    id: 'cs_q236',
    topicId: 'cs_t2',
    text:
        "Un aspecto central del derecho penal y control poblacional en el incanato eran los castigos corporales ejecutados en los 'Sancahuasis' o 'Zancahuasis'. Este lugar lúgubre, propio de una tiranía militar, consistía en:",
    options: [
      'Prisiones oscuras subterráneas llenas de animales venenosos, felinos hambrientos y reptiles, donde se lanzaba a los rebeldes y traidores para que los dioses decidieran su destino.',
      'Centros de tortura pública en plazas mediante la hoguera.',
      'El destierro en la cima de glaciares (apu) sin comida ni ropa.',
      'Un asilo de reeducación psicológica y trabajo forzoso agrícola.',
      'Barcos prisiones que navegaban a la deriva en el Titicaca.',
    ],
    correctAnswer: 0,
    explanation:
        "El Sancahuasi ('casa de las espinas') era un calabozo de castigo y prueba ordálica. Si un prisionero rebelde sobrevivía a las alimañas (pumas, víboras) durante unos días, se interpretaba como un indulto divino; caso contrario, era devorado.",
  ),
  Question(
    id: 'cs_q237',
    topicId: 'cs_t2',
    text:
        'En el Chinchaysuyo (sierra norte de Perú y Ecuador), las etnias dominadas (como los Cañaris, Chachapoyas y Huancas) mostraron un férreo resentimiento hacia el dominio imperial cusqueño. Durante la invasión hispana, el accionar político-militar de estas etnias andinas fue determinante, ya que:',
    options: [
      'Cometieron suicidio masivo al enterarse de la muerte del Inca Atahualpa.',
      'Se aliaron militarmente, brindaron logística y sirvieron como miles de tropas auxiliares para Francisco Pizarro en su afán de liberarse del yugo incaico y destruir al Cusco.',
      'Declararon la guerra santa contra ambos bandos (Incas y españoles) y formaron un tercer frente impenetrable.',
      'Huyeron en masa hacia la selva brasileña perdiéndose en el anonimato.',
      'Protegieron la vida de Manco Inca y financiaron el Estado Neo-Inca de Vilcabamba.',
    ],
    correctAnswer: 1,
    explanation:
        "La historia tradicional oculta que la conquista no la hicieron solo '168 españoles'. Fue una rebelión andina masiva contra la hegemonía inca (guerra de liberación local). Pizarro triunfó gracias al apoyo incondicional de los miles de guerreros Huancas, Cañaris, Chachapoyas, etc.",
  ),
  Question(
    id: 'cs_q238',
    topicId: 'cs_t2',
    text:
        "La ceremonia del 'Huarachico' (Warachikuy) era un rito de iniciación fundamental en la vida social y religiosa de la élite de sangre cusqueña (los Orejones). Su objetivo doctrinario era:",
    options: [
      'Evaluar la pureza de la sangre extirpando a los jóvenes mestizos del Cusco.',
      'Obligar a las jóvenes acllas a elegir un esposo de la élite guerrera.',
      'Someter a los jóvenes nobles a rigurosas pruebas de valor físico, ayuno y destreza militar para certificar su paso a la edad adulta y su aptitud para ser funcionarios o generales del Imperio.',
      'Sacrificar anualmente a 100 jóvenes varones en honor al Apu Huanacaure.',
      'Probar la resistencia al veneno de los hijos ilegítimos del Inca.',
    ],
    correctAnswer: 2,
    explanation:
        'En el Huarachico, los príncipes demostraban, tras duras pruebas (carreras de montaña, combate, hambre, vigilancia), ser dignos de vestir la Huara (taparrabos de varón adulto) y ser horadados en las orejas, ingresando a la casta militar-administrativa imperial.',
  ),
  Question(
    id: 'cs_q239',
    topicId: 'cs_t2',
    text:
        'El Imperio Incaico, pese a no poseer escritura ideográfica ni fonética clásica (como los Mayas), desarrolló un arte de registro iconográfico. Los cronistas mencionan la existencia de unas tablas o mantos pintados que narraban los grandes hechos de los Incas y genealogías, guardadas celosamente en Puquincancha, conocidos como:',
    options: [
      'Quipus bicolores.',
      'Tocapus labrados.',
      'Qilcas (Quilcas) pintadas.',
      'Kerus imperiales.',
      'Estelas líticas cuzqueñas.',
    ],
    correctAnswer: 2,
    explanation:
        "Las Qilcas (Kilkhas o tablas pintadas) fungían como los 'archivos pictográficos' de la historia incaica. Estaban custodiadas en el Puquincancha y se dice que el Inca Pachacútec ordenó pintar la historia en ellas; lamentablemente fueron destruidas en un incendio durante la conquista.",
  ),
  Question(
    id: 'cs_q240',
    topicId: 'cs_t2',
    text:
        'Al producirse la crisis de sucesión a la muerte de Huayna Cápac, Atahualpa sustentó su rebelión en el poder militar de sus ejércitos acantonados en Quito. Sus generales más brillantes, verdaderos artífices de las victorias contra Huáscar y de la toma del Cusco (y posterior resistencia a Pizarro), fueron:',
    options: [
      'Manco Inca, Sayri Túpac y Túpac Amaru I.',
      'Rumiñahui, Quisquis y Calcuchímac.',
      'Ollantay, Rumi Ñahui y Taulichusco.',
      'Topa Inca Yupanqui, Cahuide y Cusi Huallpa.',
      'Pachacútec, Yahuar Huaca y Sinchi Roca.',
    ],
    correctAnswer: 1,
    explanation:
        'Quisquis y Calcuchímac lideraron los ejércitos atahualpistas veteranos hacia el sur, destruyendo el bando de Huáscar y las panacas del Cusco. Rumiñahui mantuvo la defensa y posterior resistencia heroica en Quito.',
  ),
  Question(
    id: 'cs_q241',
    topicId: 'cs_t2',
    text:
        'El Inti Raymi (Fiesta del Sol) marcaba el solsticio de invierno austral (junio) en el calendario inca. Además del agradecimiento ritual, su inmensa utilidad sociopolítica para el Estado radicaba en que era el momento del año en el que:',
    options: [
      'Se ejecutaba públicamente a los reyes extranjeros para enviar sus cabezas a provincias.',
      'Se declaraban anuladas y perdonadas todas las deudas de mita atrasada de los pueblos conquistados.',
      'Los curacas y élites de todos los suyos acudían obligatoriamente al Cusco a renovar su sumisión al Inca, entregando los tributos recolectados y recibiendo la redistribución oficial del imperio.',
      'El Sapa Inca abdicaba temporalmente el trono en favor del Sumo Sacerdote.',
      'Se prohibía el consumo de chicha para fomentar la ascética militar.',
    ],
    correctAnswer: 2,
    explanation:
        "El Inti Raymi era la 'cumbre' política anual. Todos los señores (curacas) del inmenso imperio convergían en la capital para rendir cuentas (tributos) al Inca, renovar pactos políticos y presenciar el poder hegemónico irrefutable del Estado central.",
  ),
  Question(
    id: 'cs_q242',
    topicId: 'cs_t2',
    text:
        'La cerámica incaica tiene un estilo utilitario, severo y equilibrado (menos figurativo que la mochica). La forma más representativa y distribuida masivamente por todo el imperio como símbolo del Estado es el cántaro de cuello estrecho, base cónica y dos asas laterales utilizado para macerar, almacenar y transportar grandes volúmenes de chicha, conocido como:',
    options: [
      "Kero (Q'ero).",
      'Puchka.',
      'Urpu (o Aríbalo).',
      'Huaco retrato.',
      'Píthos andino.',
    ],
    correctAnswer: 2,
    explanation:
        'El Urpu (popularizado por los españoles como Aríbalo por su parecido griego) era esencial en las ceremonias estatales. Su base en punta (cónica) permitía clavarlo en la arena o la tierra suelta sin que cayera, ideal para servir la chicha basculándolo.',
  ),
  Question(
    id: 'cs_q243',
    topicId: 'cs_t2',
    text:
        "En los estertores del Imperio Incaico, tras el asesinato de Atahualpa, los españoles nombraron incas 'títeres'. Uno de ellos, al darse cuenta del engaño de que los hispanos no eran 'viracochas' libertadores sino saqueadores invasores, organizó la Gran Rebelión de 1536 asediando heroicamente las ciudades del Cusco y Lima. Este monarca fundó luego la dinastía resistente en la ceja de selva (Vilcabamba). Su nombre es:",
    options: [
      'Manco Inca (o Manco II).',
      'Túpac Amaru II.',
      'Sayri Túpac.',
      'Titu Cusi Yupanqui.',
      'Huáscar.',
    ],
    correctAnswer: 0,
    explanation:
        'Manco Inca, inicialmente aliado de Pizarro, escapó del Cusco, reunió un ejército de cientos de miles de guerreros y cercó a Hernando Pizarro en el Cusco y envió a Quizo Yupanqui a cercar Lima, casi expulsando a los invasores de los Andes.',
  ),
  Question(
    id: 'cs_q244',
    topicId: 'cs_t2',
    text:
        "Para mantener en pie al ejército y a los mitayos en zonas yugulares agrestes, los incas utilizaron una tecnología de construcción de puentes. El famoso puente de 'Q'eswachaka' en el río Apurímac, que se renueva anualmente hasta hoy, ejemplifica los puentes incas hechos bajo el sistema de minka consistentes en:",
    options: [
      'Arcos de medio punto de argamasa romana que resistían aluviones.',
      'Puentes colgantes formados por gruesos cables trenzados de fibra vegetal (Ichu o maguey) anclados a fuertes bastiones de piedra en ambas riberas.',
      'Grandes vigas de caoba traídas de la Amazonía sostenidas por pilares de plomo.',
      'Puentes flotantes usando pieles enteras infladas de llamas muertas.',
      'Túneles subfluviales excavados manualmente debajo del lecho del río.',
    ],
    correctAnswer: 1,
    explanation:
        'La metalurgia inca no conocía el hierro ni el acero para vigas largas. Usaron magistralmente las fibras vegetales altoandinas (Ichu pajonal) para tejer trenzas (sogas) de gran resistencia a la tensión (cables tensores), creando los puentes colgantes peatonales.',
  ),
  Question(
    id: 'cs_q245',
    topicId: 'cs_t2',
    text:
        'Según el mito fundacional andino recopilado por el cronista Juan de Betanzos, el origen de la etnia Inca proviene de los cuatro hermanos Ayar, salidos de la cueva de Pacaritambo. El vencedor de la saga mítica, poseedor de la barreta de oro y de atributos fundacionales civilizatorios en el Cusco (luego bautizado Manco Cápac), fue el hermano:',
    options: [
      'Ayar Uchu.',
      'Ayar Cachi.',
      'Ayar Auca.',
      'Ayar Manco.',
      'Ayar Huasi.',
    ],
    correctAnswer: 3,
    explanation:
        'Ayar Manco, junto a su esposa Mama Ocllo (o Mama Huaco en otras versiones más guerreras), es el caudillo triunfante que funda la capital hundiendo la barreta y se convierte en el legendario Manco Cápac.',
  ),
  Question(
    id: 'cs_q246',
    topicId: 'cs_t2',
    text:
        'El uso de la coca (Erythroxylum coca) en el incanato no era un vicio popular recreativo, sino un producto estrictamente monopolizado por el Estado. A nivel social y económico en el Tahuantinsuyo, las hojas de coca tenían el estatus de:',
    options: [
      'Moneda de cambio obligatoria para pagar crímenes de sangre entre hatun runas.',
      'Alimento básico de engorde para los chasquis por sus carbohidratos.',
      'Planta de consumo restringido, sagrada y diplomática, reservada a la nobleza, a ritos religiosos del Sol y entregada esporádicamente como premio en redistribución a élites guerreras.',
      'Material de construcción para los techos impermeables en Machu Picchu.',
      'Herramienta agrícola para teñir la ropa militar de negro.',
    ],
    correctAnswer: 2,
    explanation:
        "La coca era un cultivo 'suntuario' y ritual controlado por el Sapa Inca. Su valor simbólico (para pagos a la tierra/apus) y estimulante la hacían un bien de lujo preciado (como el mullu y el cumbi) usado para sellar alianzas políticas (redistribución incaica).",
  ),
  Question(
    id: 'cs_q247',
    topicId: 'cs_t2',
    text:
        "El derecho penal inca aplicaba la 'Responsabilidad Colectiva' para crímenes gravísimos, como el intento de magnicidio o la rebelión armada total contra el Sapa Inca. Esta figura penal consistía en:",
    options: [
      'Perdonar al culpable y multar económicamente a su ciudad entera.',
      'Ejecutar exclusivamente a todos los primogénitos varones del pueblo insurrecto.',
      'Castigar con la muerte y arrasamiento no solo al instigador, sino aniquilando a su familia, su panaca, su ayllu entero y su pueblo (tierra salada) para extirpar la raíz de la traición.',
      'Despojar a la ciudad de su agua potable obligándolos a migrar pacíficamente a la selva.',
      'Imponer un año de silencio total a los habitantes como acto de luto y arrepentimiento.',
    ],
    correctAnswer: 2,
    explanation:
        'El concepto de rebelión no se veía como un acto individual, sino colectivo. Exterminar al ayllu del traidor evitaba futuras venganzas de sangre y servía de escarmiento psicológico de terror inmenso para el resto del imperio.',
  ),
  Question(
    id: 'cs_q248',
    topicId: 'cs_t2',
    text:
        'En los pisos altitudinales andinos, el cultivo de la papa (Solanum tuberosum) fue el sustento calórico de la plebe andina (Hatun runa). ¿Por qué razón agronómica el maíz, siendo más sabroso y base de la chicha, no reemplazó masivamente a la papa en la puna andina?',
    options: [
      'El Estado inca prohibió su cultivo por orden de los curacas locales envidiosos.',
      'El maíz es extremadamente susceptible a las fuertes heladas (bajas temperaturas) y requiere más agua y cuidado (terrazas), mientras que la papa resiste altitudes mayores a los 3800 msnm, el frío severo y suelos pobres.',
      'Los insectos de la altura devoraban sistemáticamente las semillas del maíz blanco.',
      'El chuño de maíz resultaba tóxico para el sistema digestivo humano.',
      'La cosmovisión religiosa prohibía sembrar semillas amarillas cerca del cielo.',
    ],
    correctAnswer: 1,
    explanation:
        'El factor limitante en los Andes es la isoterma de congelamiento. El maíz (planta mesotérmica) no prospera bien a alturas elevadas y heladas. La papa (y otros tubérculos como oca, olluco) tiene una plasticidad climática inmensa y soporta el crudo clima de la puna.',
  ),
  Question(
    id: 'cs_q249',
    topicId: 'cs_t2',
    text:
        'El Sapa Inca reinante, al fundar su propio linaje, no heredaba las inmensas riquezas (palacios, siervos, tierras) de su predecesor, pues estas pasaban íntegramente a ser propiedad inalienable de:',
    options: [
      'El nuevo Inca, quien confiscaba todo.',
      'Los curacas regionales de las tierras conquistadas.',
      'La Panaca (familia real ampliada) del Inca fallecido, quienes usaban esas riquezas materiales para adorar, alimentar y servir a la momia de su fundador por la eternidad.',
      'El templo mayor del Coricancha (monopolio de la casta sacerdotal de por vida).',
      'Las arcas públicas del gobierno para repartirlas al pueblo en épocas de sequía.',
    ],
    correctAnswer: 2,
    explanation:
        'En la sucesión inca (herencia partida), el heredero tomaba el poder político y militar absoluto, pero debía conquistar sus propias tierras para enriquecer su propio estado. Las tierras y siervos del Inca muerto se los quedaba su Panaca (sus otros hijos y deudos) para rendir culto perpetuo a su cuerpo embalsamado (el mallqui).',
  ),
  Question(
    id: 'cs_q250',
    topicId: 'cs_t2',
    text:
        'La última heroica resistencia estatal Inca, amparada en la abrupta geografía amazónica y montañosa, tuvo lugar en la región de Vilcabamba (Neo-Estado Inca) que perduró casi 40 años tras la invasión de 1532. El último monarca inca (Sapa Inca) capturado en batalla y decapitado en la plaza del Cusco en 1572 por orden del virrey Toledo, extinguiendo la resistencia oficial andina, fue:',
    options: [
      'Manco Inca.',
      'Titu Cusi Yupanqui.',
      'Sayri Túpac.',
      'Túpac Amaru I.',
      'Túpac Amaru II (José Gabriel Condorcanqui).',
    ],
    correctAnswer: 3,
    explanation:
        'Túpac Amaru I fue el último inca de la dinastía de Vilcabamba. Su ejecución por el Francisco de Toledo buscó cortar de raíz cualquier intento legal o mesiánico de restauración del Tahuantinsuyo (dando origen al mito del Inkarri).',
  ),
  Question(
    id: 'cs_q251',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 1)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q252',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 2)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q253',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 3)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q254',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 4)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q255',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 5)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q256',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 6)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q257',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 7)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q258',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 8)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q259',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 9)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q260',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 10)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q261',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 11)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q262',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 12)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q263',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 13)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q264',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 14)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q265',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 15)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q266',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 16)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q267',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 17)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q268',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 18)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q269',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 19)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q270',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 20)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q271',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 21)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q272',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 22)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q273',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 23)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q274',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 24)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q275',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 25)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q276',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 26)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q277',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 27)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q278',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 28)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q279',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 29)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q280',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 30)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q281',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 31)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q282',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 32)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q283',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 33)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q284',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 34)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q285',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 35)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q286',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 36)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q287',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 37)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q288',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 38)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q289',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 39)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q290',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 40)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q291',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 41)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q292',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 42)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q293',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 43)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q294',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 44)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q295',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 45)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q296',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 46)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q297',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 47)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q298',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 48)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q299',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 49)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q300',
    topicId: 'cs_t2',
    text:
        'FIJA TAHUANTINSUYO: Trabajo obligatorio en beneficio del Estado Inca: (Var 50)',
    options: ['Mita', 'Ayni', 'Minca', 'Chunca'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q301',
    topicId: 'cs_t3',
    text:
        'La Ley N° 26834 constituye el marco jurídico fundamental para la conservación en el Perú. Según su articulado, las Áreas Naturales Protegidas (ANP) se dividen en dos grandes bloques según el nivel de intervención humana permitida. Estos dos grandes bloques son:',
    options: [
      'Áreas de dominio público y Áreas de dominio privado.',
      'Áreas de reserva minera y Áreas de reserva forestal.',
      'Áreas de uso directo y Áreas de uso indirecto.',
      'Áreas intangibles absolutas y Áreas de libre mercado.',
      'Áreas de protección militar y Áreas de turismo recreacional.',
    ],
    correctAnswer: 2,
    explanation:
        'La Ley 26834 divide a las ANP estrictamente en Áreas de Uso Indirecto (intangibles, no se extraen recursos) y Áreas de Uso Directo (aprovechamiento regulado de recursos renovables).',
  ),
  Question(
    id: 'cs_q302',
    topicId: 'cs_t3',
    text:
        "En el marco del Sistema Nacional de Áreas Naturales Protegidas por el Estado (SINANPE), las 'Áreas de Uso Indirecto' tienen un carácter de intangibilidad. ¿Cuál de las siguientes actividades está jurídicamente permitida dentro de estas áreas?",
    options: [
      'La extracción maderera de especies no amenazadas.',
      'La minería artesanal e informal con dragas superficiales.',
      'La caza de subsistencia por parte de colonos recientes.',
      'La investigación científica no manipulativa, la educación y el turismo regulado.',
      'La construcción de carreteras departamentales de asfalto.',
    ],
    correctAnswer: 3,
    explanation:
        'En las áreas de uso indirecto (Parques, Santuarios) está absolutamente prohibida la extracción comercial. Solo se permite investigación, turismo y recreación que no modifiquen el ecosistema.',
  ),
  Question(
    id: 'cs_q303',
    topicId: 'cs_t3',
    text:
        'Un operativo policial ecológico (DIRMEAMB) detecta a pobladores realizando tala comercial de caoba dentro del Parque Nacional del Manu. Al ser intervenidos, alegan que poseen un permiso del municipio distrital. Legalmente, el operativo de interdicción procede porque:',
    options: [
      'El municipio no cobró los tributos forestales correspondientes.',
      'La caoba solo puede ser talada por empresas transnacionales.',
      "Los Parques Nacionales son áreas de 'Uso Indirecto' (intangibles), donde la extracción de recursos naturales está prohibida independientemente de cualquier permiso local.",
      'Debieron tramitar el permiso ante el Ministerio de Energía y Minas.',
      'El Parque Nacional del Manu es una propiedad privada extranjera.',
    ],
    correctAnswer: 2,
    explanation:
        'Un Parque Nacional es intangible. Ni siquiera las municipalidades o gobiernos regionales pueden autorizar actividades extractivas madereras o mineras dentro de sus límites.',
  ),
  Question(
    id: 'cs_q304',
    topicId: 'cs_t3',
    text:
        'El ente rector del Estado peruano, adscrito al Ministerio del Ambiente (MINAM), encargado de dirigir técnica y normativamente el SINANPE, gestionar las áreas de administración nacional y emitir resoluciones sancionadoras es el:',
    options: ['OSINFOR', 'SERNANP', 'ANA', 'OEFA', 'SENACE'],
    correctAnswer: 1,
    explanation:
        'El Servicio Nacional de Áreas Naturales Protegidas por el Estado (SERNANP) es la autoridad técnico-normativa a nivel nacional del SINANPE.',
  ),
  Question(
    id: 'cs_q305',
    topicId: 'cs_t3',
    text:
        "A diferencia de los Parques Nacionales, existen categorías en el SINANPE denominadas 'Áreas de Uso Directo', donde el Estado permite el aprovechamiento de la flora y fauna silvestre. Sin embargo, para que esta extracción sea legal, ¿cuál es el requisito técnico indispensable exigido por la ley?",
    options: [
      'El pago de diezmos a la Iglesia Católica local.',
      'La aprobación de un Plan de Manejo sustentable por parte de la autoridad competente.',
      'El uso exclusivo de explosivos y maquinaria pesada.',
      'La afiliación obligatoria a un partido político regional.',
      'Que los recursos extraídos sean exportados en su totalidad.',
    ],
    correctAnswer: 1,
    explanation:
        'En las áreas de uso directo (como las Reservas Nacionales), las poblaciones locales pueden extraer recursos (pesca, recolección) únicamente si existe un Plan de Manejo aprobado que garantice la sostenibilidad.',
  ),
  Question(
    id: 'cs_q306',
    topicId: 'cs_t3',
    text:
        'Los Parques Nacionales protegen la integridad ecológica de uno o más ecosistemas representativos, asociaciones de flora y fauna silvestre, y paisajes de gran belleza. Un ejemplo clásico de esta categoría, que protege la diversidad altitudinal de la Cordillera Blanca en Áncash, es:',
    options: [
      'Parque Nacional Bahuaja Sonene.',
      'Parque Nacional del Río Abiseo.',
      'Parque Nacional Huascarán.',
      'Parque Nacional Yanachaga Chemillén.',
      'Parque Nacional Otishi.',
    ],
    correctAnswer: 2,
    explanation:
        'El Parque Nacional Huascarán protege la ecorregión de la Puna y los glaciares tropicales de la Cordillera Blanca, siendo el parque de alta montaña más representativo del país.',
  ),
  Question(
    id: 'cs_q307',
    topicId: 'cs_t3',
    text:
        "Existe una categoría intangible ('Uso Indirecto') diseñada para proteger con carácter de inviolable espacios geográficos que contienen ecosistemas singulares o una especie específica (flora o fauna) de interés científico. Por ejemplo, los manglares en Tumbes o el bosque de rocas en Pasco. ¿A qué categoría nos referimos?",
    options: [
      'Santuario Nacional.',
      'Coto de Caza.',
      'Bosque de Protección.',
      'Reserva Paisajística.',
      'Refugio de Vida Silvestre.',
    ],
    correctAnswer: 0,
    explanation:
        'Los Santuarios Nacionales protegen con carácter intangible el hábitat de una especie endémica (ej. Santuario Nacional del Ampay) o formaciones geológicas notables (ej. Santuario Nacional de Huayllay).',
  ),
  Question(
    id: 'cs_q308',
    topicId: 'cs_t3',
    text:
        "Los 'Santuarios Históricos' son áreas de Uso Indirecto (intangibles) que resguardan espacios vinculados a sucesos gloriosos de nuestra historia nacional o albergan extraordinario patrimonio arqueológico monumental inmerso en la naturaleza. ¿Cuál de los siguientes no es un Santuario Histórico?",
    options: [
      'Santuario Histórico de Machu Picchu.',
      'Santuario Histórico de Chacamarca.',
      'Santuario Histórico de la Pampa de Ayacucho.',
      'Santuario Histórico del Bosque de Pómac.',
      'Santuario Nacional de Megantoni.',
    ],
    correctAnswer: 4,
    explanation:
        'Megantoni es un Santuario *Nacional* (protege ecosistemas naturales intocados en Cusco), no un Santuario *Histórico* (vinculado a eventos patrióticos o ruinas específicas).',
  ),
  Question(
    id: 'cs_q309',
    topicId: 'cs_t3',
    text:
        'En el departamento de Junín, la planicie andina donde se desarrolló una de las batallas determinantes por la independencia del Perú en 1824, está protegida por el Estado bajo la categoría de Santuario Histórico para evitar su urbanización o destrucción. Nos referimos al:',
    options: [
      'Santuario Histórico de Ayacucho.',
      'Santuario Histórico de Chacamarca.',
      'Santuario Histórico de la Angostura.',
      'Santuario Histórico de Tarapacá.',
      'Santuario Histórico de Junín.',
    ],
    correctAnswer: 1,
    explanation:
        'El Santuario Histórico de Chacamarca protege el campo de batalla de Junín, siendo un área intangible destinada a preservar la memoria de la gesta emancipadora.',
  ),
  Question(
    id: 'cs_q310',
    topicId: 'cs_t3',
    text:
        "Las 'Reservas Nacionales' son áreas de Uso Directo destinadas a la conservación de la diversidad biológica y la utilización sustentable de los recursos de flora y fauna silvestre (acuática o terrestre). La reserva nacional marítimo-costera más famosa, creada para proteger aves guaneras, lobos marinos y ecosistemas marinos del sur chico es:",
    options: [
      'Reserva Nacional Pacaya Samiria.',
      'Reserva Nacional Tambopata.',
      'Reserva Nacional de Paracas.',
      'Reserva Nacional Pampa Galeras.',
      'Reserva Nacional Calipuy.',
    ],
    correctAnswer: 2,
    explanation:
        'La Reserva Nacional de Paracas (Ica) fue la primera reserva marítimo-costera del país, creada para proteger la enorme biodiversidad de la ecorregión del Mar Frío de la Corriente Peruana.',
  ),
  Question(
    id: 'cs_q311',
    topicId: 'cs_t3',
    text:
        'Ubicada en la llanura amazónica (Loreto), es la Reserva Nacional más extensa del Perú, protegiendo ecosistemas de bosques inundables, cochas y ríos donde el Estado permite a las comunidades ribereñas el manejo del paiche y la taricaya mediante cuotas controladas. Nos referimos a la Reserva Nacional:',
    options: [
      'Manu.',
      'Tambopata.',
      'Allpahuayo Mishana.',
      'Pacaya Samiria.',
      'Matsés.',
    ],
    correctAnswer: 3,
    explanation:
        'La Reserva Nacional Pacaya Samiria (conocida como la selva de los espejos) es un área de uso directo que destaca por sus planes de manejo exitosos de recursos hidrobiológicos.',
  ),
  Question(
    id: 'cs_q312',
    topicId: 'cs_t3',
    text:
        'La caza silvestre comercial y deportiva está prohibida en casi todo el territorio nacional, a excepción de una categoría específica de las ANP de Uso Directo. En estas áreas el Estado administra y fomenta el aprovechamiento de la fauna silvestre mediante la caza regulada y el turismo cinegético. Esta categoría legal es:',
    options: [
      'Parque Nacional.',
      'Santuario Nacional.',
      'Coto de Caza.',
      'Bosque de Protección.',
      'Reserva Comunal.',
    ],
    correctAnswer: 2,
    explanation:
        'Los Cotos de Caza (ej. El Angolo en Piura, o Sunchubamba en Cajamarca) son los únicos espacios legalmente habilitados para la caza deportiva bajo estricta regulación estatal.',
  ),
  Question(
    id: 'cs_q313',
    topicId: 'cs_t3',
    text:
        'El Estado peruano reconoce la importancia de proteger las cuencas altas de los ríos y preservar la cobertura forestal para evitar desastres como avalanchas, huaicos y erosión del suelo en terrenos de fuerte pendiente, garantizando el suministro de agua para los valles. Esta categoría de Uso Directo, que prohíbe la tala pero permite otros usos del bosque, se denomina:',
    options: [
      'Bosque de Protección.',
      'Coto de Caza.',
      'Reserva Paisajística.',
      'Refugio de Vida Silvestre.',
      'Santuario Nacional.',
    ],
    correctAnswer: 0,
    explanation:
        'Los Bosques de Protección (ej. Puquio Santa Rosa, Alto Mayo) son áreas intangibles en cuanto a la extracción forestal (madera), pero se permite la recolección de productos no maderables, protegiendo primariamente las cuencas hídricas.',
  ),
  Question(
    id: 'cs_q314',
    topicId: 'cs_t3',
    text:
        "En el derecho ambiental, las 'Zonas de Amortiguamiento' son espacios adyacentes a los límites de las Áreas Naturales Protegidas. Según la Ley N° 26834, la función técnico-jurídica principal de estas zonas es:",
    options: [
      'Servir como áreas exclusivas para el vertimiento de relaves mineros fuera del parque.',
      "Actuar como anillos de transición o 'colchones' donde las actividades humanas se regulan estrictamente para minimizar impactos negativos sobre el área protegida.",
      'Ser entregadas en propiedad privada absoluta a colonos extranjeros.',
      'Delimitar los terrenos donde las fuerzas militares probarán armamento pesado.',
      'Proporcionar una zona libre de impuestos (zona franca) para el comercio fronterizo.',
    ],
    correctAnswer: 1,
    explanation:
        'Las zonas de amortiguamiento (buffer zones) rodean las ANP para amortiguar el impacto de las actividades antrópicas, requiriendo que los proyectos allí desarrollados tengan estudios de impacto ambiental más rigurosos.',
  ),
  Question(
    id: 'cs_q315',
    topicId: 'cs_t3',
    text:
        "Las 'Reservas Comunales' son áreas destinadas a la conservación de la flora y fauna silvestre en beneficio exclusivo de:",
    options: [
      'Corporaciones madereras transnacionales.',
      'Turistas extranjeros con permisos de expedición cinegética.',
      'Las poblaciones rurales vecinas y comunidades nativas originarias que tradicionalmente han hecho uso de esos recursos.',
      'Exclusivamente las instituciones científicas y universidades del Estado.',
      'Empresas pesqueras industriales para extracción masiva.',
    ],
    correctAnswer: 2,
    explanation:
        'Las Reservas Comunales (ej. Asháninka, Amarakaeri) se crean específicamente para garantizar la seguridad alimentaria y el uso sostenible tradicional de las comunidades indígenas colindantes.',
  ),
  Question(
    id: 'cs_q316',
    topicId: 'cs_t3',
    text:
        "El Parque Nacional del Manu es famoso por ser un 'hotspot' de biodiversidad mundial. Geográficamente, esta inmensa área protegida, que desciende desde las punas altoandinas hasta la llanura amazónica, se ubica entre las regiones de:",
    options: [
      'Loreto y Ucayali.',
      'San Martín y Amazonas.',
      'Madre de Dios y Puno.',
      'Cusco y Madre de Dios.',
      'Junín y Pasco.',
    ],
    correctAnswer: 3,
    explanation:
        'El Manu abarca la vertiente oriental andina y la llanura amazónica, ubicándose jurisdiccionalmente entre los departamentos de Cusco y Madre de Dios.',
  ),
  Question(
    id: 'cs_q317',
    topicId: 'cs_t3',
    text:
        "La categoría de 'Reserva Paisajística' protege ambientes cuya integridad geográfica muestra una armoniosa relación entre el hombre y la naturaleza, albergando importantes valores naturales y culturales. El ejemplo más emblemático de esta categoría, caracterizado por sus cascadas escalonadas y andenerías preincas en Lima y Junín, es:",
    options: [
      'La Subcuenca del Cotahuasi.',
      'Nor Yauyos Cochas.',
      'Lomas de Lachay.',
      'Bosque de Pómac.',
      'Lagunas de Mejía.',
    ],
    correctAnswer: 1,
    explanation:
        'La Reserva Paisajística Nor Yauyos Cochas protege la belleza escénica del alto río Cañete, cascadas (como Huancaya) y terrazas agrícolas mantenidas históricamente por las comunidades.',
  ),
  Question(
    id: 'cs_q318',
    topicId: 'cs_t3',
    text:
        "En la región de Ayacucho, la Reserva Nacional Pampa Galeras – Bárbara D'Achille fue creada en 1967 con un objetivo de conservación sumamente específico y urgente, logrando salvar de la inminente extinción a un camélido emblemático para la textilería nacional. Este animal es:",
    options: [
      'La Llama.',
      'La Alpaca.',
      'El Guanaco.',
      'El Pudú.',
      'La Vicuña.',
    ],
    correctAnswer: 4,
    explanation:
        'Pampa Galeras es el santuario de la Vicuña por excelencia. Su creación logró recuperar la población de esta especie, cuya lana es la más fina del mundo y es patrimonio de la nación.',
  ),
  Question(
    id: 'cs_q319',
    topicId: 'cs_t3',
    text:
        "Los 'Refugios de Vida Silvestre' son áreas que requieren intervención activa del Estado para garantizar el mantenimiento y recuperación de hábitats específicos. Un refugio vital en Lima, que sirve como oasis y punto de descanso para miles de aves migratorias que recorren la costa del Pacífico, es:",
    options: [
      'Santuario Nacional Los Manglares.',
      'Refugio de Vida Silvestre Los Pantanos de Villa.',
      'Reserva Nacional de Junín.',
      'Coto de Caza El Angolo.',
      'Reserva Paisajística Nor Yauyos.',
    ],
    correctAnswer: 1,
    explanation:
        'Los Pantanos de Villa (Chorrillos, Lima) conforman un humedal de importancia internacional (Sitio Ramsar), funcionando como refugio esencial para la ornitofauna migratoria norte-sur.',
  ),
  Question(
    id: 'cs_q320',
    topicId: 'cs_t3',
    text:
        "Para un operativo conjunto entre la DIRMEAMB (Policía del Medio Ambiente) y el SERNANP, es vital conocer los límites legales. Si se descubre a un grupo de personas instalando un aserradero industrial permanente dentro de una Reserva Nacional (área de uso directo), ¿es legal esta instalación argumentando que es 'uso directo'?",
    options: [
      'Sí, porque al ser uso directo, se permite la industrialización absoluta del bosque.',
      'Sí, si pagan las regalías correspondientes al gobernador regional.',
      'No, porque las áreas de uso directo permiten el aprovechamiento por comunidades locales con planes de manejo, no la instalación de plantas de transformación industrial permanente.',
      'No, porque las reservas nacionales son exclusivamente de dominio privado extranjero.',
      'Sí, siempre que no utilicen sierras de acero importado.',
    ],
    correctAnswer: 2,
    explanation:
        'Uso directo NO significa libre mercado sin restricciones. Significa aprovechamiento tradicional o regulado (pesca, recolección) mediante planes de manejo. La instalación de industria pesada está proscrita en las ANP.',
  ),
  Question(
    id: 'cs_q321',
    topicId: 'cs_t3',
    text:
        'En el departamento de Tumbes existe un ecosistema halófito (adaptado a aguas salobres) único en el Perú, formado en el estuario de los ríos Tumbes y Zarumilla. Este ecosistema de Uso Indirecto protege el hábitat del cocodrilo de Tumbes y se denomina:',
    options: [
      'Santuario Nacional Los Manglares de Tumbes.',
      'Parque Nacional Cerros de Amotape.',
      'Reserva Nacional de Tumbes.',
      'Bosque de Protección de Zarumilla.',
      'Reserva Comunal del Norte.',
    ],
    correctAnswer: 0,
    explanation:
        'Los Manglares de Tumbes constituyen un Santuario Nacional, siendo un ecosistema anfibio intangible vital para el ciclo reproductivo de crustáceos y moluscos (conchas negras).',
  ),
  Question(
    id: 'cs_q322',
    topicId: 'cs_t3',
    text:
        'El Parque Nacional del Río Abiseo, ubicado en San Martín, es Patrimonio Mixto de la Humanidad (Natural y Cultural) por la UNESCO. Destaca ecológicamente por proteger ecosistemas de ceja de selva y culturalmente porque en su interior (intangible) se halla un importante centro arqueológico de la cultura Chachapoyas llamado:',
    options: [
      'Machu Picchu.',
      'Kuélap.',
      'Gran Pajatén.',
      'Choquequirao.',
      'Vilcabamba.',
    ],
    correctAnswer: 2,
    explanation:
        'El Gran Pajatén es el complejo arqueológico inmerso en la espesura del Parque Nacional del Río Abiseo, lo que le otorga la doble condición de patrimonio mundial.',
  ),
  Question(
    id: 'cs_q323',
    topicId: 'cs_t3',
    text:
        'El Santuario Nacional de Huayllay (Pasco) es famoso por proteger una impresionante formación geológica esculpida por la erosión glaciar y eólica a lo largo de milenios, asemejándose a figuras animales y humanas de piedra. A este fenómeno geográfico se le conoce popularmente como:',
    options: [
      'El Cañón del Colca.',
      'El Valle de los Volcanes.',
      'El Bosque de Rocas.',
      'Las Dunas de Ica.',
      'Las Cataratas de Gocta.',
    ],
    correctAnswer: 2,
    explanation:
        'El Bosque de Rocas de Huayllay es una maravilla geológica de la meseta del Bombón, protegido bajo la categoría de Santuario Nacional.',
  ),
  Question(
    id: 'cs_q324',
    topicId: 'cs_t3',
    text:
        "Las 'Lomas Costeras' son ecosistemas endémicos de hiperaridez que florecen excepcionalmente durante el invierno limeño debido a la densa neblina, reverdeciendo el desierto. La reserva natural más emblemática y visitada que protege este ecosistema frágil al norte de Lima es:",
    options: [
      'Reserva Nacional de Paracas.',
      'Santuario Histórico Bosque de Pómac.',
      'Reserva Nacional de Lachay.',
      'Refugio de Vida Silvestre Laquipampa.',
      'Bosque de Protección Puquio Santa Rosa.',
    ],
    correctAnswer: 2,
    explanation:
        'La Reserva Nacional de Lachay (Lima) protege el ecosistema de lomas, permitiendo la investigación y el turismo estacional (uso directo para ecoturismo), previniendo la tala ilegal de la tara o el mito.',
  ),
  Question(
    id: 'cs_q325',
    topicId: 'cs_t3',
    text:
        'La creación de un Área Natural Protegida de administración nacional requiere un procedimiento jurídico riguroso y el respaldo del Poder Ejecutivo, dada su afectación a los derechos de propiedad y concesiones. Legalmente, el establecimiento definitivo de un Parque o Reserva Nacional se oficializa mediante la promulgación de:',
    options: [
      'Una Resolución Municipal.',
      'Un Edicto del Gobernador Regional.',
      'Un Decreto Supremo (con el voto aprobatorio del Consejo de Ministros).',
      'Una Resolución Directoral de una comisaría.',
      'Una Ordenanza Distrital.',
    ],
    correctAnswer: 2,
    explanation:
        'Las ANP de administración nacional se establecen por Decreto Supremo refrendado por el Ministerio del Ambiente. Su categorización definitiva es una prerrogativa de alto nivel del Estado.',
  ),
  Question(
    id: 'cs_q326',
    topicId: 'cs_t3',
    text:
        "El Perú firmó el 'Convenio de Ramsar', un tratado intergubernamental para la conservación de ecosistemas acuáticos que sirven de hábitat para aves migratorias y flora hídrica. ¿Qué tipo específico de ecosistema es protegido internacionalmente por este tratado, del cual el lago Titicaca y Pantanos de Villa forman parte?",
    options: [
      'Bosques secos ecuatoriales.',
      'Glaciares tropicales.',
      'Humedales.',
      'Desiertos costeros.',
      'Valles interandinos.',
    ],
    correctAnswer: 2,
    explanation:
        'El Convenio de Ramsar protege los Humedales (pantanos, manglares, lagos poco profundos) de importancia internacional por su rica diversidad biológica hidrobiológica y ornitológica.',
  ),
  Question(
    id: 'cs_q327',
    topicId: 'cs_t3',
    text:
        'El Santuario Histórico del Bosque de Pómac (Lambayeque) cumple una doble función de protección: alberga la mayor formación natural de algarrobos del mundo y protege un inmenso complejo arqueológico de pirámides de adobe pertenecientes a la cultura:',
    options: [
      'Inca.',
      'Sicán o Lambayeque.',
      'Chavín.',
      'Tiahuanaco.',
      'Paracas.',
    ],
    correctAnswer: 1,
    explanation:
        'El Bosque de Pómac es el núcleo del Santuario Histórico donde floreció la cultura Sicán (Señor de Sicán), famosa por su extraordinaria orfebrería (tumis de oro) y pirámides.',
  ),
  Question(
    id: 'cs_q328',
    topicId: 'cs_t3',
    text:
        'Las Áreas de Conservación Regional (ACR) y Áreas de Conservación Privada (ACP) complementan al SINANPE, pero la jurisdicción para aprobar el establecimiento de una ACP recae sobre propiedades privadas a solicitud de sus dueños. Sin embargo, su reconocimiento legal formal, que las sujeta a perpetuidad o plazo definido, siempre debe ser emitido por:',
    options: [
      'El Alcalde Provincial.',
      'El Ministerio del Ambiente a través del SERNANP.',
      'La Superintendencia de Bienes Nacionales (SBN).',
      'El Ministerio de Defensa.',
      'Las Rondas Campesinas.',
    ],
    correctAnswer: 1,
    explanation:
        'Incluso si el área es privada, el reconocimiento como ACP es un acto administrativo del Estado otorgado por el MINAM a través del SERNANP, tras verificar los requisitos técnicos de conservación.',
  ),
  Question(
    id: 'cs_q329',
    topicId: 'cs_t3',
    text:
        'La minería aurífera ilegal en Madre de Dios generó una grave crisis ambiental. En respuesta, el Estado estableció en 2010 un área de uso indirecto (intangible) entre las provincias de Tambopata y Tahuamanu para proteger una extensa muestra de la selva baja sur amazónica, que hoy es el principal escudo contra el avance de las dragas mineras. Esta área es:',
    options: [
      'La Reserva Nacional Tambopata.',
      'El Parque Nacional Bahuaja Sonene.',
      'La Reserva Comunal Amarakaeri.',
      'La Zona Reservada Sierra del Divisor.',
      'El Parque Nacional del Manu.',
    ],
    correctAnswer: 1,
    explanation:
        'Bahuaja Sonene es el Parque Nacional clave en Madre de Dios y Puno que protege la sabana de palmeras y los bosques amazónicos del sur, sufriendo constantes presiones en su zona de amortiguamiento.',
  ),
  Question(
    id: 'cs_q330',
    topicId: 'cs_t3',
    text:
        "Dentro del SINANPE, existen las denominadas 'Zonas Reservadas'. Jurídicamente, la declaración de un territorio como 'Zona Reservada' significa que:",
    options: [
      'El área ha sido definitivamente privatizada para corporaciones extractivas.',
      'Es un estatus transitorio otorgado a un área que posee condiciones de conservación, mientras se realizan los estudios para definir su categoría definitiva.',
      'Es un terreno urbano congelado para la futura construcción militar.',
      'El territorio ha perdido todo su valor ecológico y será deforestado.',
      'Se ha cedido la soberanía del territorio a las Naciones Unidas.',
    ],
    correctAnswer: 1,
    explanation:
        "Una 'Zona Reservada' es una categoría transitoria, preventiva. Se protege temporalmente hasta que las comisiones técnicas determinen si se convertirá en Parque, Reserva, Santuario, etc.",
  ),
  Question(
    id: 'cs_q331',
    topicId: 'cs_t3',
    text:
        "El uso tradicional de la flora en los Andes incluye pastoreo. Si una comunidad campesina ancestral pasta sus rebaños de llamas dentro de un 'Parque Nacional' y esta actividad se opone a los objetivos de intangibilidad absoluta del área. ¿Qué acción establece la ley peruana para lidiar jurídicamente con derechos preexistentes a la creación del Parque?",
    options: [
      'Expropiación inmediata sin derecho a compensación ni reubicación.',
      'Fusilamiento de los líderes comunales en la plaza del pueblo.',
      'El Estado debe respetar el uso consuetudinario siempre que no ponga en riesgo los fines de creación del área, debiendo regularlo o establecer acuerdos de mitigación/reubicación pactada.',
      'Permitir la venta de las parcelas del parque a inmobiliarias extranjeras.',
      'Derogar inmediatamente el decreto de creación del Parque Nacional.',
    ],
    correctAnswer: 2,
    explanation:
        'La Ley 26834 reconoce los derechos adquiridos preexistentes de comunidades nativas y campesinas. No se les puede expulsar violentamente; el Estado (SERNANP) firma acuerdos de co-gestión o planes de manejo mitigantes.',
  ),
  Question(
    id: 'cs_q332',
    topicId: 'cs_t3',
    text:
        'En Tumbes existe una categoría única (Reserva Nacional) que colinda con el Ecuador, protegiendo ecosistemas de bosque tropical del Pacífico, una rareza en la costa peruana, donde habitan monos aulladores y cocodrilos. Esta área es la:',
    options: [
      'Reserva Nacional de Tumbes.',
      'Santuario Nacional Los Manglares.',
      'Coto de Caza El Angolo.',
      'Reserva Paisajística Nor Yauyos.',
      'Parque Nacional Cerros de Amotape.',
    ],
    correctAnswer: 0,
    explanation:
        'La Reserva Nacional de Tumbes protege el único relicto de Bosque Tropical del Pacífico (con ecosistemas de flora perennifolia) en el Perú, compartiendo frontera con el parque ecuatoriano.',
  ),
  Question(
    id: 'cs_q333',
    topicId: 'cs_t3',
    text:
        "Los 'Planes Maestros' son los documentos técnicos más importantes para la gestión de un Área Natural Protegida. Según la normativa del SERNANP, ¿cada cuántos años debe actualizarse obligatoriamente el Plan Maestro de un ANP para adaptarse a los nuevos desafíos ambientales y sociales?",
    options: [
      'Cada año.',
      'Cada 5 años.',
      'Cada 20 años.',
      'Nunca, es inamovible.',
      'Cada 50 años.',
    ],
    correctAnswer: 1,
    explanation:
        'Los Planes Maestros son instrumentos de planificación estratégica a mediano plazo y, por ley, deben ser revisados y actualizados cada cinco (5) años con participación ciudadana.',
  ),
  Question(
    id: 'cs_q334',
    topicId: 'cs_t3',
    text:
        'En la región Puno se ubica el lago navegable más alto del mundo. Debido a la presión de la contaminación y la recolección de totora y fauna íctica, el Estado estableció un área de Uso Directo para lograr el aprovechamiento racional de sus recursos. Esta área protegida se denomina:',
    options: [
      'Santuario Nacional de Arapa.',
      'Reserva Nacional del Titicaca.',
      'Parque Nacional del Titicaca.',
      'Reserva Paisajística Aymara Lupaca.',
      'Refugio de Vida Silvestre Puno.',
    ],
    correctAnswer: 1,
    explanation:
        'La Reserva Nacional del Titicaca es de uso directo, lo que permite a las etnias (como los Uros) continuar usando racionalmente la totora y pescando especies nativas como el ispi o carachi.',
  ),
  Question(
    id: 'cs_q335',
    topicId: 'cs_t3',
    text:
        "Existe un concepto vital para los operativos policiales en ecosistemas sensibles: La 'Tala Ilegal'. Si un comunero corta leña muerta dentro de la zona de amortiguamiento para uso doméstico (cocinar), frente a una banda criminal que extrae cedro dentro del Parque Nacional, ¿cómo distingue la ley 26834 ambos actos?",
    options: [
      'Ambos son terroristas ecológicos y merecen cadena perpetua.',
      'El comunero ejerce subsistencia regulada; la banda criminal comete un delito ambiental agravado por estar en área intangible (Uso Indirecto).',
      'Ambos actos son legales porque los bosques peruanos son res nullius (de nadie).',
      'La banda criminal no comete delito si paga el peaje de la carretera.',
      'El comunero comete mayor delito por no pertenecer a una corporación.',
    ],
    correctAnswer: 1,
    explanation:
        'La legislación ambiental diferencia la escala de subsistencia fuera del núcleo, frente a la extracción industrial ilegal con fines de lucro dentro del polígono intangible del Parque Nacional, tipificada penalmente.',
  ),
  Question(
    id: 'cs_q336',
    topicId: 'cs_t3',
    text:
        "El Coto de Caza 'El Angolo', ubicado en Piura, es un ecosistema de bosque seco ecuatorial. La principal especie de fauna cinegética que atrae el turismo deportivo regulado en esta área, permitiendo su conservación gracias a los ingresos económicos de la caza, es:",
    options: [
      'El oso de anteojos.',
      'El puma andino.',
      'El venado de cola blanca.',
      'La pava aliblanca.',
      'El zorro costeño.',
    ],
    correctAnswer: 2,
    explanation:
        'El venado cola blanca es el trofeo cinegético principal en El Angolo. El manejo riguroso asegura que solo se cacen machos adultos seleccionados, manteniendo el equilibrio poblacional.',
  ),
  Question(
    id: 'cs_q337',
    topicId: 'cs_t3',
    text:
        "Un aspirante a oficial PNP debe conocer la categorización. Si la DIREJANDRO descubre una pista de aterrizaje clandestina para el narcotráfico dentro de un 'Santuario Nacional', la situación es crítica porque:",
    options: [
      'Los traficantes no pagaron los impuestos de aeródromo civil.',
      'Un Santuario Nacional es área de Uso Indirecto e intangible; su desbosque y alteración para la pista constituye un daño ecológico agravado irreversible sobre ecosistemas o especies endémicas.',
      'Los Santuarios Nacionales están destinados exclusivamente a la minería formal.',
      'El ruido de las avionetas asusta a los turistas en las playas limeñas.',
      'Las pistas clandestinas deben asfaltarse obligatoriamente por ley.',
    ],
    correctAnswer: 1,
    explanation:
        'Además del delito de tráfico ilícito de drogas, se incurre en delitos ambientales gravísimos tipificados en el Código Penal, dada la intangibilidad y fragilidad extrema del área.',
  ),
  Question(
    id: 'cs_q338',
    topicId: 'cs_t3',
    text:
        'La Reserva Nacional Salinas y Aguada Blanca, ubicada entre Arequipa y Moquegua, fue creada principalmente para conservar los hábitats altoandinos y proteger las poblaciones de herbívoros silvestres sudamericanos, principalmente:',
    options: [
      'Tapires y ronsocos.',
      'Vicuñas, guanacos, tarucas y flamencos (parihuanas).',
      'Monos choro de cola amarilla.',
      'Pingüinos de Humboldt.',
      'Osos polares y focas pardas.',
    ],
    correctAnswer: 1,
    explanation:
        'Salinas y Aguada Blanca protege las inmensas planicies de puna y los bofedales/lagunas, siendo hábitat crucial para camélidos silvestres y aves migratorias como los flamencos altiplánicos.',
  ),
  Question(
    id: 'cs_q339',
    topicId: 'cs_t3',
    text:
        'El Parque Nacional Cordillera Azul, que abarca territorios de San Martín, Loreto, Ucayali y Huánuco, destaca internacionalmente por un mecanismo financiero moderno aplicado en sus Zonas de Amortiguamiento que permite a corporaciones extranjeras compensar sus emisiones mediante la protección del bosque. Este mercado se conoce como:',
    options: [
      'Mercado de bonos de carbono (REDD+).',
      'Concesión petrolera de cuenca abierta.',
      'Tratado de libre comercio de maderas exóticas.',
      'Sistema financiero de tala selectiva.',
      'Mercado de acciones mineras de tajo abierto.',
    ],
    correctAnswer: 0,
    explanation:
        "El mecanismo REDD+ (Reducción de Emisiones por Deforestación y Degradación) vende 'créditos de carbono' al mercado internacional, demostrando que el bosque en pie (sin talar) genera dinero para conservarlo.",
  ),
  Question(
    id: 'cs_q340',
    topicId: 'cs_t3',
    text:
        'A nivel botánico y geográfico, el Bosque de Protección Alto Mayo (San Martín) protege una ecorregión de selva alta extremadamente frágil. Una de las especies de flora más hermosas, endémicas y amenazadas por la depredación comercial ilegal que abunda en este bosque húmedo nuboso son:',
    options: [
      'Los cactus candelabro.',
      'Las orquídeas y los helechos arbóreos.',
      'Los algarrobos milenarios.',
      'Las palmeras datileras del desierto.',
      'Los pinos canadienses.',
    ],
    correctAnswer: 1,
    explanation:
        'El Alto Mayo es mundialmente reconocido por su biodiversidad en orquídeas endémicas (como la Phragmipedium kovachii), fuertemente amenazadas por traficantes de flora exótica.',
  ),
  Question(
    id: 'cs_q341',
    topicId: 'cs_t3',
    text:
        'La Ley 26834 establece un Comité de Gestión para cada ANP. Este comité no tiene función punitiva, pero es clave para la gobernanza ambiental. Su principal característica es que está conformado por:',
    options: [
      'Exclusivamente magistrados del Tribunal Constitucional.',
      'Generales en retiro de las Fuerzas Armadas y la PNP.',
      'Representantes del Estado, gobiernos locales, poblaciones indígenas colindantes, ONGs y el sector privado, asegurando participación ciudadana.',
      'Inversionistas petroleros de corporaciones europeas.',
      'Solo por el Jefe del Parque Nacional en forma dictatorial.',
    ],
    correctAnswer: 2,
    explanation:
        'El Comité de Gestión es el mecanismo legal que garantiza que las decisiones sobre la conservación o planes de manejo del ANP incluyan la voz de los comuneros locales y la sociedad civil, previniendo conflictos sociales.',
  ),
  Question(
    id: 'cs_q342',
    topicId: 'cs_t3',
    text:
        'En el ecosistema amazónico peruano (Ucayali, Loreto), existen categorías como la Reserva Comunal Purús. El objetivo fundamental de estas reservas, además de proteger el bosque, es garantizar el derecho territorial y el aprovisionamiento de un grupo poblacional extremadamente vulnerable al contacto epidemiológico. Nos referimos a:',
    options: [
      'Los mineros auríferos del VRAEM.',
      'Los colonos agrícolas europeos recién llegados.',
      'Los Pueblos Indígenas en Situación de Aislamiento y Contacto Inicial (PIACI).',
      'Los empresarios de turismo de aventura extremo.',
      'Las misiones religiosas de evangelización forzada.',
    ],
    correctAnswer: 2,
    explanation:
        "Las reservas comunales, junto con las Reservas Territoriales (categoría del MINCU), crean grandes escudos geográficos ('corredores de conservación') para proteger a etnias no contactadas (PIACI) de invasores y epidemias letales.",
  ),
  Question(
    id: 'cs_q343',
    topicId: 'cs_t3',
    text:
        "El Parque Nacional Yanachaga Chemillén, ubicado en la provincia de Oxapampa (Pasco), protege ecosistemas desde la puna hasta la selva alta. Esta ANP actúa como un refugio de biodiversidad crucial y zona núcleo dentro de una 'Reserva de Biosfera' reconocida por la UNESCO llamada:",
    options: [
      'Reserva de Biosfera Oxapampa-Asháninka-Yánesha.',
      'Reserva de Biosfera del Noroeste Amotapes-Manglares.',
      'Reserva de Biosfera Huascarán.',
      'Reserva de Biosfera Manu.',
      'Reserva de Biosfera Gran Pajatén.',
    ],
    correctAnswer: 0,
    explanation:
        'Yanachaga Chemillén es el corazón intangible de la Reserva de Biosfera BIOAY en Pasco, demostrando cómo la conservación estricta beneficia a los ecosistemas agroforestales aledaños (como los cafetales de Villa Rica).',
  ),
  Question(
    id: 'cs_q344',
    topicId: 'cs_t3',
    text:
        'El Estado Peruano ha creado áreas protegidas marinas. La primera Área Nacional Protegida de carácter exclusivamente marítimo, creada a finales del 2021 frente a las costas de Ica, Nasca y Arequipa, protegiendo un sistema de cordilleras submarinas y rica fauna pelágica, es:',
    options: [
      'Reserva Nacional Dorsal de Nasca.',
      'Santuario Nacional de la Anchoveta.',
      'Parque Nacional del Mar de Grau.',
      'Reserva Paisajística Islas Ballestas.',
      'Coto de Caza Submarina del Pacífico.',
    ],
    correctAnswer: 0,
    explanation:
        'La Reserva Nacional Dorsal de Nasca fue un hito al ser la primera ANP 100% marítima del país, destinada a proteger la cadena de montes submarinos y el tránsito de ballenas azules y tiburones.',
  ),
  Question(
    id: 'cs_q345',
    topicId: 'cs_t3',
    text:
        "Durante los estudios de impacto ambiental de las carreteras interoceánicas, se advirtió la fragmentación de ecosistemas. El objetivo primario de los 'Corredores de Conservación' establecidos entre distintas Áreas Naturales Protegidas separadas geográficamente es:",
    options: [
      'Permitir el monopolio de concesiones madereras en un solo carril.',
      'Garantizar la conectividad genética y el flujo de fauna silvestre (como el jaguar) entre áreas núcleo, previniendo el aislamiento biológico de las poblaciones.',
      'Instalar ductos de gas ininterrumpidos desde la selva a la costa.',
      'Cobrar peajes ecológicos a los pobladores locales por caminar en la selva.',
      'Delimitar polígonos militares para bombardeos aéreos.',
    ],
    correctAnswer: 1,
    explanation:
        'Los animales territoriales necesitan inmensos espacios. Si un ANP queda rodeada de carreteras y ciudades, las especies se aíslan (endogamia). Los corredores aseguran puentes biológicos para el tránsito y cruce reproductivo.',
  ),
  Question(
    id: 'cs_q346',
    topicId: 'cs_t3',
    text:
        'El Santuario Nacional de Ampay, ubicado en la región Apurímac, fue establecido con carácter de intangibilidad absoluta para proteger de la tala a una especie arbórea relictual (sobreviviente de épocas frías) que conforma el único bosque en su género en el sur del Perú. Esta conífera andina es:',
    options: [
      'El Cedro rosado.',
      'La Caoba.',
      'La Intimpa (Podocarpus glomeratus).',
      'El Algarrobo.',
      'El Huarango costeño.',
    ],
    correctAnswer: 2,
    explanation:
        'La Intimpa (pino andino) era intensamente talada. El Santuario del Ampay se creó exprofeso para salvar este bosque relicto único, enclaustrado en las laderas del nevado Ampay.',
  ),
  Question(
    id: 'cs_q347',
    topicId: 'cs_t3',
    text:
        'Los guardaparques del SERNANP son la primera línea de defensa del patrimonio natural. Jurídicamente, frente a un delito ambiental en flagrancia (como la minería ilegal o tala en un Parque Nacional), el guardaparque tiene la autoridad civil para intervenir, pero el monopolio del uso de la fuerza pública, los arrestos y el comiso definitivo de maquinarias requiere la presencia ineludible de:',
    options: [
      'El presidente de la ronda campesina local.',
      'La Policía Nacional del Perú (DIRMEAMB) y la Fiscalía Especializada en Materia Ambiental (FEMA).',
      'Los embajadores de la UNESCO.',
      'Las Organizaciones No Gubernamentales (ONGs) extranjeras.',
      'El serenazgo municipal distrital.',
    ],
    correctAnswer: 1,
    explanation:
        'El SERNANP emite alertas y sanciones administrativas, pero constitucionalmente, la desarticulación de mafias, detenciones y operaciones de interdicción recaen sobre la fuerza coercitiva de la PNP y el Ministerio Público.',
  ),
  Question(
    id: 'cs_q348',
    topicId: 'cs_t3',
    text:
        'Un ejemplo dramático de contaminación por actividades extractivas no controladas se dio en la Reserva Nacional de Junín (Lago Chinchaycocha), donde el ecosistema de aves endémicas, como el zambullidor de Junín, sufre la pérdida de hábitat acuático debido primordialmente a:',
    options: [
      'Los vertimientos de relaves mineros de metales pesados desde cuencas altas y el represamiento hidroeléctrico que altera el nivel de las aguas.',
      'El exceso de buques petroleros transatlánticos que cruzan el lago.',
      'La lluvia ácida provocada por erupciones volcánicas continuas.',
      'La excesiva pesca deportiva con dinamita.',
      'El calentamiento masivo de aguas por centrales nucleares.',
    ],
    correctAnswer: 0,
    explanation:
        'El Lago Junín sufre hace décadas la contaminación crónica por pasivos de la minería de Pasco y La Oroya (cobre, plomo, zinc), sumado al manejo del dique de Upamayo que inunda nidos de aves endémicas.',
  ),
  Question(
    id: 'cs_q349',
    topicId: 'cs_t3',
    text:
        'Si analizamos jurídicamente el Artículo 27 de la Ley N° 26834 (sobre el Uso de las Áreas), se establece una prohibición general aplicable a TODO el SINANPE respecto a un tema sumamente sensible para la soberanía del país. Salvo contadísimas excepciones aprobadas por el Estado, en las ANP está tajantemente prohibido:',
    options: [
      'La introducción de tecnología digital y satelital.',
      'El establecimiento de asentamientos humanos poblacionales (nuevos centros urbanos).',
      'La visita guiada de turistas extranjeros sin visa diplomática.',
      'El estudio científico de las plantas venenosas.',
      'La fotografía aérea mediante drones autorizados.',
    ],
    correctAnswer: 1,
    explanation:
        'Para garantizar la conservación, la ley prohíbe fundar nuevos pueblos o asentar masas poblacionales (colonización agrícola o urbana) dentro de cualquier Área Natural Protegida, salvo los derechos preexistentes (indígenas).',
  ),
  Question(
    id: 'cs_q350',
    topicId: 'cs_t3',
    text:
        'La Reserva Nacional Sistema de Islas, Islotes y Puntas Guaneras (RNSIIPG) abarca 22 puntos a lo largo de toda la costa peruana. Esta reserva es de suma importancia no solo ecológica (protegiendo a los pingüinos y aves guaneras) sino económica, ya que permite un uso directo altamente rentable para el Estado, que consiste en:',
    options: [
      'La perforación masiva de pozos petroleros offshore en cada isla.',
      'La construcción de casinos flotantes y resorts turísticos cinco estrellas.',
      'La recolección racional, sectorizada y sostenible del guano de isla (fertilizante natural superior) administrada por el programa Agro Rural.',
      'El desmantelamiento de las islas rocosas para obtener material de construcción para rompeolas.',
      'La venta de las islas a soberanías extranjeras para bases militares conjuntas.',
    ],
    correctAnswer: 2,
    explanation:
        'La RNSIIPG es el mejor ejemplo de Uso Directo exitoso a nivel macro. El Estado (mediante Agro Rural) extrae el fertilizante orgánico (guano de isla) respetando los ciclos de reproducción de las aves (pelícanos, piqueros, guanayes).',
  ),
  Question(
    id: 'cs_q351',
    topicId: 'cs_t3',
    text:
        'En el Perú, la máxima autoridad técnica-normativa encargada de dirigir el Sistema Nacional de Áreas Naturales Protegidas por el Estado (SINANPE) es un organismo técnico especializado adscrito al Ministerio del Ambiente. Este ente rector es:',
    options: [
      'El Instituto Geofísico del Perú (IGP).',
      'El Servicio Nacional Forestal y de Fauna Silvestre (SERFOR).',
      'El Servicio Nacional de Áreas Naturales Protegidas por el Estado (SERNANP).',
      'La Autoridad Nacional del Agua (ANA).',
      'El Organismo de Evaluación y Fiscalización Ambiental (OEFA).',
    ],
    correctAnswer: 2,
    explanation:
        'El SERNANP es el organismo público rector del SINANPE, encargado de establecer los criterios técnicos y administrativos para la conservación de la diversidad biológica en las ANP.',
  ),
  Question(
    id: 'cs_q352',
    topicId: 'cs_t3',
    text:
        'El SINANPE clasifica las Áreas Naturales Protegidas en dos grandes grupos según la intensidad de aprovechamiento de los recursos que el Estado permite. Esta división jurídica fundamental es entre:',
    options: [
      'Áreas de caza intensiva y áreas de tala controlada.',
      'Áreas privadas empresariales y áreas comunitarias indígenas.',
      'Áreas de Uso Directo y Áreas de Uso Indirecto.',
      'Zonas de amortiguamiento y Zonas francas libres de impuestos.',
      'Parques Metropolitanos y Áreas de Conservación Privada.',
    ],
    correctAnswer: 2,
    explanation:
        'La Ley de Áreas Naturales Protegidas (Ley N° 26834) clasifica las áreas en Uso Directo (donde se permite la extracción de recursos bajo planes de manejo, ej. Reservas Nacionales) y Uso Indirecto (zonas intangibles, ej. Parques Nacionales).',
  ),
  Question(
    id: 'cs_q353',
    topicId: 'cs_t3',
    text:
        "De acuerdo con la legislación peruana, los 'Parques Nacionales' ostentan el grado de protección más estricto (Uso Indirecto). ¿Qué actividad está jurídicamente permitida en el interior de un Parque Nacional?",
    options: [
      'La tala de madera de especies no amenazadas con fines comerciales.',
      'La extracción de petróleo bajo contrato de concesión avalado por Perupetro.',
      'La agricultura migratoria y el establecimiento de nuevos asentamientos humanos colonos.',
      'La investigación científica no manipulativa, la educación ambiental y el ecoturismo (turismo de observación).',
      'La caza deportiva controlada mediante licencias estacionales.',
    ],
    correctAnswer: 3,
    explanation:
        'Los Parques Nacionales protegen la integridad ecológica de los ecosistemas (son de uso indirecto o intangibles). Está absolutamente prohibido extraer recursos (madera, minerales, caza); solo se permite investigación, turismo y educación.',
  ),
  Question(
    id: 'cs_q354',
    topicId: 'cs_t3',
    text:
        "A diferencia de un Parque Nacional, en una 'Reserva Nacional' (área de Uso Directo) el Estado fomenta la conservación a través del:",
    options: [
      'Prohibición absoluta del ingreso de turistas sin visa diplomática.',
      'Aprovechamiento sostenible y comercial de la flora y fauna silvestre por parte de las poblaciones locales, siempre bajo estrictos planes de manejo aprobados por SERNANP.',
      'Otorgamiento de títulos de propiedad privada irremediables sobre los recursos hídricos a transnacionales.',
      'Cultivo intensivo de soya transgénica para exportación masiva.',
      'Desarrollo de ensayos nucleares subterráneos al estar despobladas.',
    ],
    correctAnswer: 1,
    explanation:
        'Las Reservas Nacionales protegen la biodiversidad pero permitiendo que las comunidades tradicionales se beneficien económicamente de los recursos (pesca, recolección de frutos, manejo de vicuñas) bajo planes de sostenibilidad (Uso Directo).',
  ),
  Question(
    id: 'cs_q355',
    topicId: 'cs_t3',
    text:
        'El Parque Nacional más extenso del Perú, ubicado en la Amazonía (entre Loreto y Ucayali), que protege vastas llanuras y bosques de terrazas bajas sin intervención humana alguna, siendo un verdadero refugio prístino de la biodiversidad, es el:',
    options: [
      'Parque Nacional de Cutervo.',
      'Parque Nacional Alto Purús.',
      'Parque Nacional Huascarán.',
      'Parque Nacional Tingo María.',
      'Parque Nacional Sierra del Divisor.',
    ],
    correctAnswer: 1,
    explanation:
        'El Parque Nacional Alto Purús abarca más de 2.5 millones de hectáreas (el más grande del país). Es intangible y resguarda no solo flora y fauna endémica, sino también a tribus indígenas en aislamiento voluntario (PIACI).',
  ),
  Question(
    id: 'cs_q356',
    topicId: 'cs_t3',
    text:
        'El Parque Nacional del Manu, declarado Patrimonio de la Humanidad por la UNESCO, es mundialmente célebre por tener el récord de biodiversidad en anfibios, reptiles y aves. Este icónico parque se sitúa en los departamentos de:',
    options: [
      'Amazonas y San Martín.',
      'Piura y Tumbes.',
      'Cusco y Madre de Dios.',
      'Puno y Moquegua.',
      'Loreto y Ucayali.',
    ],
    correctAnswer: 2,
    explanation:
        'El Manu es la joya de la corona del SINANPE, extendiéndose desde la puna cusqueña a más de 4,000 m.s.n.m., descendiendo por el bosque de nubes hasta la exuberante selva baja de Madre de Dios (gradiente altitudinal excepcional).',
  ),
  Question(
    id: 'cs_q357',
    topicId: 'cs_t3',
    text:
        "La Reserva Nacional Pacaya Samiria, conocida como la 'Selva de los Espejos', es la segunda área natural protegida más grande del país. Su importancia radica en la conservación de inmensos ecosistemas de humedales amazónicos y de especies acuáticas comerciales clave para la región Loreto, como:",
    options: [
      'La trucha arcoíris y el pejerrey.',
      'El paiche, la charapa (tortuga de agua dulce), el lobo de río y el manatí amazónico.',
      'Las ballenas jorobadas y los lobos marinos chuscos.',
      'Los pingüinos de Humboldt y pelícanos.',
      'El oso de anteojos y la vicuña serrana.',
    ],
    correctAnswer: 1,
    explanation:
        'Pacaya Samiria (Loreto) resguarda la mayor extensión de bosque inundable de la Amazonía, siendo el hábitat principal de recursos pesqueros vitales (paiche, piraña) y especies amenazadas como el delfín rosado y el manatí.',
  ),
  Question(
    id: 'cs_q358',
    topicId: 'cs_t3',
    text:
        'El Parque Nacional Huascarán (Ancash) es un patrimonio natural incalculable que protege la Cordillera Tropical más alta y extensa del mundo (Cordillera Blanca). El ecosistema primario protegido en este parque (Uso Indirecto) es:',
    options: [
      'El bosque seco ecuatorial y manglares.',
      'La selva tropical baja inundable (restingas).',
      'El desierto costero y dunas fósiles.',
      'El ecosistema de alta montaña andina (puna, glaciares tropicales, lagunas de origen glaciar y bosques de queñual).',
      'El páramo húmedo andino paramero exclusivo del norte.',
    ],
    correctAnswer: 3,
    explanation:
        'El Parque Huascarán protege el corazón de la Cordillera Blanca, incluyendo picos nevados (Huascarán 6,768 m), cientos de lagunas glaciares (Llanganuco, Parón) y especies amenazadas como la puya Raimondi y el oso de anteojos.',
  ),
  Question(
    id: 'cs_q359',
    topicId: 'cs_t3',
    text:
        'La única área natural protegida de nivel nacional (Uso Directo) en el Perú que resguarda muestras representativas de ecosistemas marino-costeros, desérticos continentales y la rica biodiversidad de la corriente de Humboldt es la:',
    options: [
      'Reserva Nacional de Tambopata.',
      'Santuario Histórico de Machupicchu.',
      'Reserva Nacional de Paracas.',
      'Reserva Comunal El Sira.',
      'Parque Nacional Cerros de Amotape.',
    ],
    correctAnswer: 2,
    explanation:
        'La Reserva Nacional de Paracas (Ica) fue creada para conservar porciones de mar y desierto costero, protegiendo hábitats de descanso y alimentación de aves guaneras, parihuanas, tortugas marinas, pingüinos y lobos marinos.',
  ),
  Question(
    id: 'cs_q360',
    topicId: 'cs_t3',
    text:
        'El Santuario Nacional Los Manglares de Tumbes protege un ecosistema único en el extremo norte costero peruano. Este bioma se caracteriza por su bosque anfibio y es el hábitat exclusivo de especies de alto valor comercial y gastronómico extractivo tradicional, como:',
    options: [
      'La anchoveta y el jurel de aguas frías.',
      'Las alpacas de raza suri y vicuñas.',
      'Las conchas negras, los cangrejos del manglar y el cocodrilo de Tumbes.',
      'El paiche y el zúngaro de río amazónico.',
      'La pava aliblanca y el pingüino de Humboldt.',
    ],
    correctAnswer: 2,
    explanation:
        'El ecosistema de manglar (donde se mezcla agua dulce del río y salada del mar) tiene raíces zancudas que albergan moluscos y crustáceos muy preciados (conchas negras y cangrejo rojo), extraídos tradicionalmente por los extractores locales bajo autorización.',
  ),
  Question(
    id: 'cs_q361',
    topicId: 'cs_t3',
    text:
        'En la región de Ayacucho, existe una Reserva Nacional que fue pionera en el manejo exitoso de una especie bandera que estaba al borde de la extinción en los años 60 debido a la caza furtiva por su finísima fibra. El Estado peruano repobló y conservó esta especie en la Reserva Nacional de:',
    options: [
      "Pampa Galeras (Bárbara d'Achille), para proteger a la vicuña.",
      'Lachay, para proteger a la vizcacha.',
      'Titicaca, para proteger al suri (ñandú andino).',
      'Calipuy, para proteger al guanaco.',
      'Junín, para proteger a la maca andina silvestre.',
    ],
    correctAnswer: 0,
    explanation:
        'La Reserva Nacional Pampa Galeras es el emblema de la conservación de la vicuña. Se estableció para repoblar la especie (de la cual quedaban pocos miles a nivel nacional), permitiendo que hoy las comunidades se beneficien tras la esquila viva (chaccu).',
  ),
  Question(
    id: 'cs_q362',
    topicId: 'cs_t3',
    text:
        "La categoría de 'Santuario Histórico' (área de Uso Indirecto) tiene una particularidad frente a otras ANP, pues además de conservar un ecosistema o biodiversidad importante, tiene la finalidad de:",
    options: [
      'Permitir la venta de tierras comunales a constructoras de hoteles de lujo.',
      'Conservar espacios que contienen bienes monumentales de inmenso valor arqueológico o donde se desarrollaron sucesos heroicos e históricos para la nación.',
      'Explotar depósitos de hidrocarburos utilizando tecnología de fracking (fracturación hidráulica).',
      'Crear zoológicos urbanos y jardines botánicos cerrados en medio de la ciudad capital.',
      'Legalizar el cultivo intensivo y exportación de la hoja de coca sin intervención de ENACO.',
    ],
    correctAnswer: 1,
    explanation:
        'El Santuario Histórico protege el entorno natural de hitos culturales. Ejemplos claros son Machupicchu (resguarda la llaqta inca y el bosque de nubes) o el Santuario Histórico de la Pampa de Ayacucho (donde se selló la independencia).',
  ),
  Question(
    id: 'cs_q363',
    topicId: 'cs_t3',
    text:
        'En la región andina (Pasco), se ubica el Santuario Nacional de Huayllay. Este lugar no protege grandes animales majestuosos ni ruinas arqueológicas preincas, sino que es famoso mundialmente por resguardar:',
    options: [
      'Un bosque de piedras (formaciones rocosas esculpidas por milenios de erosión eólica e hídrica y glaciar) de impresionante valor paisajístico y geológico.',
      'La mayor mina de uranio enriquecido a cielo abierto de Sudamérica.',
      'Un inmenso lago artificial utilizado para enfriar reactores nucleares.',
      'Un conjunto de volcanes permanentemente activos y en erupción.',
      'Las únicas cataratas del país que fluyen con agua termal hirviendo.',
    ],
    correctAnswer: 0,
    explanation:
        "El Santuario Nacional de Huayllay ('El bosque de piedras de Pasco') protege increíbles farallones y pilares de roca volcánica modelados por el viento y el agua, conformando figuras caprichosas a más de 4,300 metros de altitud.",
  ),
  Question(
    id: 'cs_q364',
    topicId: 'cs_t3',
    text:
        'La Reserva Nacional del Titicaca (Puno) cumple la función primordial de proteger la flora y fauna endémica del lago navegable más alto del mundo. Un recurso ecológico y cultural clave resguardado en esta reserva, utilizado por la etnia Uro para construir sus islas artificiales y por los campesinos como forraje, es:',
    options: [
      'El bambú amazónico maderable.',
      'La puya Raimondi de florecimiento centenario.',
      'La Totora (Schoenoplectus tatora), una planta acuática perenne del ecosistema circunlacustre.',
      'Los mangles negros de raíz zancuda.',
      'El algodón nativo de colores oscuros.',
    ],
    correctAnswer: 2,
    explanation:
        'La totora es el elemento articulador del ecosistema lacustre del Titicaca. Alberga a aves zambullidoras endémicas (como el keñola), y es usada por los humanos (Uros) para construir viviendas, embarcaciones y como forraje de ganado (uso directo).',
  ),
  Question(
    id: 'cs_q365',
    topicId: 'cs_t3',
    text:
        "En la Ley de Áreas Naturales Protegidas, existe la figura de 'Zona de Amortiguamiento'. A nivel legal y de gestión, ¿qué significa esta delimitación técnica adyacente a un Parque o Reserva?",
    options: [
      'Es el área designada específicamente para depositar los desechos tóxicos de la región para que no entren al parque.',
      'Es una franja territorial limítrofe (exterior) a la ANP donde las actividades humanas requieren permisos especiales u opiniones técnicas del SERNANP, para garantizar que el impacto ambiental no dañe indirectamente a la zona protegida.',
      'Es una zona militarizada donde se dispara a cualquier invasor sin juicio previo.',
      'Es una pista de carreras asfaltada que rodea perimetralmente a todas las ANP del país.',
      'Es un terreno privado de los guardaparques donde pueden cazar libremente.',
    ],
    correctAnswer: 1,
    explanation:
        "Las Zonas de Amortiguamiento actúan como un 'escudo' o área de transición. Aunque no son parte intrínseca del Parque, no se pueden abrir grandes minas o fábricas contaminantes allí sin la estricta aprobación del Estado, pues afectarían el ecosistema protegido.",
  ),
  Question(
    id: 'cs_q366',
    topicId: 'cs_t3',
    text:
        'El Parque Nacional Río Abiseo (San Martín), inscrito como sitio de Patrimonio Mundial Mixto (Natural y Cultural) por la UNESCO, es célebre porque en sus impenetrables bosques nublados se descubrió un importantísimo complejo arqueológico preinca perteneciente a la cultura Chachapoyas. Este complejo es:',
    options: [
      'Kuélap.',
      'Gran Pajatén.',
      'Vilcashuamán.',
      'Choquequirao.',
      'Pikillaqta.',
    ],
    correctAnswer: 1,
    explanation:
        'El Parque Nacional Río Abiseo es de los pocos lugares del mundo que es Patrimonio Mixto. Protege los bosques de neblina (hogar del mono choro de cola amarilla, redescubierto allí) y las ruinas circulares del Gran Pajatén, descubiertas en los años 60.',
  ),
  Question(
    id: 'cs_q367',
    topicId: 'cs_t3',
    text:
        'El Santuario Nacional Tabaconas Namballe, ubicado en la región Cajamarca frontera con Ecuador, es la única Área Natural Protegida del Perú que resguarda una muestra representativa del ecosistema paramero (el Páramo). Este ecosistema de neblina constante, muy diferente a la Puna seca, alberga a especies gravemente amenazadas como:',
    options: [
      'La anaconda verde gigante y el caimán negro.',
      'El lobo marino y la nutria marina o chungungo.',
      'El tapir de altura (pinchaque) y el oso de anteojos.',
      'La vicuña peladilla y el suri.',
      'Los flamencos rosados y los guanay.',
    ],
    correctAnswer: 2,
    explanation:
        'El páramo andino es un bioma muy húmedo y pantanoso de altura (distinto de la estepa puna de Puno). Es el hogar del oso andino y del tapir de montaña o pinchaque (Tapirus pinchaque), un mamífero en grave peligro de extinción endémico de la frontera norte.',
  ),
  Question(
    id: 'cs_q368',
    topicId: 'cs_t3',
    text:
        "Existe una categoría del SINANPE llamada 'Coto de Caza'. A diferencia de las demás áreas, el propósito del Estado en un Coto de Caza (ej. El Angolo en Piura) es:",
    options: [
      'Prohibir tajantemente la caza de cualquier animal, incluso los insectos.',
      'Criar animales de granja artificiales en cautiverio para consumo en restaurantes de lujo.',
      'Aprovechar la fauna silvestre de manera cinegética (caza deportiva regulada), donde los cazadores pagan altas tarifas al Estado para cazar cuotas estrictas de especímenes macho viejos (ej. venado de cola blanca), financiando la conservación del resto.',
      'Utilizar el área como polígono de tiro para las pruebas de artillería pesada del Ejército peruano.',
      'Capturar animales vivos para exportarlos ilegalmente a circos extranjeros.',
    ],
    correctAnswer: 2,
    explanation:
        'La caza deportiva racionalizada (Coto de caza de Uso Directo) es una herramienta de conservación. Se establecen cuotas precisas y los ingresos por licencias permiten financiar el patrullaje antipoaching de todo el ecosistema (bosque seco).',
  ),
  Question(
    id: 'cs_q369',
    topicId: 'cs_t3',
    text:
        "La Reserva Nacional de Lachay (Lima) protege un ecosistema costero singular que florece espectacularmente ('reverdece') solo durante el invierno (agosto-octubre) debido a la condensación de las espesas neblinas del Océano Pacífico, sobreviviendo el resto del año en latencia desértica. Este frágil ecosistema se denomina:",
    options: [
      'Oasis lacustre.',
      'Sabana de palmeras.',
      'Lomas costeras.',
      'Bosque tropical del Pacífico.',
      'Manglar continental relicto.',
    ],
    correctAnswer: 2,
    explanation:
        'Las Lomas (ej. Lomas de Lachay, Lucumo) son formaciones vegetales endémicas del desierto costero peruano-chileno. Viven exclusivamente de la humedad de las neblinas invernales arrastradas por los vientos alisios.',
  ),
  Question(
    id: 'cs_q370',
    topicId: 'cs_t3',
    text:
        "Las 'Reservas Comunales' son áreas de Uso Directo creadas por el Estado con un enfoque especial en derechos indígenas. La característica jurídica distintiva de una Reserva Comunal frente a una Reserva Nacional convencional es que:",
    options: [
      'Están diseñadas para la extracción industrial de maderas preciosas a gran escala.',
      'El Estado renuncia a su soberanía y se independizan formando nuevas repúblicas.',
      'La gestión y administración del área es compartida (co-gestión) entre el SERNANP y las poblaciones indígenas locales vecinas, quienes tienen el derecho exclusivo al aprovechamiento tradicional de sus recursos para su subsistencia.',
      'Solo pueden ser administradas por corporaciones privadas extractoras de oro.',
      'Se permite el cultivo a gran escala de plantas alucinógenas y narcóticas para el libre mercado.',
    ],
    correctAnswer: 2,
    explanation:
        'Las Reservas Comunales (ej. RC Yanesha, RC Asháninka) garantizan la seguridad alimentaria y cultural de los pueblos originarios. El Estado (SERNANP) las co-administra a través de Ejecutores de Contrato de Administración conformados por las propias comunidades nativas.',
  ),
  Question(
    id: 'cs_q371',
    topicId: 'cs_t3',
    text:
        'El Parque Nacional Bahuaja Sonene, situado entre Madre de Dios y Puno, no solo protege selva baja y sabana. Su creación en los años 90 sirvió para proteger un ecosistema único en el Perú, el único reducto patrio de praderas inundables tropicales que alberga a la onza (jaguar), al ciervo de los pantanos y al lobo de crin. Este bioma se denomina:',
    options: [
      'Páramo tropical andino alto.',
      'Desierto de dunas vivas amazónicas.',
      'Sabana de Palmeras (Pampas del Heath).',
      'Bosque seco relicto del escudo guayanés.',
      'Bosque de coníferas boreales (pinos y abetos de niebla).',
    ],
    correctAnswer: 2,
    explanation:
        "Bahuaja Sonene protege el extremo noroccidental de la gran Sabana sudamericana. Las 'Pampas del Heath' conforman una llanura de pastos altos y palmeras (sin bosque denso), hogar del singular 'lobo de crin' de patas larguísimas, exclusivo de este bioma en el Perú.",
  ),
  Question(
    id: 'cs_q372',
    topicId: 'cs_t3',
    text:
        'Entre las herramientas de ordenamiento territorial, el Estado peruano puede declarar temporalmente una zona bajo protección mientras realiza estudios científicos para definir si debe ser Parque, Reserva o Santuario, paralizando el otorgamiento de concesiones extractivas. Esta categoría técnica temporal o transitoria es:',
    options: [
      'Área Natural de Conservación Definitiva.',
      'Santuario Ecológico Efímero.',
      'Zona Reservada.',
      'Parque Regional Provisional.',
      'Coto de Caza Transitorio para Exploración.',
    ],
    correctAnswer: 2,
    explanation:
        "Una 'Zona Reservada' (ej. antigua ZR Illescas, hoy Reserva Nacional) es una figura precautoria. El SERNANP congela el área mientras reúne la información biológica y negocia con las poblaciones para definir la categorización definitiva (si será de uso directo o indirecto).",
  ),
  Question(
    id: 'cs_q373',
    topicId: 'cs_t3',
    text:
        'La cuenca del río Putumayo es la frontera natural con Colombia. Allí, el Perú ha consolidado una franja de conservación gigantesca en Loreto (categorizada en 2018 como Parque Nacional Yaguas) caracterizada por ser una selva llana virgen y poseer la mayor diversidad de peces de agua dulce del Perú. Su estado jurídico prohíbe:',
    options: [
      'La navegación en embarcaciones a motor, volviendo obligatorio el uso exclusivo de canoas a remo.',
      'Toda explotación forestal o petrolera, minería aluvial de oro o caza comercial, por ser un Parque Nacional de Uso Indirecto (intangible).',
      'La respiración del aire sin el uso de mascarillas de carbono filtrantes obligatorias.',
      'La pesca deportiva de liberación (catch and release) por la élite gubernamental.',
      'La toma de fotografías satelitales del dosel arbóreo por razones de seguridad militar.',
    ],
    correctAnswer: 1,
    explanation:
        "Como Parque Nacional, Yaguas es de 'Uso Indirecto'. Esto bloquea legalmente la entrada de mineros ilegales (dragas auríferas) y concesiones forestales depredadoras, protegiendo a las comunidades indígenas aledañas y a la inmensa biodiversidad ictiológica.",
  ),
  Question(
    id: 'cs_q374',
    topicId: 'cs_t3',
    text:
        'La Reserva Paisajística es un área de Uso Directo. Un claro ejemplo es la Reserva Paisajística Nor Yauyos Cochas (Lima y Junín). Su objetivo de conservación difiere del de un Parque Nacional virgen porque busca proteger:',
    options: [
      'Exclusivamente las reservas probadas de uranio geológico para uso del Estado central.',
      'Una relación armoniosa prolongada en el tiempo entre el hombre y la naturaleza, conservando tanto la diversidad biológica (ríos cristalinos, cascadas) como las tradiciones culturales (andenes preincas, ganadería tradicional local).',
      'La erradicación y expulsión forzosa de todas las comunidades rurales para reforestar el área artificialmente con eucalipto.',
      'Un zoológico cerrado con animales exóticos africanos importados (leones, cebras).',
      'La crianza en masa de insectos como base de la nueva gastronomía urbana.',
    ],
    correctAnswer: 1,
    explanation:
        "La Reserva Paisajística (ej. Subcuenca del Cotahuasi o Nor Yauyos Cochas) reconoce que el paisaje andino es un 'producto cultural'. Conserva la belleza escénica natural (cascadas) integrada indisolublemente con la obra humana milenaria (terrazas de cultivo incas), promoviendo que las comunidades vivan de un turismo sostenible.",
  ),
  Question(
    id: 'cs_q375',
    topicId: 'cs_t3',
    text:
        'El Perú posee un sistema complementario de conservación que permite a los ciudadanos particulares dueños de un bosque, o a las comunidades campesinas tituladas, solicitar voluntariamente al Estado que reconozca sus predios como áreas protegidas por un lapso de tiempo o a perpetuidad, prohibiendo expropiaciones invasivas. Estas áreas se denominan:',
    options: [
      'Bosques Nacionales Intocables del Presidente.',
      'Zonas Militares de Resguardo de Fronteras Vivas.',
      'Áreas de Conservación Privada (ACP) y Áreas de Conservación Regional (ACR).',
      'Reservas Municipales de Hidrocarburos Secundarios.',
      'Fideicomisos Ecológicos Extranjeros en territorio peruano.',
    ],
    correctAnswer: 2,
    explanation:
        'Las ACP y ACR son fundamentales porque complementan al SINANPE (áreas de nivel nacional). Un propietario de una hacienda cafetalera puede destinar 1,000 hectáreas de bosque de neblina virgen como ACP (ej. Chaparrí en Lambayeque), comprometiéndose legalmente ante el SERNANP a conservarla.',
  ),
  Question(
    id: 'cs_q376',
    topicId: 'cs_t3',
    text:
        'El Santuario Nacional Lagunas de Mejía, ubicado en la costa de Arequipa, protege uno de los escasos humedales costeros del Pacífico sudamericano. La relevancia internacional de estos ecosistemas de estuarios, totorales y pantanos, reconocidos a menudo bajo la Convención Ramsar, radica en que son:',
    options: [
      'Fuentes exclusivas de agua potable destilada para las ciudades desérticas.',
      'Estaciones de descanso y alimentación indispensables (paradas técnicas vitales) para cientos de especies de aves migratorias que viajan desde el Ártico norteamericano (Tundra) hacia la Patagonia.',
      'Yacimientos inagotables de gas metano subterráneo extraíble ecológicamente.',
      'Piscinas naturales de azufre curativo recomendadas para pacientes con lepra.',
      'La cuna evolutiva del guanaco costero que luego migró a los andes.',
    ],
    correctAnswer: 1,
    explanation:
        "Los humedales costeros (Mejía, Villa, Puerto Viejo) son verdaderos 'oasis de descanso'. Las aves limícolas (playeros, gaviotas de Franklin) que migran miles de kilómetros desde Alaska hacia el sur, necesitan de estos cuerpos de agua dulce/salobre repletos de invertebrados para reponer energía. Si se secan, las aves mueren.",
  ),
  Question(
    id: 'cs_q377',
    topicId: 'cs_t3',
    text:
        "La Cordillera del Cóndor (Frontera Perú-Ecuador) fue escenario del último conflicto bélico sudamericano (Guerra del Cenepa en 1995). Tras el Acta de Brasilia (Acuerdo de Paz), ambos países resolvieron sus disputas y establecieron en la zona en litigio los 'Parques de la Paz'. En el lado peruano, la conservación de esta abrupta cordillera relicto se consolidó mediante la creación de:",
    options: [
      'El Parque Nacional Cerros de Amotape y el Santuario Manglares.',
      'El Parque Nacional Ichigkat Muja - Cordillera del Cóndor y la Zona Reservada Santiago-Comaina.',
      'El Santuario Histórico Pampas de la Quinua.',
      'El Bosque de Protección Alto Mayo.',
      'La Reserva Nacional de Calipuy.',
    ],
    correctAnswer: 1,
    explanation:
        'La diplomacia de conservación (Acuerdo de Paz) derivó en establecer ANPs contiguas para proteger los bosques nublados endémicos de la Cordillera del Cóndor (cuna del río Cenepa) de la depredación minera, sellando una zona desmilitarizada protegida biológicamente.',
  ),
  Question(
    id: 'cs_q378',
    topicId: 'cs_t3',
    text:
        "El término 'Especie Bandera' (Flagship species) es una herramienta de marketing ecológico utilizada por el SERNANP para obtener financiamiento y simpatía pública. Esto se logra promoviendo la conservación de un animal carismático, lo que indirectamente protege a todo su ecosistema. En el Perú, una especie bandera indiscutible del Bosque de Neblina andino (y de ANPs como Machupicchu) es:",
    options: [
      'La anchoveta (Engraulis ringens).',
      'El caimán negro (Melanosuchus niger).',
      'El pingüino de Humboldt (Spheniscus humboldti).',
      'El oso de anteojos u oso andino (Tremarctos ornatus).',
      'El sapo gigante del Titicaca (Telmatobius culeus).',
    ],
    correctAnswer: 3,
    explanation:
        "El oso de anteojos, por su carisma y necesidad de un rango territorial inmenso (gran parche de bosque nublado e intacto), es la especie bandera ideal. Protegerlo a él implica proteger (como especie 'paraguas') miles de hectáreas de orquídeas, aves y anfibios que viven en su bosque.",
  ),
  Question(
    id: 'cs_q379',
    topicId: 'cs_t3',
    text:
        'La Ley Forestal y de Fauna Silvestre peruana categoriza a las especies en vías de extinción en función del riesgo. Cuando una especie está enfrentando un riesgo altísimo de extinción en estado silvestre a corto plazo por drástica reducción de hábitat o cacería descontrolada, y su extracción (salvo para investigación estricta) es un delito grave penalizado por el Estado, se le categoriza oficialmente como:',
    options: [
      'Especie Exótica Invasora Comercial.',
      'Especie Casi Amenazada (NT) por fluctuación estacional.',
      'Especie en Peligro Crítico (CR) o en Vías de Extinción.',
      'Especie de Preocupación Menor (LC) susceptible de caza deportiva.',
      'Especie de Fauna Silvestre con Valor Agregado Maderable.',
    ],
    correctAnswer: 2,
    explanation:
        "La legislación peruana (en línea con la UICN y CITES) lista a especies como el mono choro de cola amarilla o la pava aliblanca como 'En Peligro Crítico'. Su caza, transporte y comercio (tráfico ilegal) constituye un delito penal severo combatido por la Policía Ecológica y la fiscalía ambiental.",
  ),
  Question(
    id: 'cs_q380',
    topicId: 'cs_t3',
    text:
        'El Parque Nacional Cerros de Amotape, ubicado en Tumbes y Piura, es el núcleo principal de la Reserva de Biósfera del Noroeste. El ecosistema único e inmensamente vulnerable a la sequía y la deforestación (tala de algarrobos y hualtacos) que protege de forma intangible es:',
    options: [
      'El desierto costero absoluto desprovisto de vegetación (como Ica).',
      'El bosque seco ecuatorial pacífico.',
      'El páramo altoandino húmedo glacial.',
      'La selva tropical monzónica baja de Loreto.',
      'El arrecife de coral del Océano Pacífico profundo.',
    ],
    correctAnswer: 1,
    explanation:
        "Amotape resguarda el mejor remanente de 'Bosque Seco Ecuatorial', un ecosistema que pierde sus hojas (caducifolio) en la larga época seca (casi 9 meses) y reverdece explosivamente con las efímeras lluvias de verano, siendo hogar del venado gris, el sajino y el cocodrilo de Tumbes.",
  ),
  Question(
    id: 'cs_q381',
    topicId: 'cs_t3',
    text:
        "Existe una categoría peculiar llamada 'Bosque de Protección' (Área de Uso Directo). Su objetivo fundamental no es resguardar un animal específico, sino proteger un factor físico-geográfico. ¿Cuál es la función técnico-ambiental de un Bosque de Protección (ej. Puquio Santa Rosa, Alto Mayo)?",
    options: [
      'Servir como plantación forestal exclusiva para abastecer de papel a las imprentas estatales del Estado.',
      'Garantizar la cobertura boscosa intacta en las cuencas altas y cabeceras de ríos, laderas escarpadas, para proteger los suelos contra la erosión extrema, evitar los destructivos huaicos y asegurar la provisión de agua limpia hacia los valles agrícolas inferiores.',
      'Resguardar zonas mineras ricas en diamantes de superficie.',
      'Proteger áreas delimitadas para la experimentación con armas bacteriológicas militares extranjeras en completo aislamiento.',
      'Alojar centros de rehabilitación psiquiátrica amurallados en medio de la espesura del bosque andino.',
    ],
    correctAnswer: 1,
    explanation:
        "El bosque actúa como una 'esponja'. Sus raíces retienen la tierra y el agua de lluvia (infiltración), previniendo avalanchas y sequías. Los Bosques de Protección (ej. San Matías - San Carlos) se declaran para defender las cabeceras de cuenca vitales para las poblaciones de los valles.",
  ),
  Question(
    id: 'cs_q382',
    topicId: 'cs_t3',
    text:
        'El Santuario Nacional Calipuy y la contigua Reserva Nacional de Calipuy, ubicados en la sierra del departamento de La Libertad (Santiago de Chuco), fueron creados principalmente para conservar dos de las especies andinas más emblemáticas y amenazadas de la flora y fauna peruana. Estas son, respectivamente:',
    options: [
      'La uña de gato (planta curativa) y el otorongo (jaguar andino).',
      'La flor de amancaes costera y el caballo peruano de paso fino.',
      'La imponente Puya Raimondi (la bromelia gigante de inflorescencia titánica) y el Huanaco o Guanaco, el camélido silvestre más esbelto y amenazado.',
      'La caoba de sierra y la tortuga gigante de las Galápagos introducida en el Perú.',
      'El algodón nativo de siete colores y el zorro costeño Sechurano.',
    ],
    correctAnswer: 2,
    explanation:
        'Calipuy es el hogar de los rodales más grandes y densos de la Puya Raimondi (titanca), que florece una vez cada 100 años antes de morir. Asimismo, es el último gran refugio del guanaco silvestre en el norte del Perú, mermado por la caza desmedida.',
  ),
  Question(
    id: 'cs_q383',
    topicId: 'cs_t3',
    text:
        'Para un miembro de la Policía de Turismo o de la Policía Ecológica (Dirección de Medio Ambiente - DIRMEAMB), es crucial conocer los delitos ambientales. Cuando traficantes internacionales extraen (sin permiso CITES ni de SERFOR) guacamayos amazónicos, monos frailes o madera caoba para venderlos, la acción antijurídica tipificada penalmente es:',
    options: [
      'Infracción municipal de comercio ambulatorio de mascotas no desparasitadas.',
      'Tráfico ilegal de especies de flora y fauna silvestre (biopiratería y extracción depredatoria), constituyendo un grave delito contra los Recursos Naturales.',
      'Evasión fiscal (contrabando) sancionada solo por aduanas, sin implicancias biológicas.',
      'Expropiación indebida de bienes corporativos de la comunidad nativa.',
      'Falta leve contra la salubridad y la higiene urbana.',
    ],
    correctAnswer: 1,
    explanation:
        'El tráfico ilícito de fauna (y madera protegida) es el tercer negocio ilícito más lucrativo del mundo después del narcotráfico y trata de personas. El Código Penal peruano lo castiga con severas penas privativas de libertad al atentar directamente contra el patrimonio natural de la Nación.',
  ),
  Question(
    id: 'cs_q384',
    topicId: 'cs_t3',
    text:
        'El Perú ha ratificado la Convención de Ramsar (1971), un tratado intergubernamental crucial para el mantenimiento del equilibrio hidrológico. Al inscribir el Estado peruano a la Reserva Nacional del Titicaca, los Manglares de Tumbes o el Santuario Nacional Lagunas de Mejía en esta lista, se compromete internacionalmente a conservar:',
    options: [
      'Exclusivamente los picos nevados por encima de los 5,000 m.s.n.m. para evitar el derretimiento de glaciares.',
      'Todos los yacimientos arqueológicos de adobe que puedan ser erosionados por los vientos huracanados oceánicos.',
      'La biodiversidad microbiana de los desiertos áridos carentes de lluvia.',
      'Los humedales (ecosistemas de pantanos, marismas, lagos, esteros) de Importancia Internacional, en especial como hábitat de aves acuáticas migratorias.',
      'Los bosques de coníferas boreales y taiga, y los fiordos antárticos congelados en los Andes del Sur.',
    ],
    correctAnswer: 3,
    explanation:
        'La Convención de Ramsar (Irán) es el único tratado global centrado en un solo ecosistema: los humedales (wetlands). Proteger pantanos, turberas (bofedales andinos) y manglares es crítico por su capacidad de almacenar agua dulce y secuestrar enormes cantidades de carbono, combatiendo el cambio climático global.',
  ),
  Question(
    id: 'cs_q385',
    topicId: 'cs_t3',
    text:
        'En el año 2001, tras la caída del régimen fujimorista y como parte de los compromisos de paz del Tratado de Itamaraty, el Perú creó el Parque Nacional Cordillera Azul, situado entre San Martín, Loreto, Ucayali y Huánuco. Una de las razones principales (además de la biodiversidad) para consolidar rápidamente esta inmensa área de selva montañosa como intangible fue:',
    options: [
      'Frenar el avance destructivo de los cultivos ilegales de coca, los carteles del narcotráfico y la consecuente tala ilegal (desbosque masivo) en las estribaciones andino-amazónicas (selva alta).',
      'Prohibir que los turistas extranjeros fotografiaran instalaciones militares secretas de cohetes balísticos camuflados.',
      'Descubrir inmensas canteras de diamantes rosados que requerían protección estatal para su extracción a tajo abierto controlada.',
      'Alojar prisioneros subversivos en prisiones de máxima seguridad rodeadas por el denso bosque impenetrable y vigiladas por drones láser.',
      'Frenar el desvío de los ríos orientales hacia las pampas de Nazca en un proyecto transandino ilegal.',
    ],
    correctAnswer: 0,
    explanation:
        "Cordillera Azul ('el paraíso en la loma del diablo') se protegió de urgencia. Durante los 80s y 90s, el Huallaga y adyacencias eran asolados por la siembra ilegal de coca, deforestación masiva (por colonos y mafias) y terrorismo. El Parque frenó la frontera agrícola y blindó el ecosistema de selva montañosa o ceja de selva de la aniquilación inminente.",
  ),
  Question(
    id: 'cs_q386',
    topicId: 'cs_t3',
    text:
        'La Biopiratería es el acceso, uso o apropiación ilícita del patrimonio genético (ADN, enzimas vegetales) y de los conocimientos tradicionales indígenas sobre las propiedades de plantas nativas andinas y amazónicas. ¿Qué planta oriunda del Perú (y de los andes), que es una raíz vigorizante y nutritiva, sufrió un grave intento de biopiratería cuando corporaciones japonesas y estadounidenses intentaron patentar extractos de ella como invento propio?',
    options: [
      'El plátano seda criollo tropical.',
      'La caña de azúcar rubia.',
      'El algodón tangüis híbrido costero.',
      'La Maca (Lepidium meyenii).',
      'El café robusta de exportación.',
    ],
    correctAnswer: 3,
    explanation:
        'La maca, un tubérculo cultivado por los antiguos peruanos en las gélidas punas de Junín y Pasco por sus probadas propiedades nutricionales y energizantes, fue objeto de patentes fraudulentas en EE.UU. El Estado peruano (vía INDECOPI) debió litigar internacionalmente para anular las patentes extranjeras sobre un recurso nativo milenario. Otras víctimas han sido el sacha inchi, uña de gato y yacón.',
  ),
  Question(
    id: 'cs_q387',
    topicId: 'cs_t3',
    text:
        'Dentro del Sistema Nacional de Evaluación de Impacto Ambiental (SEIA), antes de que una transnacional apruebe perforar o construir una carretera que roce la Zona de Amortiguamiento de una Reserva Nacional, debe presentar obligatoriamente un instrumento técnico para demostrar que no aniquilará el entorno. Este documento público preventivo es el:',
    options: [
      'Certificado de Antecedentes Penales Corporativo Internacional.',
      'Estudio de Impacto Ambiental (EIA), detallado o semidetallado, sujeto a la aprobación del MINAM (Senace) y a la opinión técnica vinculante del SERNANP.',
      'Bono Soberano de Deuda Ecológica a 30 años, negociado en la bolsa de valores americana.',
      'Contrato de Concesión Privada vitalicia exenta de toda fiscalización estatal por decreto supremo.',
      'Informe Sociológico de Migraciones Indígenas Temporales y Permanentes.',
    ],
    correctAnswer: 1,
    explanation:
        "El Estudio de Impacto Ambiental (EIA) es el filtro legal y técnico clave. El SENACE (del Ministerio del Ambiente) no aprueba proyectos extractivos masivos ('megaproyectos') sin que la empresa demuestre cómo prevendrá, mitigará y compensará la contaminación (gases, vertimientos tóxicos o destrucción de hábitat forestal). Si SERNANP señala que daña la Reserva contigua irremediablemente, el proyecto se rechaza (opinión vinculante favorable obligatoria).",
  ),
  Question(
    id: 'cs_q388',
    topicId: 'cs_t3',
    text:
        'En Tumbes existe una ANP de uso directo (Reserva Nacional) orientada al manejo, extracción selectiva y recuperación de bosques (viveros forestales) para aprovechamiento socioeconómico local ordenado, combatiendo la tala destructiva. El recurso que más se protege del contrabando maderero hacia Ecuador en esta Reserva es el bosque nativo. El nombre de esta ANP es:',
    options: [
      'Santuario de Manglares de Zarumilla.',
      'Reserva Nacional de Tumbes (parte de la Biósfera del Noroeste).',
      'Parque Nacional Cerros de Amotape fronterizo.',
      'Reserva Comunal Machiguenga tropical.',
      'Santuario Histórico Batalla de Zarumilla del 41.',
    ],
    correctAnswer: 1,
    explanation:
        "La Reserva Nacional de Tumbes complementa al Parque Amotape. Al ser de 'uso directo', las comunidades locales reciben autorizaciones (concesiones) para el manejo de bosques y cacería de subsistencia, promoviendo la conservación mediante un uso ordenado (ej. madera seca, miel de abeja, algarrobina) que es más rentable que talar todo en una noche de forma ilícita.",
  ),
  Question(
    id: 'cs_q389',
    topicId: 'cs_t3',
    text:
        'La Reserva Nacional San Fernando (Ica) y la Reserva Nacional Illescas (Piura) comparten un rasgo geomorfológico y biológico que las hace sumamente valiosas y únicas en su latitud. Ambas áreas naturales protegidas son remansos marinos costeros donde ocurre el extraordinario fenómeno de:',
    options: [
      'Ser playas de anidación exclusiva masiva de flamencos y cocodrilos marinos exóticos australianos.',
      'Tener agua marina dulce debido a la influencia directa e ininterrumpida de los ríos amazónicos subterráneos.',
      'La convergencia y punto de transición de la fría Corriente Peruana (Humboldt) rica en nutrientes pelágicos (anchoveta), y los lobos, con aguas más cálidas, siendo hogar esporádico o transitorio del cóndor andino (Illescas/San Fernando) que desciende a la playa a carroñar y de la ballena jorobada.',
      'Albergar yacimientos gigantescos de petróleo aflorando a la superficie (breas) libre de arena.',
      'Ser los únicos arrecifes de coral tropicales puros a nivel mundial sin acidificación alguna.',
    ],
    correctAnswer: 2,
    explanation:
        'Illescas y San Fernando son ecosistemas marino-costeros formidables donde la vida de la puna y el mar colisionan. En San Fernando y Paracas (y Punta San Juan) es común el asombroso avistamiento de cóndores andinos alimentándose de las placentas de los lobos marinos varados o carroña costera y donde, al mismo tiempo, los pingüinos y las ballenas convergen. Son zonas de alta turbulencia y surgencia (upwelling) nutricional planctónica masiva.',
  ),
  Question(
    id: 'cs_q390',
    topicId: 'cs_t3',
    text:
        'Para resguardar el corazón lítico del imperio, el Estado declaró la máxima jerarquía cultural y ecológica sobre la mítica ciudadela inca descubierta científicamente por Hiram Bingham. El Santuario Histórico de Machupicchu no solo resguarda los impresionantes andenes, los adoratorios solares y el Intihuatana, sino también:',
    options: [
      'La mayor mina de uranio de exportación, celosamente guardada por los sacerdotes.',
      "Un entorno paisajístico de bosque húmedo de neblina ('ceja de selva') sumamente frágil que alberga especies orquideológicas endémicas, al oso de anteojos andino (Tremarctos ornatus) y al escurridizo gallito de las rocas nacional.",
      'Un desierto salino andino usado exclusivamente para procesar chuño y sal.',
      'Un puerto militar aéreo para dirigibles camuflado en las laderas orientales montañosas.',
      'Los restos de un acueducto romano gigante que subía el agua por fuerza centrífuga.',
    ],
    correctAnswer: 1,
    explanation:
        'La genialidad del Santuario Histórico (mixto) es que entiende que Machupicchu perdería el 50% de su misticismo y belleza si las montañas de alrededor estuvieran peladas (deforestadas). El Santuario resguarda el entorno silvestre (decenas de miles de hectáreas de orquídeas y fauna amenazada) en la cuenca del Urubamba, tan valioso como la misma arquitectura de sillería granítica inca.',
  ),
  Question(
    id: 'cs_q391',
    topicId: 'cs_t3',
    text:
        "Entre el extenso abanico de biomas peruanos, el 'Santuario Nacional de Ampay' destaca como un relicto, es decir, un parche sobreviviente de un bosque ancestral casi desaparecido, localizado en medio de la abrupta topografía del departamento de Apurímac (Abancay). Su principal razón de ser institucional como Área Natural Protegida es la conservación perentoria del majestuoso y gigantesco bosque de:",
    options: [
      'Cedros amazónicos maderables e intocables de hojas rojas perennes.',
      'Eucaliptos australianos adaptados artificialmente para secar el subsuelo montañoso andino.',
      'Algarrobos enanos de altura capaces de producir resina dulce inagotable.',
      'Intimpas (Podocarpus glomeratus), que constituye el mayor bosque de coníferas nativas de los andes centrales que, sin protección gubernamental directa, hubiera sido talado para leña.',
      'Palmeras cocoteras de alta montaña inmunes a las neblinas glaciares nocturnas.',
    ],
    correctAnswer: 3,
    explanation:
        'La Intimpa es una conífera endémica de los Andes. El bosque de Ampay es una isla ecológica verde que sobrevive resguardando esta valiosa madera resinosa que los comuneros estaban aniquilando. Su protección ampara también fauna en peligro vinculada, como tarucas y zorros de alta montaña abanquina.',
  ),
  Question(
    id: 'cs_q392',
    topicId: 'cs_t3',
    text:
        "Un 'Refugio de Vida Silvestre' es una categoría peculiar del SINANPE orientada a proteger un hábitat crítico (frecuentemente transitorio) necesario para sostener y recuperar poblaciones de especies amenazadas, y donde sí es legal intervenir activamente el ecosistema para beneficiar a la fauna (Uso Directo). Un ejemplo limeño famoso es el Refugio de Vida Silvestre Los Pantanos de Villa, vital para:",
    options: [
      'La desparasitación intensiva del ganado lanar vacuno importado de Europa en cuarentena.',
      'El desove masivo comercial de truchas arcoíris salmonadas chilenas en Lima Sur.',
      'Las aves migratorias (gaviotas, playeros, chorlos) y aves residentes que dependen críticamente de los humedales urbanos remanentes del Pacífico para descansar y anidar antes de proseguir sus vuelos continentales.',
      'Aislar especímenes caninos callejeros (perros) potencialmente portadores de rabia.',
      'Mantener un coto de caza de patos exclusivo y reservado a la diplomacia gubernamental extranjera en la capital peruana.',
    ],
    correctAnswer: 2,
    explanation:
        'Los Pantanos de Villa son un humedal natural costero en el balneario sur limeño, fuertemente amenazado por el crecimiento urbano, la basura e industrias invasoras. Fueron categorizados como Refugio (y sitio Ramsar) para asegurar que miles de aves dispongan del espejo de agua necesario para su periplo hemisférico migratorio (Canadá - Patagonia).',
  ),
  Question(
    id: 'cs_q393',
    topicId: 'cs_t3',
    text:
        "El Perú fue mundialmente aclamado (ej. premios de conservación global) cuando en el año 2015 el Estado finalmente declaró intangible, luego de décadas de conflicto minero legal transnacional de hidrocarburos, el 'Parque Nacional Sierra del Divisor' (Loreto y Ucayali). La particularidad geológica y ecosistémica que motivó este clamor conservacionista internacional urgente se debió a que:",
    options: [
      'Poseía el glaciar tropical de tierras planas más grande del hemisferio ecuatorial selvático.',
      "La zona presentaba formidables macizos montañosos y elevaciones volcánicas antiquísimas (conos de contrafuerte como el 'Cono del Ojo') en medio de la gran planicie amazónica rasa, generando endemismo extremo en fauna y flora no descrita por la ciencia biológica occidental, así como la presencia de aborígenes PIACI.",
      "Ocultaba las ruinas hundidas del mítico 'El Dorado' hechas totalmente de oro puro nativo sin amalgama.",
      'Constituía el último campo de batalla histórico de las tropas revolucionarias bolivarianas del siglo XIX contra España en el oriente amazónico peruano.',
      'Albergaba fuentes de petróleo fosilizado que brillaban radioactivamente en la oscuridad total.',
    ],
    correctAnswer: 1,
    explanation:
        "Sierra del Divisor rompe la geografía típica de la llanura amazónica. Es un bloque geológico montañoso antiquísimo que 'divide' las aguas hacia Perú y Brasil. Al estar aislado (islas montañosas de selva densa intacta), se formó flora y fauna endémica excepcional, amenazada directamente por mafias madereras, narcotráfico fronterizo y presión petrolera industrial extractivista.",
  ),
  Question(
    id: 'cs_q394',
    topicId: 'cs_t3',
    text:
        "El SERNANP se enfrenta continuamente a la expansión ilegal y letal para el ecosistema amazónico que ocurre cuando se instalan docenas de enormes 'dragas' fluviales, motores succionadores pesados y lavaderos de grava dentro o en la zona de amortiguamiento (ej. Reserva Tambopata). ¿Qué delito gravísimo perpetran estas mafias mecanizadas que destruye ríos, arrasa los bosques ribereños y extermina peces y pobladores locales originarios con neurotoxinas permanentes?",
    options: [
      'Pesca intensiva artesanal con espineles y redes chilenas de arrastre profundas.',
      'Contrabando transfronterizo aduanero de madera de ébano y diamantes de guerra bolivianos.',
      "La minería aurífera fluvial y de llanura aluvial ('minería ilegal' de oro), que remueve millones de toneladas de subsuelo y contamina el tejido trófico y el lecho hídrico irremediablemente con el vertido industrial de Mercurio líquido tóxico.",
      'Biopiratería sistemática molecular de veneno ofídico de anacondas negras.',
      'Instalación de hidroeléctricas clandestinas con represas de concreto masivo para generar criptomonedas.',
    ],
    correctAnswer: 2,
    explanation:
        "La minería ilegal del oro (La Pampa en Madre de Dios, Tambopata) es la plaga más destructiva de la Amazonía peruana actual. Deforesta millones de hectáreas para extraer oro aluvial. El mercurio (azogue) arrojado al río se vuelve 'metilmercurio' bioacumulable en los peces, causando daños cerebrales y genéticos permanentes e irreversibles a las poblaciones humanas nativas (Enfermedad de Minamata).",
  ),
  Question(
    id: 'cs_q395',
    topicId: 'cs_t3',
    text:
        'La Ley Forestal del Estado Peruano y la regulación del SERNANP prohíben categóricamente la caza, consumo y comercialización de fauna silvestre exótica en mercados urbanos limeños (ej. Mercado Central) bajo el delito tipificado y penalizado de tráfico de fauna. ¿Por qué razón epidemiológica y de salubridad global el Estado peruano persigue este acto de depredación (ej. venta de monos y loros silvestres en jaulas inmundas) más allá de la preocupación conservacionista?',
    options: [
      'Para garantizar el monopolio impositivo del gobierno sobre la dieta carnívora plebeya citadina.',
      "Para evitar zoonosis masivas, dado que los animales de la selva carecen de controles veterinarios sanitarios (vacunaciones), y el contacto directo e ingesta propaga el salto de patógenos virales mortales silvestres ('spillover') originando nuevas pandemias incontrolables virales hacia la raza humana.",
      'Para evitar que la fauna amazónica devore accidentalmente todos los suministros de maíz destinados al subsidio agrícola del gobierno regional.',
      'Simplemente para agradar a organizaciones religiosas veganas foráneas que amenazan con bloquear financieramente la ONU.',
      'Para obligar a los indígenas amazónicos a tributar el excedente cinegético en efectivo al tesoro limeño nacional central.',
    ],
    correctAnswer: 1,
    explanation:
        "El mercado negro ('wet markets' andinos/selváticos) es la incubadora perfecta para las zoonosis (enfermedades de animales transmitidas a humanos, como ocurrió globalmente con los coronavirus del murciélago o pangolín, la fiebre amarilla selvática, o el VIH desde los chimpancés). El tráfico ilegal acarrea animales estresados llenos de virus desconocidos al corazón de metrópolis altamente densas, arriesgando la salud pública continental.",
  ),
  Question(
    id: 'cs_q396',
    topicId: 'cs_t3',
    text:
        "El Perú posee el honor de contar con el 'Santuario Nacional de Megantoni' (Cusco), de imponente belleza topográfica surcado por el majestuoso Pongo de Mainique en el río Urubamba. Este Santuario, de categoría intangible para la extracción industrial de maderas, sirve crucialmente como 'Corredor Ecológico'. El rol biogeográfico fundamental de un Corredor Ecológico andino-amazónico establecido por SERNANP consiste en:",
    options: [
      'Levantar colosales muros ciegos de concreto armado forestal para prohibir que los carnívoros emigren hacia tierras andinas pobladas por alpacas y ovejas ganaderas.',
      'Permitir el flujo genético y la dispersión natural ininterrumpida de plantas y animales grandes (ej. tapires y jaguares) entre varias ANPs aisladas colindantes (ej. unir Manu, Otishi y Vilcabamba), evitando que las especies endogámicas mueran extintas aisladas por consanguinidad genética.',
      'Establecer pistas de aterrizaje clandestinas legalizadas militarmente para el rápido transporte extractivo maderero.',
      'Construir autopistas asfaltadas turísticas de 4 carriles rápidos exclusivas para safaris foráneos a lo largo de todos los parques nacionales peruanos unidos.',
      'Garantizar la transmisión exclusiva de cables de fibra óptica internacionales subterráneos sin oposición comunera indígena posible.',
    ],
    correctAnswer: 1,
    explanation:
        "Un 'Corredor Ecológico' (Conservation Corridor) evita la fragmentación del hábitat. Si los parques (Manu y Otishi) quedan aislados por ciudades o carreteras masivas, las poblaciones de jaguares enferman genéticamente (endogamia por cruce entre hermanos) y mueren. Megantoni sirve de puente verde salvaje para que la fauna cruce las montañas libremente, garantizando la diversidad genética evolutiva del bioma a largo plazo.",
  ),
  Question(
    id: 'cs_q397',
    topicId: 'cs_t3',
    text:
        "Para que un ecosistema se sostenga o regenere tras la actividad forestal o minera, el MINAM ordena la aplicación de mecanismos denominados PAS (Pasivos Ambientales Sostenibles). Sin embargo, un 'Pasivo Ambiental Minero' impune, como los abundantes en las regiones Puno, Ancash o Huancavelica, constituye una de las peores amenazas territoriales. Jurídicamente, se denomina Pasivo Ambiental Minero al (o la):",
    options: [
      'Inversión de capital semilla bursátil hecha por el Estado en refinerías auríferas de gran rentabilidad minera.',
      'Depósito, relavera abandonada, o tajo de minas cerradas (antiguas e informales en muchos casos) cuyos dueños desaparecieron sin reforestar ni sellar el área de mina, provocando drenaje ácido de roca, filtración de metales pesados (plomo/arsénico) al agua y riesgos fatales latentes permanentes para las comunidades andinas que habitan cerca.',
      'Zona estrictamente prohibida donde se guardan temporalmente lingotes de cobre para estabilizar los precios mundiales internacionales comerciales de los commodities.',
      "Impuesto indirecto gravado sobre la exportación del mineral en estado puro ('royalty' ambiental minero estatal anual del tesoro).",
      'Permiso temporal ambiental extraordinario gubernamental concedido para volar (dinamitar) glaciares amenazantes antes de construir la carretera regional.',
    ],
    correctAnswer: 1,
    explanation:
        "El Estado hereda los Pasivos Ambientales Mineros (PAM) (heridas tóxicas supurantes en la tierra) cuando empresas irresponsables quebraron en el siglo XX o los mineros ilegales huyeron sin aplicar un 'Plan de Cierre de Minas' ecológico. Las lluvias lavan estos relaves expuestos (arsénico, cianuro, relaves de cobre oxidados), envenenando y esterilizando lentamente los ríos y pastos de la cuenca (el drenaje ácido) durante siglos.",
  ),
  Question(
    id: 'cs_q398',
    topicId: 'cs_t3',
    text:
        'Existen ciertas ANPs creadas explícitamente para proteger zonas de anidación del guano marino (Isla, Puntas y Guaneras). La Reserva Nacional Sistema de Islas, Islotes y Puntas Guaneras, administrada integralmente, tiene la directriz histórica de proteger de la pesca furtiva a tres especies de aves peruanas endémicas cuya deyección acumulada secada al sol costeño conforma el fertilizante natural de clase mundial (guano). Estas tres aves fundamentales, sostenidas por el banco pelágico de anchovetas peruanas frías, son:',
    options: [
      'El pelícano común gris antártico, el ñandú y la foca elefante sureña.',
      'El guanay asoleado, el piquero (camanay azul) y el alcatraz parduzco común sudamericano pelícano peruanus (pelícano).',
      'La garza bueyera introducida, la gaviota cocinera blanca y el pingüino de Magallanes glacial del estrecho de Magallanes austral.',
      'El flamenco andino rojo (parihuana), el pato zambullidor crestado y la gaviota garuma gris.',
      'El águila pescadora peregrina, el cóndor andino marino y el albatros de las Galápagos.',
    ],
    correctAnswer: 1,
    explanation:
        'El ave guanera más importante y gregaria (productora primaria de guano comercial alto en fósforo/nitrógeno) es el cormorán Guanay, seguido de cerca por el Piquero peruano (lanzador en picada esbelto) y el enorme Pelícano (alcatraz). El Estado peruano (AGRORURAL y SERNANP) debe proteger ferozmente su alimento primordial (la anchoveta) de la sobrepesca pesquera industrial para que estas islas protegidas no queden despobladas de aves (evitando otra crisis del guano como en el Siglo XIX y Niños catastróficos).',
  ),
  Question(
    id: 'cs_q399',
    topicId: 'cs_t3',
    text:
        'En Tumbes y Piura, el Coto de Caza El Angolo colinda muy de cerca con el Parque Nacional Cerros de Amotape. Para que este Coto de Caza y cualquier Reserva Nacional funcione legalmente permitiendo el aprovechamiento socioeconómico por parte de clubes privados y comunidades locales, el SERNANP exige la formulación científica y aprobación rigurosa del llamado:',
    options: [
      'Plan Maestro Policial (PM-P).',
      'Expediente Técnico de Demolición Silvestre.',
      'Plan de Manejo Ambiental Sostenible, que estipula calendarios estrictos, vedas reproductivas biológicas inquebrantables, tallas y cuotas máximas de recolección de caza y pesca que garantizan que la población animal se regenere velozmente sin decaer (aprovechamiento racional).',
      'Tratado de Libre Cacería Exportadora Privada Permanente y Comercial masiva anual.',
      'Bono Municipal de Libre Explotación de Maderas Duras Forestales anual irrestricto.',
    ],
    correctAnswer: 2,
    explanation:
        "Ninguna extracción de 'uso directo' en Reservas o Cotos es desordenada o 'libre'. El 'Plan de Manejo' ('Management Plan' o 'Plan Maestro') es el cerebro legal/biológico de la ANP (basado en estudios poblacionales de ciervos o paiches). Dictamina exactamente cuántos individuos pueden ser cazados (la cuota de saca sostenible biológicamente calculada) para que el capital reproductor forestal natural quede completamente íntegro, manteniendo a raya el agotamiento y la tragedia de los comunes.",
  ),
  Question(
    id: 'cs_q400',
    topicId: 'cs_t3',
    text:
        "Como epílogo a Parques, Santuarios y Reservas: La Constitución Política peruana actualiza doctrinariamente que la conservación de la Biodiversidad Nacional no es un capricho ecológico de moda, sino un 'Deber Primordial del Estado', reconociendo formal y constitucionalmente que todos los peruanos (civiles, militares y policías) gozan irrenunciablemente del derecho humano (y garantía constitucional) a gozar de:",
    options: [
      "Un ingreso monetario estatal minero indirecto mensual automático ('Bono Ecológico').",
      'Tierras selváticas fiscales gratis garantizadas por cada niño nacido en Lima urbana viva para la siembra maderera privada personal.',
      'Una cuota obligatoria hereditaria de carne amazónica de monte diaria fresca.',
      'El libre comercio irrestricto y sin aranceles de todas las especies madereras en peligro del mundo y animales exóticos del CITES sudamericano.',
      'Un ambiente (entorno) sano, equilibrado y ecológicamente adecuado para el desarrollo armonioso integral y digno de la vida humana, como condición básica para la paz social del progreso.',
    ],
    correctAnswer: 4,
    explanation:
        "El Artículo 2° (Inciso 22) de la Constitución consagra un derecho fundamental 'verde' de tercera generación: El Estado y la Policía están obligados a tutelar y reprimir las mafias (minería ilegal, derrames petroleros) porque el aire tóxico y el agua de río envenenada cercenan un derecho humano clave, que es disfrutar de un medio ambiente sano que no atente contra la salud (calidad de vida) de la ciudadanía de la República. El policía ecológico salva vidas persiguiendo a quienes polucionan y destruyen las ANP.",
  ),
  Question(
    id: 'cs_q401',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 1)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q402',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 2)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q403',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 3)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q404',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 4)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q405',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 5)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q406',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 6)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q407',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 7)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q408',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 8)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q409',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 9)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q410',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 10)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q411',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 11)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q412',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 12)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q413',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 13)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q414',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 14)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q415',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 15)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q416',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 16)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q417',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 17)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q418',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 18)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q419',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 19)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q420',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 20)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q421',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 21)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q422',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 22)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q423',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 23)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q424',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 24)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q425',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 25)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q426',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 26)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q427',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 27)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q428',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 28)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q429',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 29)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q430',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 30)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q431',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 31)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q432',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 32)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q433',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 33)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q434',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 34)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q435',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 35)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q436',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 36)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q437',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 37)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q438',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 38)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q439',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 39)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q440',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 40)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q441',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 41)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q442',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 42)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q443',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 43)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q444',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 44)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q445',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 45)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q446',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 46)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q447',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 47)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q448',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 48)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q449',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 49)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q450',
    topicId: 'cs_t3',
    text:
        'FIJA ANP: Organismo encargado de las Áreas Naturales Protegidas: (Var 50)',
    options: ['SERNANP', 'MINAM', 'SUTRAN', 'OSINERGMIN'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q451',
    topicId: 'cs_t4',
    text:
        "El concepto moderno de 'Desarrollo Sostenible' fue acuñado formalmente a nivel internacional en 1987 por la Comisión Mundial sobre el Medio Ambiente y el Desarrollo de la ONU. Este concepto se popularizó mundialmente a través de un documento histórico conocido como:",
    options: [
      'El Protocolo de Kioto.',
      "El Informe Brundtland ('Nuestro Futuro Común').",
      'El Acuerdo de París.',
      'La Carta de la Tierra.',
      'El Tratado Antártico.',
    ],
    correctAnswer: 1,
    explanation:
        "El Informe Brundtland de 1987 definió por primera vez el desarrollo sostenible como 'aquel que satisface las necesidades del presente sin comprometer la capacidad de las futuras generaciones para satisfacer las suyas'.",
  ),
  Question(
    id: 'cs_q452',
    topicId: 'cs_t4',
    text:
        "La definición clásica de 'Desarrollo Sostenible' implica alcanzar un equilibrio armónico entre tres pilares fundamentales que no pueden separarse si se busca el bienestar a largo plazo de la humanidad. Estos tres pilares son:",
    options: [
      'Crecimiento económico, expansión militar y control poblacional.',
      'Crecimiento económico, equidad social y protección ambiental.',
      'Desarrollo tecnológico, hegemonía política y libre mercado.',
      'Conservación estricta, abolición de la minería y subsidios estatales.',
      'Industrialización acelerada, deforestación cero y urbanismo.',
    ],
    correctAnswer: 1,
    explanation:
        'El desarrollo sostenible se apoya en tres dimensiones inseparables: la económica (viabilidad), la social (equidad y justicia) y la ambiental (preservación de los ecosistemas).',
  ),
  Question(
    id: 'cs_q453',
    topicId: 'cs_t4',
    text:
        'El Perú es considerado uno de los países más vulnerables del mundo ante el cambio climático. A nivel geomorfológico e hidrológico, el impacto primario más grave y visible del calentamiento global en los Andes peruanos durante las últimas décadas ha sido:',
    options: [
      'El aumento masivo de nevadas en la costa central.',
      'El surgimiento de nuevos volcanes en la Cordillera Negra.',
      'El retroceso acelerado y la pérdida de masa de los glaciares tropicales de la Cordillera Blanca.',
      'La congelación permanente del Lago Titicaca.',
      'La transformación de la selva amazónica en un desierto gélido.',
    ],
    correctAnswer: 2,
    explanation:
        'El Perú concentra más del 70% de los glaciares tropicales del mundo. Su rápido derretimiento (desglaciación) amenaza directamente el suministro futuro de agua dulce para las ciudades y la agricultura costera.',
  ),
  Question(
    id: 'cs_q454',
    topicId: 'cs_t4',
    text:
        'Para mitigar el cambio climático global, las Naciones Unidas impulsaron en 1997 un acuerdo internacional vinculante para que los países industrializados reduzcan sus emisiones de Gases de Efecto Invernadero (GEI). Este tratado histórico se denomina:',
    options: [
      'Tratado de Versalles.',
      'Acuerdo de Cartagena.',
      'Protocolo de Kioto.',
      'Pacto de Varsovia.',
      'Convención de Ginebra.',
    ],
    correctAnswer: 2,
    explanation:
        'El Protocolo de Kioto (1997) fue el primer gran esfuerzo global vinculante para reducir emisiones de CO2 y otros GEI, sentando las bases para el posterior Acuerdo de París (2015).',
  ),
  Question(
    id: 'cs_q455',
    topicId: 'cs_t4',
    text: "El concepto ecológico de 'Biotopo' se refiere fundamentalmente a:",
    options: [
      'El conjunto de todos los seres vivos que habitan en un ecosistema.',
      'El espacio físico y las condiciones fisicoquímicas (agua, luz, temperatura, suelo) que soportan a una comunidad biológica.',
      'La cadena alimenticia de los mamíferos superiores.',
      'La alteración genética de las semillas para aumentar la producción.',
      'La suma de las huellas de carbono de un país.',
    ],
    correctAnswer: 1,
    explanation:
        'Un ecosistema está formado por la biocenosis (los seres vivos) y el biotopo (el medio físico o inerte como rocas, clima, humedad que los alberga).',
  ),
  Question(
    id: 'cs_q456',
    topicId: 'cs_t4',
    text:
        "En contraposición a la economía lineal tradicional ('extraer, producir, desechar'), el desarrollo tecnológico sostenible promueve un modelo económico que busca mantener el valor de los productos, materiales y recursos en el mercado el mayor tiempo posible, reduciendo al mínimo la generación de residuos. Este modelo se llama:",
    options: [
      'Economía de subsistencia.',
      'Economía circular.',
      'Economía de enclave.',
      'Capitalismo salvaje.',
      'Comunismo agrario.',
    ],
    correctAnswer: 1,
    explanation:
        "La Economía Circular busca cerrar el ciclo de vida de los productos (reducir, reciclar, reutilizar), imitando a la naturaleza donde nada es 'basura' y todo se transforma en insumo.",
  ),
  Question(
    id: 'cs_q457',
    topicId: 'cs_t4',
    text:
        'Para medir el impacto de la actividad humana sobre el planeta, se utiliza un indicador biofísico que calcula la cantidad de superficie ecológica (tierra y agua) necesaria para producir los recursos que consume una población y para absorber los residuos que genera. Este indicador internacional se denomina:',
    options: [
      'Producto Bruto Interno (PBI).',
      'Índice de Desarrollo Humano (IDH).',
      'Huella Ecológica.',
      'Tasa de Mortalidad Infantil.',
      'Coeficiente de Gini.',
    ],
    correctAnswer: 2,
    explanation:
        'La Huella Ecológica mide en hectáreas globales (hag) el impacto ambiental de nuestro estilo de vida, permitiendo saber si consumimos más recursos de los que el planeta puede regenerar.',
  ),
  Question(
    id: 'cs_q458',
    topicId: 'cs_t4',
    text:
        "En la lucha contra el calentamiento global, se fomenta el abandono progresivo de los combustibles fósiles (carbón, petróleo) en favor de las 'Energías Renovables'. Una de estas energías aprovecha la fuerza cinética del viento para generar electricidad mediante aerogeneradores (como en Marcona, Ica). Nos referimos a la:",
    options: [
      'Energía geotérmica.',
      'Energía mareomotriz.',
      'Energía solar fotovoltaica.',
      'Energía eólica.',
      'Energía nuclear de fisión.',
    ],
    correctAnswer: 3,
    explanation:
        'La energía eólica utiliza grandes turbinas para convertir la fuerza del viento en electricidad limpia, siendo el Parque Eólico de Marcona (Wayra I) uno de los más grandes del Perú.',
  ),
  Question(
    id: 'cs_q459',
    topicId: 'cs_t4',
    text:
        'Existe un tipo de gas de efecto invernadero (GEI) de origen artificial, utilizado antiguamente en aerosoles y sistemas de refrigeración, que no solo retiene calor sino que fue el principal causante de la destrucción de la capa de ozono estratosférico (el agujero de ozono). Estos compuestos son los:',
    options: [
      'Clorofluorocarbonos (CFC).',
      'Dióxido de carbono (CO2).',
      'Óxidos de nitrógeno (NOx).',
      'Metano (CH4).',
      'Vapor de agua (H2O).',
    ],
    correctAnswer: 0,
    explanation:
        'Los CFC (clorofluorocarbonos) fueron prohibidos masivamente gracias al Protocolo de Montreal (1987) debido a su impacto letal sobre el ozono (O3), demostrando que la cooperación global tecnológica es posible.',
  ),
  Question(
    id: 'cs_q460',
    topicId: 'cs_t4',
    text:
        "El Perú posee un enorme potencial para generar 'Energía Geotérmica', pero aún es incipiente su desarrollo. ¿De dónde proviene directamente el calor que utiliza este tipo de tecnología limpia para mover turbinas y generar electricidad?",
    options: [
      'De la quema de residuos forestales.',
      'De la radiación solar captada por paneles de silicio.',
      'Del calor interno de la Tierra, generalmente asociado a zonas de alta actividad volcánica y tectónica.',
      'De las diferencias de temperatura en las corrientes oceánicas.',
      'Del rozamiento del viento contra las montañas.',
    ],
    correctAnswer: 2,
    explanation:
        'La energía geotérmica aprovecha el calor del subsuelo magmático o volcánico (por ejemplo, en las regiones de Arequipa y Moquegua) para calentar agua, generar vapor y producir electricidad constante.',
  ),
  Question(
    id: 'cs_q461',
    topicId: 'cs_t4',
    text:
        "En la región amazónica peruana, una de las actividades humanas extractivas más letales genera 'biomagnificación', es decir, la acumulación de metales pesados altamente tóxicos en la cadena trófica (peces y humanos), afectando gravemente el sistema nervioso. Esta contaminación proviene del uso extensivo de mercurio (azogue) en:",
    options: [
      'La tala ilegal de caoba.',
      'La pesca industrial de anchoveta.',
      'La agricultura de monocultivo de palma aceitera.',
      'La minería aurífera informal e ilegal (extracción de oro aluvial).',
      'La extracción de gas natural en Camisea.',
    ],
    correctAnswer: 3,
    explanation:
        'La minería ilegal en Madre de Dios utiliza mercurio para amalgamar las partículas de oro. El mercurio se evapora o se vierte a los ríos, transformándose en metilmercurio, un veneno letal que se bioacumula en la cadena alimenticia.',
  ),
  Question(
    id: 'cs_q462',
    topicId: 'cs_t4',
    text:
        "El Fenómeno 'El Niño' (ENSO) es una anomalía climática natural, pero la comunidad científica advierte que el cambio climático está incrementando la frecuencia e intensidad de los eventos 'Niño Costero' extraordinarios. Oceanográficamente, este fenómeno se caracteriza primariamente por:",
    options: [
      'El enfriamiento extremo y congelamiento de las aguas del mar peruano.',
      'El calentamiento anómalo de las aguas superficiales del Océano Pacífico ecuatorial y costas peruanas.',
      'La reducción a cero de las precipitaciones en la costa norte peruana durante cinco años.',
      'La aparición masiva de huracanes categoría 5 en Lima Metropolitana.',
      'La desaparición temporal de la Cordillera de los Andes.',
    ],
    correctAnswer: 1,
    explanation:
        'El Niño consiste en el debilitamiento de los vientos alisios y el ingreso de aguas cálidas desde Oceanía hacia la costa de Sudamérica, causando evaporación extrema y lluvias torrenciales (huaicos) en la costa norte del Perú.',
  ),
  Question(
    id: 'cs_q463',
    topicId: 'cs_t4',
    text:
        "La 'Huella de Carbono' es un indicador ambiental específico derivado de la huella ecológica. Su propósito técnico exclusivo es medir la totalidad de:",
    options: [
      'Agua dulce consumida en un año por una empresa.',
      'Residuos plásticos arrojados al mar por un país.',
      'Árboles plantados per cápita en las zonas urbanas.',
      'Gases de Efecto Invernadero (GEI) emitidos directa o indirectamente por un individuo, organización, evento o producto.',
      'Minerales extraídos de las reservas nacionales.',
    ],
    correctAnswer: 3,
    explanation:
        'La huella de carbono se expresa en toneladas de CO2 equivalente. Sirve para cuantificar el impacto sobre el calentamiento global e impulsar políticas de compensación (bonos de carbono) o reducción de emisiones.',
  ),
  Question(
    id: 'cs_q464',
    topicId: 'cs_t4',
    text:
        'En el año 2015 se suscribió el acuerdo climático más importante del siglo XXI, donde por primera vez casi todos los países del mundo, desarrollados y en desarrollo, se comprometieron voluntariamente a mantener el aumento de la temperatura media mundial muy por debajo de los 2°C (y preferiblemente a 1.5°C). Este tratado es el:',
    options: [
      'Acuerdo de París.',
      'Tratado de Río de Janeiro (Cumbre de la Tierra).',
      'Protocolo de Montreal.',
      'Declaración de Estocolmo.',
      'Acuerdo de Escazú.',
    ],
    correctAnswer: 0,
    explanation:
        'El Acuerdo de París (COP 21) reemplazó efectivamente al Protocolo de Kioto. Se basa en las Contribuciones Determinadas a Nivel Nacional (NDC), donde cada país establece sus propias metas de reducción de emisiones.',
  ),
  Question(
    id: 'cs_q465',
    topicId: 'cs_t4',
    text:
        "Para un operativo de la DIRMEAMB en la sierra central (La Oroya, Cerro de Pasco), es clave conocer el concepto de 'Pasivos Ambientales Mineros (PAM)'. Jurídicamente y ecológicamente, los PAM se definen como:",
    options: [
      'Minas actualmente operativas que pagan sus impuestos ecológicos al día.',
      'Instalaciones mineras modernas que utilizan tecnología limpia de flotación.',
      'Instalaciones, efluentes, relaves o restos de operaciones mineras abandonadas o inactivas, que constituyen un riesgo permanente para la salud y el ecosistema.',
      'Las regalías y el canon que las mineras pagan a las municipalidades.',
      'Zonas de reforestación financiadas por empresas extractivas activas.',
    ],
    correctAnswer: 2,
    explanation:
        "Un pasivo ambiental es una 'herida abierta' del pasado. Son relaveras, pozos o desmontes abandonados por empresas que ya no existen, de las cuales el Estado o terceros deben hacerse cargo para remediar la contaminación continua (ej. drenaje ácido de roca).",
  ),
  Question(
    id: 'cs_q466',
    topicId: 'cs_t4',
    text:
        "La 'Biomasa' es una fuente de energía renovable que, aplicada correctamente mediante tecnología, puede sustituir a los combustibles fósiles en zonas rurales. La biomasa genera energía a partir de:",
    options: [
      'La captura de fotones solares en láminas de silicio.',
      'La fuerza gravitatoria de las mareas lunares.',
      'La desintegración atómica de elementos pesados como el uranio.',
      'El aprovechamiento de la materia orgánica (residuos agrícolas, forestales o excrementos animales) mediante combustión o digestión anaeróbica (biogás).',
      'La fricción de placas tectónicas profundas.',
    ],
    correctAnswer: 3,
    explanation:
        'La energía de biomasa recicla el carbono de la materia orgánica reciente. Mediante biodigestores, el estiércol y restos agrícolas se convierten en gas metano (biogás) para cocinar o generar electricidad, evitando la deforestación por leña.',
  ),
  Question(
    id: 'cs_q467',
    topicId: 'cs_t4',
    text:
        "El aumento progresivo del dióxido de carbono (CO2) antropogénico en la atmósfera no solo calienta el planeta por el efecto invernadero, sino que causa un segundo desastre ecológico masivo, muchas veces denominado 'el otro problema del CO2', que amenaza la formación de arrecifes de coral y el ecosistema marino. Este fenómeno es:",
    options: [
      'La evaporación acelerada de los océanos.',
      'La acidificación de los océanos.',
      'La congelación del lecho marino.',
      'El aumento exponencial de tiburones blancos.',
      'La desalinizacion total de los mares del sur.',
    ],
    correctAnswer: 1,
    explanation:
        'El océano absorbe gran parte del CO2 atmosférico. Al disolverse en el agua, forma ácido carbónico, reduciendo el pH marino (acidificación), lo que impide que corales, crustáceos y moluscos puedan formar sus conchas de carbonato de calcio.',
  ),
  Question(
    id: 'cs_q468',
    topicId: 'cs_t4',
    text:
        "El Perú posee la mayor Amazonía andina, considerada el 'pulmón del mundo' por su capacidad de fijar carbono. Sin embargo, la mayor fuente de emisiones de Gases de Efecto Invernadero (GEI) del Perú no proviene de sus escasas fábricas, sino de:",
    options: [
      'El parque automotor de la ciudad de Lima.',
      'Las erupciones volcánicas del sur.',
      'El uso masivo de aire acondicionado en verano.',
      'El Cambio de Uso del Suelo y la Silvicultura (deforestación amazónica para agricultura migratoria y ganadería).',
      'Las fugas radiactivas en reactores nucleares civiles.',
    ],
    correctAnswer: 3,
    explanation:
        'A diferencia de países industrializados (donde la energía es la fuente #1 de GEI), en el Perú más del 50% de las emisiones de carbono provienen de la deforestación de la selva (tala y quema) para convertir bosques en tierras agrícolas (USCUSS).',
  ),
  Question(
    id: 'cs_q469',
    topicId: 'cs_t4',
    text:
        "La 'Huella Hídrica' es un indicador de sostenibilidad que no solo mide el agua que tomamos o usamos para bañarnos (agua azul). ¿Qué otro factor invisible, pero gigantesco, contabiliza obligatoriamente la huella hídrica de una persona o país?",
    options: [
      'El agua contenida en las nubes sobre su territorio nacional.',
      'El agua virtual, es decir, el volumen total de agua dulce utilizada indirectamente en la cadena de producción de los bienes y alimentos que consume (ropa, carne, café).',
      'Exclusivamente el agua subterránea no explorada.',
      'El volumen de agua salada de su mar territorial.',
      'El agua purificada que se vende embotellada en supermercados.',
    ],
    correctAnswer: 1,
    explanation:
        "La huella hídrica incluye el 'agua virtual'. Por ejemplo, producir 1 kilo de carne de res requiere miles de litros de agua (para regar el pasto que comió la vaca). Esto permite medir el verdadero impacto hídrico del consumismo.",
  ),
  Question(
    id: 'cs_q470',
    topicId: 'cs_t4',
    text:
        'Dentro del estudio de los ecosistemas, los organismos que garantizan el reciclaje de la materia orgánica, transformando los restos de animales y plantas muertas en nutrientes inorgánicos que regresan al suelo para ser absorbidos nuevamente por los productores (plantas), son los:',
    options: [
      'Consumidores primarios (herbívoros).',
      'Productores fotosintéticos.',
      'Desintegradores o descomponedores (bacterias y hongos).',
      'Consumidores terciarios (superdepredadores).',
      'Parásitos endémicos.',
    ],
    correctAnswer: 2,
    explanation:
        'Los descomponedores cierran el ciclo de la materia en el ecosistema. Sin hongos y bacterias, el planeta se llenaría de cadáveres y las plantas se quedarían sin nutrientes minerales.',
  ),
  Question(
    id: 'cs_q471',
    topicId: 'cs_t4',
    text:
        'El Acuerdo de Escazú es un tratado regional vanguardista para América Latina y el Caribe, enfocado profundamente en la sostenibilidad y los derechos humanos. ¿Cuál de los siguientes es su pilar u objetivo principal?',
    options: [
      'Garantizar la extradición de criminales de guerra.',
      'Prohibir absolutamente la minería en toda América Latina.',
      'Asegurar el acceso a la información ambiental, la participación pública y el acceso a la justicia en asuntos ambientales, además de proteger a los defensores del medio ambiente.',
      'Crear una moneda única para los países amazónicos.',
      'Privatizar los recursos de la Amazonía bajo supervisión de la OEA.',
    ],
    correctAnswer: 2,
    explanation:
        'Escazú (no ratificado por el Congreso peruano hasta 2024) es el primer tratado en el mundo que incluye disposiciones vinculantes para proteger a los defensores de derechos humanos en asuntos ambientales frente a asesinatos y amenazas.',
  ),
  Question(
    id: 'cs_q472',
    topicId: 'cs_t4',
    text:
        "El 'Efecto Invernadero' es un fenómeno natural y necesario para la vida en la Tierra; sin él, la temperatura promedio global sería de aproximadamente -18°C. El problema ecológico moderno radica en:",
    options: [
      'La destrucción total de la atmósfera por los viajes espaciales.',
      'El incremento artificial y desproporcionado de los gases de efecto invernadero (GEI) antropogénicos, que atrapan más radiación infrarroja de la necesaria, sobrecalentando el planeta.',
      'El enfriamiento del núcleo de la Tierra que obliga al Sol a calentar más la superficie.',
      'El cambio en el ángulo de inclinación del eje terrestre provocado por la minería.',
      'La disminución drástica del vapor de agua natural en los océanos del sur.',
    ],
    correctAnswer: 1,
    explanation:
        "El efecto invernadero es natural, pero el 'calentamiento global' es el incremento acelerado de este efecto debido a las emisiones masivas de CO2 y CH4 derivadas de la Revolución Industrial y la quema de combustibles fósiles.",
  ),
  Question(
    id: 'cs_q473',
    topicId: 'cs_t4',
    text:
        "En tecnología agrícola sostenible, la 'Agroforestería' (o sistemas agroforestales) se presenta como una solución clave contra la deforestación de la Amazonía. Esta técnica consiste en:",
    options: [
      'Talar completamente un bosque e instalar invernaderos hidropónicos computarizados.',
      'Combinar en el mismo terreno cultivos agrícolas, árboles maderables/frutales e incluso pastos para ganado, imitando la diversidad del bosque natural.',
      'Reemplazar la agricultura por la minería de tierras raras.',
      'Quemar extensiones gigantes de bosque para sembrar pasto africano monoespecífico.',
      'Utilizar fertilizantes químicos potentes para obligar a los árboles a crecer en desiertos salinos.',
    ],
    correctAnswer: 1,
    explanation:
        "La agroforestería rompe el ciclo de 'tala-roza-quema'. Al asociar cultivos (como el café o cacao) bajo la sombra de árboles maderables, se conserva el suelo, el microclima y la biodiversidad mientras se genera economía.",
  ),
  Question(
    id: 'cs_q474',
    topicId: 'cs_t4',
    text:
        'Para que un ecosistema se mantenga en equilibrio (homeostasis), el flujo de energía debe seguir un camino unidireccional. La principal y primaria fuente de energía de la casi totalidad de los ecosistemas superficiales de la Tierra (que permite el inicio de la cadena trófica) es:',
    options: [
      'El calor del núcleo terrestre.',
      'La energía química del petróleo.',
      'La radiación electromagnética (luz) del Sol.',
      'Las corrientes magnéticas del polo norte.',
      'La descomposición radiactiva del uranio.',
    ],
    correctAnswer: 2,
    explanation:
        'La luz solar es captada por los productores (plantas, algas, fitoplancton) mediante la fotosíntesis, transformando la energía luminosa en energía química (glucosa), la cual fluye hacia los herbívoros y carnívoros.',
  ),
  Question(
    id: 'cs_q475',
    topicId: 'cs_t4',
    text:
        "La 'Eutrofización' es un grave problema de contaminación del agua generado por la actividad humana (fertilizantes agrícolas, aguas residuales sin tratar). Ecológicamente, este fenómeno provoca la muerte del ecosistema acuático (lagos, ríos) debido a:",
    options: [
      'La congelación instantánea del cuerpo de agua por químicos refrigerantes.',
      'El envenenamiento directo de los peces por metales pesados radiactivos.',
      'El enriquecimiento excesivo de nutrientes (nitrógeno y fósforo), que genera una explosión de algas superficiales que bloquean la luz y consumen todo el oxígeno disuelto al descomponerse (anoxia).',
      'La acidificación extrema del agua debido a lluvias ácidas volcánicas.',
      'La evaporación acelerada de las moléculas de agua dulce.',
    ],
    correctAnswer: 2,
    explanation:
        "La eutrofización ('exceso de nutrientes') hace que el lago se llene de una capa verde (algas o lenteja de agua). Al morir estas algas, las bacterias las descomponen agotando el oxígeno, asfixiando a los peces.",
  ),
  Question(
    id: 'cs_q476',
    topicId: 'cs_t4',
    text:
        'En el marco del desarrollo tecnológico sostenible peruano, la ciudad de Lima implementó en su momento plantas desalinizadoras y sistemas de tratamiento para reusar aguas residuales. Sin embargo, a gran escala, la principal fuente de contaminación de los ríos de la vertiente del Pacífico (como el Rímac) sigue siendo:',
    options: [
      'El tráfico de buques nucleares.',
      'El derrame de crudo de pozos petroleros offshore.',
      'El vertimiento directo de efluentes industriales no tratados y desagües domésticos crudos a la cuenca.',
      'La pesca submarina con arpones explosivos.',
      'La migración de aves acuáticas invasoras.',
    ],
    correctAnswer: 2,
    explanation:
        'La falta de Plantas de Tratamiento de Aguas Residuales (PTAR) operativas y la informalidad industrial convierten al río Rímac (principal fuente de agua de la capital) en un vertedero de pasivos biológicos y químicos continuos.',
  ),
  Question(
    id: 'cs_q477',
    topicId: 'cs_t4',
    text:
        'Para certificar que una empresa peruana opera bajo estándares internacionales de gestión y cuidado del medio ambiente (sistemas de gestión ambiental eficientes y sostenibles), la corporación busca obtener voluntariamente la certificación internacional:',
    options: ['ISO 9001', 'OHSAS 18001', 'ISO 14001', 'ISO 27001', 'SA 8000'],
    correctAnswer: 2,
    explanation:
        'La norma ISO 14001 es el estándar internacional para la Gestión Ambiental. La ISO 9001 es para Gestión de Calidad y la 45001 (ex OHSAS) para Seguridad y Salud Ocupacional.',
  ),
  Question(
    id: 'cs_q478',
    topicId: 'cs_t4',
    text:
        "La 'Obsolescencia Programada' es una práctica contraria al desarrollo sostenible. A nivel económico-tecnológico, esta práctica industrial consiste en:",
    options: [
      'Diseñar productos (electrodomésticos, celulares) con una vida útil artificialmente corta o piezas irreparables, forzando al consumidor a comprar un reemplazo rápidamente para mantener el flujo de ventas.',
      'Fabricar máquinas que funcionan eternamente sin necesidad de repuestos ni energía externa.',
      'Crear programas informáticos de código abierto y gratuito para el Tercer Mundo.',
      'Vender productos hechos 100% de materiales biodegradables.',
      'Imponer impuestos a las empresas que innovan tecnológicamente.',
    ],
    correctAnswer: 0,
    explanation:
        'La obsolescencia programada es el motor del hiperconsumismo irracional y generador principal de la creciente crisis mundial de basura electrónica o e-waste, incompatible con la economía circular.',
  ),
  Question(
    id: 'cs_q479',
    topicId: 'cs_t4',
    text:
        "El término 'Ecotono', vital en ecología del paisaje para la preservación de la biodiversidad, se define como:",
    options: [
      'El grado de acidez del suelo de la selva virgen.',
      'El sonido que emiten los animales nocturnos para orientarse.',
      'La zona de transición natural, frontera o tensión entre dos ecosistemas distintos (ejemplo: entre el bosque y el páramo, o entre el río y el mar), caracterizada por poseer altísima riqueza de especies.',
      'Un tipo de nube contaminante formada sobre ciudades industriales.',
      'Una moneda verde utilizada para pagar los bonos de carbono.',
    ],
    correctAnswer: 2,
    explanation:
        'Los ecotonos (como los manglares o linderos de bosques) son áreas riquísimas biológicamente, pues albergan especies de ambos ecosistemas colindantes e incluso especies propias adaptadas a la transición (efecto de borde).',
  ),
  Question(
    id: 'cs_q480',
    topicId: 'cs_t4',
    text:
        'Un aspirante a la Policía Nacional debe entender que las consecuencias del cambio climático inciden directamente en la seguridad ciudadana y la paz social. Según el Panel Intergubernamental de Expertos sobre el Cambio Climático (IPCC), uno de los efectos sociopolíticos más graves a futuro derivados de sequías prolongadas y pérdida de costas por aumento del nivel del mar será:',
    options: [
      'El surgimiento de potencias tecnológicas pacíficas.',
      "La masiva aparición de 'refugiados climáticos' y conflictos armados o sociales por el acceso al agua potable y tierras fértiles.",
      'El fin automático de las ideologías políticas de extrema derecha.',
      'La extinción rápida de todas las enfermedades infecciosas tropicales.',
      'El retorno de los dinosaurios a las planicies siberianas.',
    ],
    correctAnswer: 1,
    explanation:
        'El cambio climático es un multiplicador de amenazas. Las hambrunas, escasez de agua (estrés hídrico) e inundaciones provocarán migraciones forzosas masivas, desestabilizando estados y propiciando conflictos geopolíticos y civiles.',
  ),
  Question(
    id: 'cs_q481',
    topicId: 'cs_t4',
    text:
        'En el ecosistema altiplánico peruano (Puno), existe una tecnología preincaica milenaria revivida en la actualidad como un pilar de adaptación al cambio climático, pues protege los cultivos de las heladas nocturnas usando canales de agua como reguladores térmicos. Esta tecnología es conocida como:',
    options: [
      'Andenes de Moray.',
      'Acueductos de Nasca.',
      'Waru Waru (o Camellones).',
      'Qhapaq Ñan.',
      'Tambos hidrológicos.',
    ],
    correctAnswer: 2,
    explanation:
        'Los Waru Waru son plataformas elevadas rodeadas de canales de agua. De día el agua absorbe calor solar, y en las noches gélidas lo irradia hacia los cultivos, creando un microclima que salva la cosecha de la helada.',
  ),
  Question(
    id: 'cs_q482',
    topicId: 'cs_t4',
    text:
        'El biólogo Antonio Brack Egg, primer Ministro del Ambiente del Perú, clasificó el complejo territorio nacional no en las clásicas 8 regiones naturales de Pulgar Vidal, sino utilizando criterios modernos ecológicos, climáticos y de flora/fauna. Él propuso la existencia de:',
    options: [
      '3 grandes franjas continentales.',
      '4 macro-ecosistemas climáticos.',
      '11 Ecorregiones.',
      '24 zonas de vida ecológica.',
      '84 climas andinos exclusivos.',
    ],
    correctAnswer: 2,
    explanation:
        'Brack Egg formuló las 11 Ecorregiones del Perú (ej. Mar Frío, Mar Tropical, Desierto del Pacífico, Bosque Seco, Páramo, Puna, Selva Alta, etc.), una clasificación fundamental para la conservación sistemática actual.',
  ),
  Question(
    id: 'cs_q483',
    topicId: 'cs_t4',
    text:
        "En el contexto de la 'Tecnología Limpia', un vehículo Híbrido se diferencia de un vehículo Eléctrico Puro (BEV) en un aspecto tecnológico y de impacto ambiental fundamental:",
    options: [
      'El híbrido funciona con paneles solares en el techo, el eléctrico con energía eólica.',
      'El híbrido posee tanto un motor de combustión interna (gasolina) como un motor eléctrico, mientras que el eléctrico puro carece por completo de motor a explosión y tubo de escape.',
      'El híbrido emite agua radiactiva, el eléctrico emite ozono.',
      'El híbrido no necesita baterías, funciona directo a la red como un trolebús.',
      'El eléctrico puro contamina 10 veces más debido a la quema de carbón en su interior.',
    ],
    correctAnswer: 1,
    explanation:
        'Los autos híbridos (ej. Prius) son una tecnología puente; aún queman gasolina para cargar su batería o asistir al motor eléctrico. Los BEV (Battery Electric Vehicle) no usan gasolina y tienen cero emisiones directas de GEI.',
  ),
  Question(
    id: 'cs_q484',
    topicId: 'cs_t4',
    text:
        'La deforestación no solo aniquila la biodiversidad, sino que interrumpe violentamente un ciclo hidrológico vital en la cuenca amazónica. Los millones de árboles de la Amazonía bombean agua subterránea hacia la atmósfera a través de sus hojas, formando inmensos flujos de vapor en el cielo que viajan hacia los Andes y generan las lluvias. A este fenómeno atmosférico se le llama:',
    options: [
      'Corriente del Niño.',
      'Ríos voladores.',
      'Inversión térmica andina.',
      'Ciclón Yaku.',
      'Efecto Föhn.',
    ],
    correctAnswer: 1,
    explanation:
        "Los 'ríos voladores' son flujos masivos de vapor de agua generados por la evapotranspiración de la selva amazónica. Si la selva se tala, este flujo se corta, causando sequías catastróficas en la cordillera y la costa sudamericana.",
  ),
  Question(
    id: 'cs_q485',
    topicId: 'cs_t4',
    text:
        'Dentro del Estado Peruano, la OEFA (Organismo de Evaluación y Fiscalización Ambiental) tiene un rol punitivo y técnico sumamente estricto en el ámbito del desarrollo sostenible. Su competencia principal, vinculada a los Mega Proyectos de inversión (minería, petróleo, energía), es:',
    options: [
      'Aprobar la creación de nuevos Parques Nacionales.',
      'Cobrar los peajes en las carreteras de penetración a la selva.',
      'Dictar multas, paralizar operaciones e imponer sanciones a las grandes empresas que incumplen la normativa ambiental y sus Estudios de Impacto Ambiental (EIA).',
      'Vender bonos de carbono en la bolsa de valores de Nueva York.',
      'Realizar el recojo de basura doméstica en los distritos limeños.',
    ],
    correctAnswer: 2,
    explanation:
        'La OEFA, brazo fiscalizador del MINAM, se encarga de asegurar que las industrias formales y de gran envergadura respeten los límites máximos permisibles (LMP) de contaminación, aplicando millonarias sanciones de ser el caso.',
  ),
  Question(
    id: 'cs_q486',
    topicId: 'cs_t4',
    text:
        "El uso incontrolado de 'Agroquímicos' (pesticidas e insecticidas sintéticos) en la agricultura moderna generó un desastre ecológico silencioso advertido desde el libro 'Primavera Silenciosa' (Rachel Carson). En el Perú, su uso indiscriminado amenaza la base de la seguridad alimentaria mundial al causar el Síndrome de Colapso de Colonias, el cual afecta específicamente a:",
    options: [
      'Las vacas lecheras de las cuencas altas.',
      'Las lombrices de tierra productoras de humus.',
      'Las abejas y otros polinizadores naturales esenciales para la reproducción del 70% de los cultivos alimentarios.',
      'Las golondrinas costeras.',
      'Los murciélagos vampiros de la amazonía.',
    ],
    correctAnswer: 2,
    explanation:
        'Los insecticidas neonicotinoides desorientan y matan a las abejas masivamente. Sin abejas no hay polinización, y sin polinización colapsa la agricultura de frutas y vegetales a nivel global.',
  ),
  Question(
    id: 'cs_q487',
    topicId: 'cs_t4',
    text:
        "El concepto de 'Resiliencia' ecológica es fundamental en las teorías modernas de sostenibilidad. Se define técnicamente como:",
    options: [
      'La capacidad de un bosque de arder espontáneamente para renovarse.',
      'La incapacidad de las especies para mutar genéticamente.',
      'La capacidad de un ecosistema para absorber perturbaciones, resistir impactos (como incendios o huracanes) y recuperar su estado de equilibrio estructural y funcional original.',
      'La velocidad a la que un país consume su PBI anual.',
      'La dureza física del lecho rocoso frente a terremotos.',
    ],
    correctAnswer: 2,
    explanation:
        'La resiliencia es la elasticidad o capacidad de rebote del ecosistema. Un ecosistema altamente biodiverso es muy resiliente; un ecosistema degradado por la contaminación pierde resiliencia y puede colapsar irreversiblemente ante un evento climático.',
  ),
  Question(
    id: 'cs_q488',
    topicId: 'cs_t4',
    text:
        "Uno de los contaminantes atmosféricos más letales en ciudades como Lima o Arequipa es el 'Material Particulado' (PM10 y PM2.5). A diferencia del CO2 (que causa calentamiento global), el peligro primordial del PM2.5 (hollín y polvo microscópico del parque automotor) radica en que:",
    options: [
      'Destruye la capa de ozono de manera instantánea.',
      'Derrite el chasis de los automóviles con el tiempo.',
      'Por su tamaño microscópico, ingresa profundamente a los alvéolos pulmonares y al torrente sanguíneo, causando graves enfermedades respiratorias, cardiovasculares y cáncer.',
      'Acelera el proceso de oxidación de los mares.',
      'Atrae magnéticamente rayos durante tormentas.',
    ],
    correctAnswer: 2,
    explanation:
        'Las partículas de menos de 2.5 micras son invisibles y no son filtradas por la nariz humana. Provienen de la quema de diésel deficiente, siendo una de las principales causas de muerte prematura por contaminación urbana.',
  ),
  Question(
    id: 'cs_q489',
    topicId: 'cs_t4',
    text:
        "En materia de gestión de residuos sólidos (basura urbana), el desarrollo sostenible aboga por la 'Estrategia de las 3R'. Su orden jerárquico es fundamental, pues la primera 'R' es la más efectiva para evitar la contaminación. Este orden lógico es:",
    options: [
      'Reciclar, Rehusar, Regalar.',
      'Reducir, Reutilizar, Reciclar.',
      'Rechazar, Recolectar, Rellenar.',
      'Rescatar, Renovar, Reinvertir.',
      'Reaccionar, Regular, Reparar.',
    ],
    correctAnswer: 1,
    explanation:
        'La jerarquía indica que el mejor residuo es el que no se genera (Reducir el consumo inútil). Si debes consumirlo, úsalo muchas veces (Reutilizar). Finalmente, si ya no sirve, transfórmalo industrialmente en materia prima (Reciclar).',
  ),
  Question(
    id: 'cs_q490',
    topicId: 'cs_t4',
    text:
        "Las 'Especies Invasoras' o 'Exóticas' representan la segunda mayor causa de pérdida de biodiversidad en el mundo después de la destrucción de hábitats. A nivel ecológico, su peligrosidad al ser introducidas accidental o intencionalmente en un nuevo ecosistema reside en que:",
    options: [
      'Aumentan la riqueza de la flora embelleciendo el paisaje con flores extrañas.',
      'Se cruzan genéticamente generando super-especies dóciles.',
      'Carecen de depredadores naturales en su nuevo entorno, multiplicándose explosivamente, depredando o desplazando por competencia extrema a las especies endémicas originales.',
      'Mueren casi instantáneamente envenenando el suelo donde caen.',
      'Son portadoras exclusivas de metales pesados en su pelaje.',
    ],
    correctAnswer: 2,
    explanation:
        'Ejemplos clásicos son la introducción de la trucha arcoíris (depredadora feroz de peces nativos andinos) o el sapo de caña en Australia. Al no tener control natural, colonizan y exterminan a las especies nativas.',
  ),
  Question(
    id: 'cs_q491',
    topicId: 'cs_t4',
    text:
        'Para evaluar si un gran proyecto de ingeniería (ej. Represa, Aeropuerto o Mina a tajo abierto) es compatible con el desarrollo sostenible, el Estado peruano, antes de otorgar cualquier licencia de construcción, exige la elaboración y aprobación de un documento técnico riguroso. Este instrumento preventivo es el:',
    options: [
      'Informe Brundtland de Ejecución Rápida.',
      'Tratado de Libre Comercio (TLC).',
      'Estudio de Impacto Ambiental (EIA).',
      'Plan Maestro de Conservación del SERNANP.',
      'Plan Copesco de Turismo.',
    ],
    correctAnswer: 2,
    explanation:
        'El EIA (cuya versión detallada para megaproyectos la revisa el SENACE) identifica anticipadamente los daños ecológicos/sociales que causará la obra y propone medidas de mitigación o compensación estrictas.',
  ),
  Question(
    id: 'cs_q492',
    topicId: 'cs_t4',
    text:
        "El Perú concentra importantes yacimientos de 'Tierras Raras' y Litio (ej. en Macusani, Puno). Irónicamente, aunque su extracción requiere megaminería y uso de químicos intensivos, estos minerales son apodados hoy 'los minerales de la transición ecológica' porque son indispensables para:",
    options: [
      'Fabricar paneles de plomo antimisiles para las Fuerzas Armadas.',
      'Producir baterías de alta capacidad para vehículos eléctricos y componentes clave de las turbinas eólicas y paneles solares.',
      'Refinar petróleo pesado de la amazonía peruana de forma limpia.',
      'Construir estructuras antisísmicas de adobe en el altiplano.',
      'Purificar directamente el agua de los relaves antiguos.',
    ],
    correctAnswer: 1,
    explanation:
        'La transición energética lejos del petróleo requiere tecnología moderna (baterías de iones de litio, imanes de neodimio para aerogeneradores), lo que genera una paradoja ecológica: se requiere minería intensiva para salvar el clima.',
  ),
  Question(
    id: 'cs_q493',
    topicId: 'cs_t4',
    text:
        'En los ecosistemas urbanos andinos de altura (ej. Cusco, Juliaca, Huancayo), se produce un fenómeno meteorológico peligroso durante las madrugadas frías de invierno: el aire frío y denso queda atrapado a nivel del suelo por una capa de aire caliente superior, encerrando todo el humo y smog sobre la ciudad e impidiendo su dispersión. Esto se llama:',
    options: [
      'Lluvia ácida concentrada.',
      'Efecto de isla de calor urbano.',
      'Inversión Térmica.',
      'Capa límite estratosférica.',
      'Efecto Föhn adiabático.',
    ],
    correctAnswer: 2,
    explanation:
        "La inversión térmica actúa como una 'tapa invisible' sobre el valle. Los contaminantes de los vehículos o quema de leña no pueden subir ni disiparse, generando picos extremos de contaminación respiratoria tóxica en las madrugadas.",
  ),
  Question(
    id: 'cs_q494',
    topicId: 'cs_t4',
    text:
        'El Protocolo de Montreal (1987) es el tratado ambiental internacional más exitoso de la historia. A diferencia del cambio climático, este protocolo resolvió otro problema global monumental mediante el veto mundial a ciertas sustancias químicas tecnológicas. El éxito de Montreal consistió en:',
    options: [
      'Eliminar progresivamente las sustancias (CFCs y Halones) que agotaban la Capa de Ozono estratosférica, logrando su recuperación gradual.',
      'Erradicar completamente el uso de la energía nuclear civil tras el desastre de Chernóbil.',
      'Prohibir la caza de ballenas jorobadas en todos los mares del sur.',
      'Acabar definitivamente con la deforestación en el cinturón ecuatorial terrestre.',
      'Desmantelar todas las fábricas de carbón de China y Estados Unidos.',
    ],
    correctAnswer: 0,
    explanation:
        'La diplomacia global logró que la industria tecnológica reemplace los letales CFC por compuestos menos dañinos para el ozono, frenando la catástrofe de la radiación ultravioleta B extrema sobre la vida terrestre.',
  ),
  Question(
    id: 'cs_q495',
    topicId: 'cs_t4',
    text:
        "Las 'Ciudades Inteligentes' (Smart Cities) aplican el desarrollo tecnológico a favor de la sostenibilidad urbana. Una de sus bases infraestructurales ecológicas es el abandono progresivo de la 'generación centralizada' de energía en favor de la 'Generación Distribuida'. Esto implica que:",
    options: [
      'Solo una mega-central nuclear abastece a todo el continente.',
      'La energía eléctrica es generada por múltiples pequeños productores y los propios ciudadanos (paneles solares en sus techos) que consumen y venden excedentes a la red matriz inteligente.',
      'Se instalan generadores a diésel ruidosos en cada semáforo de la ciudad para ahorrar cables.',
      'La electricidad se distribuye de forma inalámbrica mediante grandes torres de Tesla gigantes.',
      'El Estado prohíbe el uso de energía nocturna.',
    ],
    correctAnswer: 1,
    explanation:
        "La generación distribuida y las micro-redes permiten que un edificio moderno sea 'prosumidor' (produce con paneles/viento lo que consume). Si le sobra energía, la inyecta a la red; si le falta, toma de la red.",
  ),
  Question(
    id: 'cs_q496',
    topicId: 'cs_t4',
    text:
        "En ecología marina peruana, la Corriente de Humboldt es fría y rica en nutrientes. Su productividad pesquera gigantesca (anchoveta) se debe principalmente al 'Afloramiento' (Upwelling). Este proceso tecnológico natural se explica como:",
    options: [
      'El calentamiento masivo de la capa superficial del océano pacífico ecuatorial que atrae atunes.',
      'El choque de la corriente cálida del Niño con la corriente de Cromwell causando remolinos térmicos.',
      'El ascenso a la superficie de aguas marinas profundas, extremadamente frías y cargadas de nutrientes inorgánicos acumulados en el fondo por siglos, impulsadas por los vientos alisios.',
      'La erupción de volcanes submarinos frente al Callao que expulsan fertilizantes de azufre.',
      'La caída masiva del guano de isla impulsada por la fuerza de gravedad.',
    ],
    correctAnswer: 2,
    explanation:
        'Los vientos empujan el agua superficial caliente hacia alta mar, permitiendo que el agua del fondo oscuro, rebosante de nitratos y fosfatos, emerja hacia la zona fótica superficial, originando una explosión de plancton, base alimenticia marina.',
  ),
  Question(
    id: 'cs_q497',
    topicId: 'cs_t4',
    text:
        'El Perú ha prohibido progresivamente, mediante normativa ambiental, los plásticos de un solo uso y envases de tecnopor (poliestireno expandido). A nivel químico y ecológico, el problema insuperable del tecnopor en el desarrollo sostenible radica en que:',
    options: [
      'Es radiactivo y emite rayos gamma débiles.',
      'No es biodegradable, se fragmenta en mortales microplásticos, no es reciclable en la práctica y ocupa enormes volúmenes en rellenos sanitarios para siempre.',
      'Es altamente corrosivo para el acero de las construcciones.',
      'Está compuesto de amianto y asbesto.',
      'Su quema genera exclusivamente oxígeno molecular alterando el aire local.',
    ],
    correctAnswer: 1,
    explanation:
        'El tecnopor es plástico inflado con aire. Tarda siglos en descomponerse, los animales acuáticos lo confunden con comida muriendo por obstrucción, y reciclarlo es logísticamente inútil (al ser 95% aire, requiere transporte voluminoso poco rentable).',
  ),
  Question(
    id: 'cs_q498',
    topicId: 'cs_t4',
    text:
        "La 'Biopiratería' es un delito ambiental sofisticado que atenta contra la soberanía de los países megadiversos como el Perú (ej. maca, uña de gato, sangre de grado). En términos técnico-jurídicos, la biopiratería se consuma cuando:",
    options: [
      'Piratas armados asaltan barcos madereros de caoba en alta mar.',
      'Se hackean las bases de datos del MINAM para robar mapas ecológicos.',
      'Corporaciones extranjeras o investigadores patentan en sus países de origen recursos genéticos nativos o conocimientos tradicionales de pueblos indígenas, sin su consentimiento previo informado ni distribución justa de beneficios.',
      'Se introducen semillas transgénicas americanas en campos orgánicos andinos de noche.',
      'Se venden animales silvestres en los mercados negros europeos.',
    ],
    correctAnswer: 2,
    explanation:
        'La biopiratería es el saqueo genético e intelectual. Ocurre cuando empresas farmacéuticas o cosméticas patentan una planta peruana curativa conocida por milenios por los nativos, reclamando derechos de exclusividad y lucro sin retribuir al país.',
  ),
  Question(
    id: 'cs_q499',
    topicId: 'cs_t4',
    text:
        "El Cambio Climático ha introducido el concepto de 'Mitigación' y 'Adaptación'. Mientras que la mitigación busca reducir las emisiones de gases (ej. usar energía solar), la 'Adaptación' tecnológica y social implica:",
    options: [
      'Reforestar toda la selva para absorber CO2 de la atmósfera.',
      'Construir centrales hidroeléctricas más grandes para compensar el déficit.',
      'Aceptar que el clima ya cambió o cambiará ineludiblemente, y preparar la infraestructura y agricultura para soportar los nuevos eventos extremos (ej. construir diques más altos, semillas resistentes a la sequía).',
      'Pagar multas internacionales a las Naciones Unidas por contaminar.',
      'Negar el cambio climático argumentando que son ciclos solares naturales.',
    ],
    correctAnswer: 2,
    explanation:
        'Si construimos barreras costeras contra marejadas o reubicamos ciudades lejos de cauces aluviales previendo el aumento de lluvias torrenciales, no estamos frenando el cambio climático (mitigación), sino preparándonos para sobrevivir a él (adaptación).',
  ),
  Question(
    id: 'cs_q500',
    topicId: 'cs_t4',
    text:
        'La Amazonía sufre degradación no solo por la minería o tala ilegal, sino por proyectos de infraestructura mal planificados. Si se construye una carretera transversal asfaltada cruzando una vasta área de selva virgen (bosque primario), el daño ecológico no se limita a los 20 metros de asfalto talados. El mayor impacto destructor sistémico a mediano plazo, documentado históricamente, es:',
    options: [
      'El calor del asfalto que esteriliza el polen a 10 km de distancia.',
      "El 'efecto espina de pescado': la vía facilita y abarata la colonización incontrolada, permitiendo que miles de colonos agrícolas y madereros ilegales ingresen y deforesten grandes extensiones a los lados de la carretera.",
      'El asfalto disuelve el suelo volcánico y provoca sismos inducidos.',
      'La proliferación de murciélagos gigantes que atacan a las comunidades nativas.',
      'La absorción magnética de metales pesados desde el núcleo de la Tierra hacia la vía.',
    ],
    correctAnswer: 1,
    explanation:
        "Una carretera en la selva actúa como un cuchillo. La apertura vial reduce los costos de transporte de la ilegalidad, generando rápidamente ramificaciones secundarias perpendiculares ('espina de pescado') destruyendo progresivamente el bosque aledaño por cientos de kilómetros.",
  ),
  Question(
    id: 'cs_q501',
    topicId: 'cs_t4',
    text:
        "El fenómeno físico fundamental que permite la vida en la Tierra al retener parte de la radiación infrarroja del sol en la baja atmósfera se llama 'Efecto Invernadero'. Sin embargo, su intensificación acelerada genera el Calentamiento Global. El gas de efecto invernadero (GEI) antropogénico de mayor volumen emitido por la quema de combustibles fósiles es:",
    options: [
      'El Ozono troposférico.',
      'El Óxido nitroso.',
      'El Dióxido de Carbono (CO2).',
      'El Metano (CH4).',
      'El Clorofluorocarbono (CFC).',
    ],
    correctAnswer: 2,
    explanation:
        'El Dióxido de Carbono (CO2) representa más del 70% de las emisiones globales humanas (GEI), proveniente de la combustión de petróleo, carbón y gas para energía y transporte.',
  ),
  Question(
    id: 'cs_q502',
    topicId: 'cs_t4',
    text:
        "Dentro del grupo de los Gases de Efecto Invernadero (GEI), existe uno con un 'potencial de calentamiento' (capacidad de atrapar calor) aproximadamente 25 veces mayor que el CO2. Sus emisiones en el Perú y el mundo provienen fuertemente de la fermentación entérica del ganado vacuno, el cultivo de arroz inundado y botaderos de basura (descomposición anaeróbica). Este gas es el:",
    options: [
      'Vapor de agua hirviendo.',
      'Amoníaco agrícola.',
      'Metano (CH4).',
      'Dióxido de Azufre (SO2).',
      'Radón radiactivo.',
    ],
    correctAnswer: 2,
    explanation:
        'El Metano es un gas sumamente potente generado por la digestión de los rumiantes (vacas) y la pudrición de materia orgánica sin oxígeno (basurales, pantanos).',
  ),
  Question(
    id: 'cs_q503',
    topicId: 'cs_t4',
    text:
        "El modelo económico hegemónico desde la Revolución Industrial, responsable del actual agotamiento de ecosistemas, se basa en 'extraer materias primas, fabricar el producto, usarlo y botarlo a la basura'. Este paradigma destructivo se conoce técnicamente como:",
    options: [
      'Economía Circular ecológica.',
      'Economía Colaborativa solidaria.',
      'Economía Lineal (o del descarte).',
      'Economía Naranja cultural.',
      'Comunismo cibernético distributivo.',
    ],
    correctAnswer: 2,
    explanation:
        "La 'Economía Lineal' es insostenible en un planeta finito, pues asume (falsamente) que los recursos naturales son infinitos y que la naturaleza absorberá infinitamente la contaminación ('tomar-hacer-desechar').",
  ),
  Question(
    id: 'cs_q504',
    topicId: 'cs_t4',
    text:
        "Como contrapropuesta al modelo lineal, la 'Economía Circular' postula un cambio total en el diseño industrial para lograr el desarrollo sostenible. Su objetivo principal es:",
    options: [
      'Cerrar las fábricas tecnológicas y volver exclusivamente al trueque campesino manual agrario.',
      'Promover la obsolescencia programada para que las fábricas produzcan y vendan circularmente el doble de volumen diario.',
      "Separar el crecimiento económico del consumo de recursos finitos, eliminando el concepto de 'basura' desde el diseño ('Zero Waste'), manteniendo los materiales en un ciclo cerrado de reutilización, reciclaje y compostaje perpetuo.",
      'Acuñar monedas físicas perfectamente circulares de oro macizo.',
      'Que los basureros se instalen de forma circular en las afueras de las metrópolis.',
    ],
    correctAnswer: 2,
    explanation:
        "La Economía Circular (basada en las 'R': Reducir, Reutilizar, Reciclar, Reparar) imita a la naturaleza: el residuo de un proceso se convierte en el nutriente/insumo del siguiente, eliminando el vertedero.",
  ),
  Question(
    id: 'cs_q505',
    topicId: 'cs_t4',
    text:
        'Un indicador ambiental vital impulsado por las Naciones Unidas que mide el volumen total de agua dulce (en litros) utilizada para producir los bienes y servicios consumidos por un individuo, comunidad o país (por ejemplo, saber que se requieren 15,000 litros de agua para producir 1 kg de carne de res), se denomina:',
    options: [
      'Índice de Acidez Hídrica Marina.',
      'Huella de Carbono Personal.',
      'Huella Ecológica de Superficie Terrestre.',
      'Huella Hídrica (o Agua Virtual).',
      'Caudal Ecológico Fluvial.',
    ],
    correctAnswer: 3,
    explanation:
        "La Huella Hídrica nos hace conscientes del 'agua invisible' o 'virtual' contenida en nuestra ropa o comida. El agro y la ganadería industrial consumen más del 70% del agua dulce mundial.",
  ),
  Question(
    id: 'cs_q506',
    topicId: 'cs_t4',
    text:
        "El agotamiento de la 'Capa de Ozono' (estratósfera), que nos protege de la radiación ultravioleta (UV-B) letal causante del cáncer de piel, fue resuelto exitosamente gracias al Tratado de Montreal (1987). Este acuerdo prohibió mundialmente el uso industrial de gases propulsores (usados en aerosoles y refrigeradoras antiguas) denominados:",
    options: [
      'Clorofluorocarbonos (CFC).',
      'Monóxido de carbono asfixiante.',
      'Vapores de Mercurio denso.',
      'Gases Nobles (Argón y Neón).',
      'Gases Lacrimógenos (CS).',
    ],
    correctAnswer: 0,
    explanation:
        "Los CFC destruían catalíticamente las moléculas de Ozono (O3) al liberar cloro frío. Montreal es el acuerdo ambiental internacional más exitoso de la historia, frenando el 'agujero' de ozono antártico.",
  ),
  Question(
    id: 'cs_q507',
    topicId: 'cs_t4',
    text:
        "La 'Lluvia Ácida' es un fenómeno de polución atmosférica severa. Se origina cuando los gases emanados por las fundiciones de minerales pesados (como La Oroya históricamente) y el diésel se mezclan con el vapor de agua atmosférico formando ácido sulfúrico y nítrico. El principal gas causante de esto es el:",
    options: [
      'Dióxido de azufre (SO2).',
      'Gas metano de los pantanos.',
      'Helio de soldadura industrial.',
      'Hidrógeno inflamable.',
      'Ozono troposférico.',
    ],
    correctAnswer: 0,
    explanation:
        'El dióxido de azufre (proveniente del azufre en carbón y petróleo) al reaccionar con el agua de las nubes precipita como lluvia ácida, la cual calcina los bosques, acidifica los lagos matando a los peces y corroe monumentos de mármol.',
  ),
  Question(
    id: 'cs_q508',
    topicId: 'cs_t4',
    text:
        "En el año 2015, bajo la Convención Marco de la ONU (COP21), se firmó el tratado ambiental más importante del siglo XXI para detener el calentamiento global. El compromiso central de casi 200 países fue limitar el aumento de la temperatura media global a fin de siglo 'muy por debajo' de 2°C, y preferiblemente a 1.5°C respecto a la era preindustrial. Este tratado es el:",
    options: [
      'Protocolo de Kioto de la ONU.',
      'Acuerdo de París.',
      'Tratado de Libre Comercio del Pacífico (TPP).',
      'Convención de Ginebra para el Clima.',
      'Acuerdo de Paz de Westfalia Climático.',
    ],
    correctAnswer: 1,
    explanation:
        'El Acuerdo de París (2015) establece las Contribuciones Determinadas a Nivel Nacional (NDC), obligando a cada país a trazar una ruta de transición energética para reducir sus GEI (descarbonizar sus economías).',
  ),
  Question(
    id: 'cs_q509',
    topicId: 'cs_t4',
    text:
        'Frente a los impactos inminentes del Cambio Climático, la ciencia ambiental establece dos grandes ejes de acción pública. Al conjunto de obras, construcciones tecnológicas (ej. represas, muros de contención contra huaicos) o cambios en los cultivos (usar semillas resistentes a sequías) implementadas para sobrevivir a los nuevos extremos climáticos inevitables, se le denomina estrategia de:',
    options: [
      'Mitigación.',
      'Adaptación.',
      'Neutralización de carbono inversa.',
      'Evasión térmica.',
      'Negacionismo geológico.',
    ],
    correctAnswer: 1,
    explanation:
        "La 'Adaptación' asume que el clima ya cambió (ej. más lluvias intensas, El Niño recargado) y actúa en consecuencia para proteger la vida humana (gestión de riesgo de desastres). Es diferente de la 'Mitigación', que busca reducir el origen del problema (reducir los gases emitidos).",
  ),
  Question(
    id: 'cs_q510',
    topicId: 'cs_t4',
    text:
        "El Perú posee un inmenso potencial geológico para generar electricidad mediante 'Energía Geotérmica'. Sin embargo, esta tecnología limpia, que no depende del sol ni del viento, consiste fundamentalmente en:",
    options: [
      'Quemar algas extraídas del lago Titicaca.',
      'Aprovechar las mareas oceánicas en los acantilados de la costa sur.',
      'Aprovechar el calor interno de la Tierra (actividad magmática superficial) capturando el vapor de agua subterráneo de alta presión para mover turbinas generadoras, especialmente en zonas volcánicas.',
      'Utilizar uranio extraído de las punas de Macusani (Puno) en reactores de fusión atómica controlada.',
      'Extraer magnetita para crear motores de perpetuidad móvil.',
    ],
    correctAnswer: 2,
    explanation:
        "El sur del Perú (Arequipa, Tacna) forma parte del Cinturón de Fuego (vulcanismo activo). La geotermia extrae el vapor de reservorios candentes subterráneos, siendo una energía renovable de 'base' (disponible 24 horas al día, 7 días a la semana).",
  ),
  Question(
    id: 'cs_q511',
    topicId: 'cs_t4',
    text:
        "En zonas andinas áridas sin acceso a la red eléctrica o diésel, las comunidades utilizan el 'Biodigestor' como tecnología apropiada y descentralizada de desarrollo sostenible. El biodigestor procesa estiércol animal (ej. de cuyes o vacas) sin oxígeno para generar dos productos valiosos:",
    options: [
      'Diesel refinado puro y asfalto sólido para carreteras.',
      'Biogás (metano combustible para cocinar sin humo) y Biol (un fertilizante líquido orgánico y ecológico de alta calidad).',
      'Gas de uso médico anestésico (óxido nitroso) y plástico biodegradable.',
      'Agua destilada potable y sal marina de mesa pura.',
      'Oro aluvial concentrado sin usar mercurio toxico y barro cocido para artesanía.',
    ],
    correctAnswer: 1,
    explanation:
        'Un biodigestor transforma un problema ambiental (estiércol que contamina ríos) en energía limpia gratuita (biogás, evitando que las mujeres andinas respiren humo de leña tóxico en la cocina) y abono para la tierra.',
  ),
  Question(
    id: 'cs_q512',
    topicId: 'cs_t4',
    text:
        "El 'Smog Fotoquímico' es la neblina amarillenta tóxica que cubre el cielo de megaciudades (como Lima o Santiago) en verano. Se produce cuando los gases emitidos por los tubos de escape de los autos (óxidos de nitrógeno - NOx) reaccionan químicamente impulsados por:",
    options: [
      'La mezcla con polvo del desierto de Ica nocturno.',
      'El choque con las partículas de salitre (sal) del Océano Pacífico.',
      'La luz solar directa (radiación ultravioleta), generando ozono a nivel del suelo (ozono troposférico), el cual es altamente irritante para los pulmones.',
      'La presencia de neblina (garúa) limeña extrema en pleno invierno absoluto.',
      'El humo de las quemas agrícolas de los valles andinos aledaños a la ciudad.',
    ],
    correctAnswer: 2,
    explanation:
        "El sol es el 'catalizador' del smog urbano. Los NOx y compuestos volátiles del tráfico, al ser irradiados por el sol, forman Ozono malo (a nivel del suelo), provocando asma y enfermedades bronquiales agudas a los ciudadanos.",
  ),
  Question(
    id: 'cs_q513',
    topicId: 'cs_t4',
    text:
        "El desierto costero peruano cuenta en su franja sur (Ica, Marcona, Nazca) con grandes extensiones planas y fuertes vientos constantes del Pacífico ('vientos Paracas'). Esta característica orográfica lo hace idóneo para la instalación de 'Parques Eólicos'. La energía eólica se basa en:",
    options: [
      'Espejos parabólicos inmensos que concentran la luz solar.',
      'La captura del vapor de agua salado marino (desalinización).',
      'Aerogeneradores (gigantescos molinos modernos de aspas sintéticas) que transforman la energía cinética del viento en energía mecánica y luego en electricidad verde.',
      'Turbinas submarinas amarradas al lecho marino profundo impulsadas por las corrientes de Humboldt.',
      'Antenas masivas que capturan la electricidad estática de las tormentas de arena.',
    ],
    correctAnswer: 2,
    explanation:
        'El Parque Eólico de Marcona fue pionero en Perú. Los aerogeneradores (que pueden superar los 100 metros de alto) aprovechan el viento de la costa para girar el rotor de una turbina e inyectar electricidad limpia al SEIN (Sistema Eléctrico Nacional).',
  ),
  Question(
    id: 'cs_q514',
    topicId: 'cs_t4',
    text:
        "El 'Acuerdo de Escazú' (aprobado en 2018 para América Latina y el Caribe) ha generado fuerte debate sociopolítico en el Perú. Más allá de su enfoque ambiental general, su núcleo doctrinario es garantizar un ecosistema democrático y proteger legalmente a los defensores de derechos humanos ambientales, enfocándose en:",
    options: [
      'Prohibir absolutamente la minería en toda la cordillera andina para siempre.',
      'Obligar al gobierno peruano a ceder un corredor soberano a Bolivia.',
      'Garantizar el acceso público irrestricto a la información ambiental, la participación ciudadana obligatoria en la toma de decisiones ambientales, y el acceso a la justicia (cortes) en asuntos ecológicos.',
      'Privatizar los Parques Nacionales entregándolos a la custodia del Comando Sur de EE.UU.',
      'Fijar un impuesto continental único del 10% a toda la carne exportada por Sudamérica.',
    ],
    correctAnswer: 2,
    explanation:
        'Escazú (no ratificado aún por el Congreso peruano) es un tratado pionero de Derechos Humanos Ambientales. Busca que las poblaciones nativas (como los defensores de los bosques asesinados por madereros) tengan protección judicial y voz vinculante antes de que el Estado licite concesiones extractivas en sus tierras.',
  ),
  Question(
    id: 'cs_q515',
    topicId: 'cs_t4',
    text:
        "La 'Agroecología' es un pilar del desarrollo sostenible andino, contraponiéndose a la 'Revolución Verde' de monocultivos de los años 60. Un principio tecnológico agrario ancestral que la agroecología rescata para evitar la erosión del suelo y el agotamiento de nutrientes (como el nitrógeno) sin usar químicos artificiales, es:",
    options: [
      'Bañar los sembríos diarios con cloro purificado diluido en agua al 50%.',
      'La Rotación de Cultivos (ej. sembrar papa un año, quinua al siguiente y luego una leguminosa como el tarwi) y el Policultivo asociado simultáneo (asociación maíz-frijol).',
      'El uso exclusivo de tractores pesados oruga de gran tonelaje para apisonar fuertemente la tierra andina.',
      'Inundar los valles andinos con agua salada para matar toda mala hierba previo a la siembra.',
      'Sembrar únicamente clones de maíz genéticamente idénticos (clonación in vitro masiva).',
    ],
    correctAnswer: 1,
    explanation:
        "La rotación de cultivos impide que las plagas se afiancen y permite que las leguminosas (frijol/tarwi) 'fijen' biológicamente el nitrógeno del aire al suelo devolviéndole fertilidad. El monocultivo agroindustrial, en contraste, agota la tierra requiriendo úrea sintética derivada del petróleo.",
  ),
  Question(
    id: 'cs_q516',
    topicId: 'cs_t4',
    text:
        "Los 'Plásticos de un solo uso' (bolsas, cañitas, envases de tecnopor o poliestireno expandido) están siendo prohibidos progresivamente por el Estado peruano (Ley 30884). La razón ecológica profunda para eliminar el Tecnopor (poliestireno) en la industria gastronómica es que:",
    options: [
      'Genera radiación alfa que envenena los alimentos contenidos en su interior.',
      'Se disuelve en contacto con el agua y ensucia las mesas de los clientes.',
      'No es biodegradable (tarda siglos en fotodegradarse) y su reciclaje es técnica y económicamente inviable (al ser 95% aire y resina frágil), terminando irremediablemente en los vertederos o en el mar fraccionándose en letales microplásticos.',
      'Su producción consume exclusivamente madera de la Amazonía tropical causando tala incontrolable.',
      'Contiene altos niveles de plomo pesado que causa enanismo en los infantes lactantes.',
    ],
    correctAnswer: 2,
    explanation:
        'El tecnopor es el enemigo número uno de los ecosistemas marinos. Al flotar y quebrarse rápidamente (microplásticos), aves y peces lo ingieren confundiéndolo con comida, muriendo de inanición estomacal. Además, la industria del reciclaje no lo compra porque carece de masa y valor reventa.',
  ),
  Question(
    id: 'cs_q517',
    topicId: 'cs_t4',
    text:
        'El Perú concentra el 70% de los glaciares tropicales del mundo, siendo la Cordillera Blanca el mayor exponente. El retroceso glaciar provocado por el calentamiento global, donde los nevados pierden su masa de hielo a una velocidad catastrófica y forman nuevas lagunas, genera un doble peligro inminente para la seguridad nacional, que consiste en:',
    options: [
      'Que el hielo derretido inunde la costa norte provocando maremotos directos, y la nieve atraiga a pingüinos caníbales.',
      "Un riesgo de 'aluvión' inicial por el desborde violento o colapso de las nuevas lagunas glaciares (peligro para los valles), seguido a largo plazo por una dramática 'escasez de agua' para el consumo humano costeño y la hidroeléctrica andina durante los meses sin lluvia (estiaje).",
      'El surgimiento de volcanes dormidos ocultos bajo el hielo, que lanzarían lava a Lima.',
      'La creación de desiertos de arena fina en la puna y la muerte masiva de ovejas por insolación directa (cáncer de piel animal).',
      'Que la reducción de peso de la cordillera altere la rotación terrestre, acortando los días peruanos en dos horas exactas.',
    ],
    correctAnswer: 1,
    explanation:
        "El glaciar actúa como un 'gran tinaco' de hielo que suelta agua gota a gota en verano (época seca). Si desaparecen (como el Pastoruri), la costa desértica (Chimbote, Trujillo) se quedará sin agua para beber ni para sus proyectos agroindustriales (Chavimochic). Además, el agua de deshielo forma lagos que, al romperse la morrena, arrasan las ciudades con lodo (como el aluvión de Yungay en 1970 pero de origen hidrológico).",
  ),
  Question(
    id: 'cs_q518',
    topicId: 'cs_t4',
    text:
        "En la silvicultura (manejo de bosques), existe una gran diferencia ambiental entre un bosque nativo (virgen) y una 'Plantación Forestal'. Muchas veces el Estado fomenta reforestar la sierra andina con eucalipto y pino (especies exóticas). El principal problema ecológico de plantar masivamente bosques de Eucalipto en los andes es que:",
    options: [
      'Las hojas de eucalipto explotan espontáneamente causando incendios diarios indetenibles.',
      'El eucalipto es un árbol de altísimo consumo hídrico que seca el subsuelo circundante, impide el crecimiento de flora nativa bajo su sombra (alelopatía) y no proporciona alimento a la fauna andina endémica original.',
      'Su madera es tan débil que las casas construidas con él colapsan con el viento paramero.',
      'Es una planta carnívora que diezma a las aves pequeñas de los valles andinos.',
      'Requiere la tala previa forzosa de toda la vegetación amazónica originaria.',
    ],
    correctAnswer: 1,
    explanation:
        "El eucalipto crece muy rápido (madera rápida para leña o construcción), pero es una 'bomba de agua'. No retiene el agua como el bosque nativo de Queñual (Polylepis). Su hoja seca es altamente combustible y el suelo bajo un bosque de eucaliptos es ecológicamente pobre (desierto verde).",
  ),
  Question(
    id: 'cs_q519',
    topicId: 'cs_t4',
    text:
        "La transición hacia vehículos eléctricos (Electromovilidad) es la piedra angular para reducir el GEI del sector transporte urbano. Para fabricar las potentes baterías recargables de los millones de autos eléctricos, el mundo requiere enormes cantidades de minerales estratégicos (críticos). El 'triángulo de la electromovilidad' en Sudamérica, vital para esta tecnología sostenible y codiciado por las potencias mundiales, está conformado por yacimientos masivos de:",
    options: [
      'Oro, Plata y Platino nativo andino.',
      'Uranio radiactivo, Torio y Plutonio pesado.',
      'Litio (el oro blanco) en los salares altoandinos, y Cobre masivo en Perú/Chile como conductor ineludible de los bobinados eléctricos.',
      'Carbón antracita de altísimo poder calorífico y petróleo ligero costero.',
      'Hierro y bauxita masiva para chatarreo.',
    ],
    correctAnswer: 2,
    explanation:
        'El Litio (salares de Bolivia, Chile, Argentina y naciente minería de roca dura en Puno, Perú) es irremplazable hoy para las baterías ion-litio. El Cobre (del cual Perú y Chile son líderes mundiales absolutos) es fundamental porque un auto eléctrico usa 4 veces más cobre que uno a combustión (para sus cables, estatores y puntos de carga).',
  ),
  Question(
    id: 'cs_q520',
    topicId: 'cs_t4',
    text:
        "La 'Huella Ecológica' mide el impacto humano en la Tierra. A nivel país, el Perú está en 'déficit ecológico' relativo, pero la paradoja del país radica en que su matriz eléctrica nacional está conformada mayoritariamente (más del 50%) por una tecnología de baja emisión de carbono que es:",
    options: [
      'La quema intensa de carbón bituminoso de la zona central.',
      'El uso masivo de energía atómica de fisión (Reactores de Huarangal ampliado).',
      'La Energía Hidroeléctrica (Centrales que aprovechan las enormes caídas y fuerza de los ríos andinos).',
      'Campos solares fotovoltaicos que cubren el 90% del desierto de Sechura.',
      'Turbinas eólicas marítimas en el mar de Tumbes exclusivas.',
    ],
    correctAnswer: 2,
    explanation:
        'El Sistema Eléctrico Interconectado Nacional (SEIN) peruano es relativamente verde en electricidad gracias a los andes y las lluvias. Las hidroeléctricas (ej. Mantaro, Cerro del Águila, Chaglla) proveen el grueso de la luz peruana, aunque en estiaje se debe encender la generación termoeléctrica a Gas Natural (Camisea).',
  ),
  Question(
    id: 'cs_q521',
    topicId: 'cs_t4',
    text:
        "En la ecología, los ecosistemas de alta resiliencia logran absorber impactos sin colapsar. La Amazonía peruana, por milenios resistente a perturbaciones, hoy presenta 'puntos de no retorno' ecológico (Tipping points). Si la deforestación amazónica supera el 20-25% de su superficie original, la ciencia predice que ocurrirá un colapso sistémico que causará que:",
    options: [
      'El río Amazonas invierta su corriente y fluya violentamente hacia los andes huanuqueños.',
      "La selva tropical verde se transforme gradualmente e irreversiblemente en una sabana seca y degradada (sabanización), perdiendo su capacidad de bombear lluvia mediante los 'ríos voladores' hacia la sierra y costa peruana.",
      'Los insectos muten y devoren la capa de asfalto de las carreteras transoceánicas.',
      'Los glaciares del nevado Huascarán aumenten su tamaño por el exceso de calor radiante.',
      'La tierra amazónica se hunda masivamente dejando un cráter de agua salada oceánica intercontinental.',
    ],
    correctAnswer: 1,
    explanation:
        "La selva crea su propia lluvia reciclando agua por transpiración (ríos voladores). Si se tala demasiado, el ciclo se rompe ('tipping point'). La selva húmeda muere de sed, arde por los incendios naturales, y se convierte en una pradera seca (sabana). Y sin lluvia amazónica, la sierra andina se seca y no habrá agricultura costera.",
  ),
  Question(
    id: 'cs_q522',
    topicId: 'cs_t4',
    text:
        'El Perú sufre el flagelo de la minería aluvial ilegal en el cinturón de oro de Madre de Dios. Además de deforestar y verter mercurio, las dragas destruyen completamente el suelo arcilloso selvático, dejando a su paso inmensos cráteres de arena blanca y agua turbia donde no vuelve a crecer el bosque primario. Esta aniquilación física de la estructura terrestre (erosión de la materia fértil superior vegetal) impide que el ecosistema se regenere naturalmente y se denomina:',
    options: [
      'Salinización del lecho geológico.',
      'Licuefacción tectónica.',
      'Desertificación antropogénica (y pérdida total de la capa edáfica de mantillo).',
      'Fotodegradación de clorofila biológica.',
      'Solidificación calcárea mineral.',
    ],
    correctAnswer: 2,
    explanation:
        "La selva es un ecosistema de 'suelo pobre'; todos sus nutrientes están en la delgada capa de humus (hojarasca) superior (el mantillo). La minería chupa y entierra ese humus debajo de toneladas de arena estéril de lo profundo. El resultado es un desierto literal de arena gris en medio de la Amazonía tropical donde ni las malezas logran enraizar.",
  ),
  Question(
    id: 'cs_q523',
    topicId: 'cs_t4',
    text:
        "La 'Contaminación por Plásticos' en el océano ha formado 'islas de basura' gigantescas en los giros del Océano Pacífico. El desarrollo sostenido aboga por erradicar un concepto material muy usado en la fabricación de poliéster de ropa (microfibras) y empaques diarios, que a nivel molecular no es degradado por bacterias ni enzimas biológicas marinas naturales. Este origen material es:",
    options: [
      'El cuero curtido y fibras de alpaca teñidas.',
      'La celulosa pura extraída de árboles de pino báltico.',
      'El caucho natural amazónico vulcanizado levemente.',
      'Los polímeros sintéticos derivados del refinamiento de hidrocarburos fósiles (petróleo crudo y gas).',
      'El vidrio molido fundido y estirado finamente.',
    ],
    correctAnswer: 3,
    explanation:
        "El plástico es un material extraordinario de ingeniería, pero fatal ecológicamente. Como es un compuesto artificial hecho en laboratorio (polímeros de petróleo), la naturaleza (las bacterias marinas o los hongos de la tierra) carece de las enzimas bioquímicas para 'digerirlo'. Por ende, dura siglos acumulándose sin entrar al ciclo del carbono.",
  ),
  Question(
    id: 'cs_q524',
    topicId: 'cs_t4',
    text:
        'La biotecnología agrícola postula a los Organismos Genéticamente Modificados (OGM) o transgénicos como solución tecnológica para resistir sequías o plagas (ej. maíz Bt o Soya RR). Sin embargo, en el Perú existe una ley vigente (moratoria) que prohíbe taxativamente el ingreso y siembra de semillas transgénicas de forma comercial. El principal fundamento del Estado y del MINAM para sostener esta prohibición proteccionista obedece a que:',
    options: [
      'Comer transgénicos altera automáticamente el ADN humano provocando cáncer gástrico instantáneo.',
      "El Perú es centro de origen y de alta diversificación genética mundial de cultivos nativos (miles de variedades de papa, maíz, ajíes, quinua). El polen transgénico foráneo transportado por el viento contaminaría genéticamente nuestras semillas nativas milenarias ('contaminación genética'), destruyendo la valiosa agrobiodiversidad de las comunidades andinas para siempre.",
      'Las empresas transnacionales usan venenos alienígenas en la elaboración de la semilla.',
      'El Congreso prohibió la importación de semillas para que los peruanos solo consuman camote inca.',
      'Los curacas amazónicos maldijeron cualquier planta que no nazca naturalmente en la selva baja.',
    ],
    correctAnswer: 1,
    explanation:
        "Perú no necesita 'inventar' biodiversidad; es su guardián milenario. La papa peruana tiene la genética natural para resistir heladas o sequías (germoplasma valiosísimo mundial). Si la semilla transgénica de maíz (monocultivo) poliniza al maíz morado peruano, perdemos la pureza nativa y los campesinos pasarían a depender de patentes extranjeras privativas (monopolio de semillas corporativas).",
  ),
  Question(
    id: 'cs_q525',
    topicId: 'cs_t4',
    text:
        "La 'Eutrofización' es un problema tecnológico y biológico de contaminación masiva de cuerpos de agua dulce (lagos y lagunas andinas como el Titicaca o Chinchaycocha) que mata la fauna ictiológica por asfixia (anoxia). Se origina primariamente por:",
    options: [
      'El vertimiento de ácidos minerales provenientes de los volcanes subterráneos activos.',
      "La descarga incontrolada de aguas servidas urbanas (desagües sin tratamiento) ricas en fósforo y nitrógeno agrícola, que genera una explosión ('bloom') descontrolada de algas (lenteja de agua); estas algas, al pudrirse, consumen todo el oxígeno disuelto en el agua matando a los peces locales.",
      'La caída masiva de ceniza volcánica calcárea sobre la superficie del agua.',
      'El calentamiento solar excesivo que hierve el lago evaporando el agua.',
      'El derrame exclusivo de petróleo crudo de oleoductos.',
    ],
    correctAnswer: 1,
    explanation:
        "La eutrofización ('exceso de nutrientes') suena benigno pero es letal. Las aguas fecales o los fertilizantes agrícolas que llegan al lago actúan como abono. Una especie de alga oportunista cubre la superficie (bloquea la luz) y luego muere masivamente. Las bacterias descomponen a las algas y gastan todo el oxígeno del lago, ahogando al resto del ecosistema acuático (ej. bahía de Puno).",
  ),
  Question(
    id: 'cs_q526',
    topicId: 'cs_t4',
    text:
        "Para un miembro de las fuerzas del orden peruano, la fiscalización de los recursos naturales es clave. El Perú ha establecido 'vedas' biológicas para recursos marinos fundamentales y prohíbe pescar ejemplares menores ('juveniles'). La especie marina pelágica, cuya biomasa gigantesca sostiene directamente casi todo el ecosistema de aves y mamíferos del mar peruano y cuya pesca está rigurosamente monitoreada por satélite (SISESAT), es:",
    options: [
      'El paiche amazónico criado en piscigranjas.',
      'La trucha andina salmonada estuarina.',
      'El mero murique ecuatorial tropical.',
      'La anchoveta (Engraulis ringens).',
      'El lobo de río gigante de las yungas.',
    ],
    correctAnswer: 3,
    explanation:
        "La anchoveta es el engranaje central ('keystone species') del mar peruano. De ella se alimentan aves guaneras, pingüinos, jureles, lobos marinos. El 90% de su pesca industrial se reduce a harina de pescado para alimentar cerdos y salmones en Asia. Su sobreexplotación causaría el colapso en cadena de la biodiversidad y economía pesquera de consumo humano nacional.",
  ),
  Question(
    id: 'cs_q527',
    topicId: 'cs_t4',
    text:
        "El modelo de desarrollo sostenible y ecológico de una ciudad ('Urbanismo Verde') promueve un cambio en la 'Pirámide de la Movilidad Sostenible'. Según la jerarquía vial mundial tecnológica de seguridad y emisiones, ¿quién debe ser priorizado y ocupar la cúspide (prioridad número uno absoluta) en la planificación de inversiones, semaforización y construcción de las ciudades modernas?",
    options: [
      'El automóvil privado de gran cilindrada (SUV) por su contribución fiscal.',
      'El Peatón (transeúnte común, ancianos, niños y discapacitados), diseñando calles seguras a escala humana.',
      'El sistema de Metrobús BRT o Tren ligero masivo.',
      'Las motocicletas de reparto por su velocidad comercial interurbana.',
      'El transporte pesado de carga logística aduanera de contenedores marítimos.',
    ],
    correctAnswer: 1,
    explanation:
        'El urbanismo tradicional centraba la ciudad en el auto (construyendo by-passes y carreteras). El desarrollo sostenible invierte la pirámide: primero el Peatón (el modo universal sin emisiones), luego la movilidad activa (ciclistas), luego el transporte público masivo (Metro/Metropolitano), dejando al auto particular en la base (la última prioridad).',
  ),
  Question(
    id: 'cs_q528',
    topicId: 'cs_t4',
    text:
        'En la geopolítica del agua del Perú, la vertiente hidrográfica del Pacífico alberga al 65% de la población del país (la costa desértica fuertemente urbanizada) y la agroexportación, pero dispone de menos del 2% del volumen total de agua dulce nacional. Este tremendo desequilibrio técnico y poblacional se conoce geográficamente como:',
    options: [
      'Déficit pluviométrico orográfico andino.',
      'Estrés o Escasez Hídrica Estructural de la Costa.',
      'Excedente acuífero subterráneo costanero.',
      'Cuota de evaporación ecuatorial marina.',
      'Efecto Föhn patagónico peruano.',
    ],
    correctAnswer: 1,
    explanation:
        'El estrés hídrico peruano es asimétrico. La selva y los andes orientales (vertiente del Atlántico) tienen el 97% del agua patria y pocos pobladores. La costa (desierto) concentra ciudades enormes (Lima) sedientas. Esto obliga a realizar costosos y delicados trasvases (ej. túnel Olmos, represa Yuracmayo, túnel Marcapomacocha) para cruzar agua de la cordillera hacia el Pacífico.',
  ),
  Question(
    id: 'cs_q529',
    topicId: 'cs_t4',
    text:
        "Los proyectos de 'Trasvase Hídrico' o irrigación costera (como Majes-Siguas, Olmos o Chavimochic) son prodigios de ingeniería y desarrollo nacional agrario. Sin embargo, un efecto colateral ('Impacto Ambiental') recurrente en estos vastos valles de arena costeños, originado por el exceso de riego por inundación tradicional y el mal drenaje subterráneo continuo sin mantenimiento adecuado a largo plazo, es que los suelos de los campos de cultivo fértiles sufren un proceso letal llamado:",
    options: [
      'Fotosíntesis hiperactiva destructiva.',
      'Combustión espontánea calcárea.',
      'Salinización (y afloramiento de napa freática) que arruina la productividad de la tierra de cultivo llenándola de costras de sal inservibles.',
      'Licuefacción y surgimiento de arenas movedizas costeras en la superficie agrícola.',
      'Transformación rápida de la arena gruesa en ciénaga amazónica lluviosa incontrolable.',
    ],
    correctAnswer: 2,
    explanation:
        "Los ríos costeños traen sales disueltas imperceptibles. Si el riego es ineficiente (regando con zanjas y no con goteo técnico israelí moderno) en zonas planas desérticas, el nivel del agua subterránea sube. Al evaporarse el solazo el agua de superficie, la sal queda depositada (como una costra blanca). Esto 'quema' las raíces y vuelve el terreno agrícola costeño millonario en un erial inútil y estéril (salinización).",
  ),
  Question(
    id: 'cs_q530',
    topicId: 'cs_t4',
    text:
        "Dentro del desarrollo sostenible, el Protocolo de Montreal curó la capa de ozono; el Acuerdo de París combate el calentamiento (CO2). ¿Cuál tratado internacional fue firmado mundialmente (con Perú como participante clave pionero andino) en 'Minamata' (Japón) el 2013, con el objetivo de prohibir y reducir paulatinamente una neurotoxina pesada específica e indispensable para la extracción del oro informal en la cuenca del Amazonas y el resto del mundo andino?",
    options: [
      'Convenio de Basilea sobre residuos plásticos y microesferas comerciales marinas.',
      'Convenio de Minamata sobre el Mercurio (Azogue).',
      'Tratado de Ramsar sobre el Plomo en las gasolinas de alto octanaje.',
      'Acuerdo de Copenhague sobre Uranio nuclear y radiación residual bélica.',
      'Convención de Estocolmo exclusiva sobre Plaguicidas Fosforados Agrarios.',
    ],
    correctAnswer: 1,
    explanation:
        'El Convenio de Minamata obliga al Estado Peruano a erradicar importaciones de Mercurio y promover tecnologías limpias para mineros artesanales (ej. mesas gravimétricas limpias), evitando que este metal neurotóxico destruya las cadenas tróficas amazónicas hídricas como pasó trágicamente en la bahía japonesa de Minamata (madres y fetos envenenados masivamente por comer pescado).',
  ),
  Question(
    id: 'cs_q531',
    topicId: 'cs_t4',
    text:
        "Una amenaza ecológica imperceptible pero grave provocada por el comercio internacional globalizado ('barcos mercantes transoceánicos') es la introducción accidental de especies invasoras de ecosistemas lejanos hacia los puertos peruanos a través de un compartimento de agua estabilizadora fundamental de los buques modernos. Esta fuente hídrica de dispersión biológica se conoce como:",
    options: [
      'El agua de lluvia depositada en la cubierta del barco polar superior.',
      'El agua destilada de refrigeración de las turbinas calientes.',
      'El Agua de Lastre (depositada en tanques sumergidos para equilibrar buques vacíos).',
      'Las aguas grises residuales de los baños de los marineros europeos comerciales.',
      'El agua potabilizada reservada en envases cerrados de la tripulación.',
    ],
    correctAnswer: 2,
    explanation:
        "Un megabuque carguero en Shanghái 'succiona' millones de litros de agua del mar asiático (llena de plancton, bacterias y crías exóticas chinas) en sus tanques (lastre) para que el barco no vuelque vacío. Meses después, al llegar al puerto de Callao, 'bota' (descarga) esa agua asiática al mar de Grau peruano para cargar cobre. Esto introduce especies exóticas invasoras marinas devoradoras foráneas biológicas altamente perjudiciales.",
  ),
  Question(
    id: 'cs_q532',
    topicId: 'cs_t4',
    text:
        'El Perú posee un mar con dos frentes ecológicos distintos. En la costa norte (Piura y Tumbes) discurre una corriente cálida intermitente de baja salinidad que genera lluvias convectivas de verano y alberga fauna de manglar y pez espada. Esta fuerza oceanográfica, pilar del ecosistema cálido ecuatorial patrio, es:',
    options: [
      'La Corriente Peruana de aguas profundas frías surgentes.',
      'La Corriente de El Niño (o Contracorriente Ecuatorial del Sur).',
      'La Corriente del Golfo Ártica descendente costanera.',
      'La Deriva de los Vientos del Oeste Antárticos helados.',
      'La Corriente Subsuperficial de Cromwell pacífica oriental.',
    ],
    correctAnswer: 1,
    explanation:
        'La Corriente de El Niño es cálida (24-26°C), baja desde el norte (Golfo de Guayaquil) hacia el sur peruano. Su presencia define el clima lluvioso tropical y la fauna pesquera de Tumbes y norte de Piura, hasta chocar en Punta Pariñas o Punta Aguja con la fría Corriente de Humboldt proveniente del extremo sur.',
  ),
  Question(
    id: 'cs_q533',
    topicId: 'cs_t4',
    text:
        "La 'Certificación Forestal' (como el sello FSC - Forest Stewardship Council impreso en muebles de exportación o papel bond de calidad) es un instrumento de mercado para la ecología. Su presencia en un producto maderable garantiza al comprador mundial que la madera proviene directamente de:",
    options: [
      'Bosques primarios vírgenes talados por maquinaria pesada clandestina nocturna sin permiso estatal oficial.',
      'Una plantación transgénica china de crecimiento ultrarrápido esterilizada.',
      'Un bosque manejado de forma ambientalmente responsable (extracción selectiva calculada sin dañar a los animales), socialmente beneficioso (sin explotación infantil indígena) y económicamente viable (tala legal y trazable por GPS).',
      'Árboles falsos de plástico moldeado con textura rugosa sintética industrial.',
      'Residuos industriales plásticos derretidos y comprimidos pintados al horno para simular vetas.',
    ],
    correctAnswer: 2,
    explanation:
        "El FSC y certificaciones similares combaten la tala ilegal asegurando la 'trazabilidad'. El consumidor europeo (dispuesto a pagar más por sostenibilidad) revisa el sello, que garantiza que el árbol de caoba no fue robado de una Reserva Nacional, ni generó asesinatos de comuneros andinos y que el extractor pagó impuestos formales justos y reforestó activamente.",
  ),
  Question(
    id: 'cs_q534',
    topicId: 'cs_t4',
    text:
        "El cambio climático produce la 'Acidificación de los Océanos', apodada ecológicamente como el gemelo malvado del calentamiento. Cuando los inmensos volúmenes de exceso de gas CO2 del aire son absorbidos químicamente por el agua del mar, el ph baja (el mar se vuelve más ácido). La consecuencia destructiva primaria biológica de este proceso químico en el mar pacífico peruano será:",
    options: [
      'Que el agua ácida derrita los cascos de acero inoxidable pesado de los buques pesqueros anclados.',
      'Que hierva el agua, evaporando el Océano Pacífico formando nubes de cloro tóxico hacia la costa seca.',
      'La disolución biológica y debilidad extrema de los exoesqueletos de carbonato de calcio estructural de organismos fundamentales planctónicos, conchas de abanico, choros, corales y langostinos (calcificadores primarios de la pirámide y crustáceos).',
      'El incremento inusitado muscular acelerado evolutivo de los lobos marinos cazadores mutantes.',
      'La transformación genética espontánea de los tiburones en mamíferos herbívoros dóciles de poca agresividad.',
    ],
    correctAnswer: 2,
    explanation:
        'El mar funciona como un sumidero natural de carbono. Al absorber demasiado CO2 se forma ácido carbónico oceánico diluido. Esto corroe o impide que los animales base de la cadena alimenticia formen sus caparazones frágiles de calcio. Sin zooplancton (pterópodos) ni moluscos conchíferos bivalvos costeros sanos, la pesca marina humana entera colapsará inminentemente.',
  ),
  Question(
    id: 'cs_q535',
    topicId: 'cs_t4',
    text:
        'La Amazonía (y su deforestación masiva actual de bosque tropical maduro lluvioso) afecta al ciclo global del carbono porque un árbol nativo amazónico maduro y milenario, biológicamente, no solo exuda oxígeno, sino que funciona como:',
    options: [
      'Un aspersor geológico de uranio irradiado volcánico radiactivo.',
      "Un inmenso almacén ('sumidero' estructural sólido) de carbono secuestrado que fijó biológicamente la fotosíntesis, el cual es liberado masivamente a la atmósfera en forma de CO2 letal (GEI) de manera repentina cuando el bosque es arrasado, cortado o incendiado por colonos o mineros impunes.",
      'Un generador inagotable y espontáneo de gas metano subterráneo fósil petrificado.',
      'Un repelente químico infalible absoluto que evita el efecto de la radiación UV en el cielo sudamericano nocturno.',
      'Un filtro de metales pesados en polvo capaz de extraer hierro del aire enrarecido y crear esferas aceradas.',
    ],
    correctAnswer: 1,
    explanation:
        "El tronco maderable y las raíces de un árbol son carbón biológico puro sólido (madera). Cuando la mafia maderera u ocupantes precarios (roza, tumba y quema) queman el monte virgen amazónico, siglos de 'secuestro o almacenamiento' de carbono (miles de toneladas por hectárea viva) vuelan a la atmósfera como gas letal climático (retroalimentación positiva catastrófica calentadora).",
  ),
  Question(
    id: 'cs_q536',
    topicId: 'cs_t4',
    text:
        "El Perú ha impulsado la categorización y valorización de los 'Servicios Ecosistémicos'. No se vende el bosque en pedazos ni el agua, sino el 'servicio invisible vital' que estos proveen. Un mecanismo económico verde, amparado por ley (MERESE), que permite a las EPS (empresas de agua de las ciudades) y ciudadanos urbanos limeños costeros financiar directamente a las comunidades andinas de la sierra alta en Huarochirí y Yauyos, se fundamenta ecológicamente en:",
    options: [
      'Pagarles para que fabriquen nubes artificiales bombardeando los cielos serranos andinos con yoduro de plata toxica.',
      'Pagar una pequeña contribución en el recibo de agua urbana costeña destinada para que las comunidades andinas altas conserven los bofedales, pastizales (puna) y zanjas de infiltración milenaria amunan, garantizando así técnica y biológicamente la retención hídrica pluvial y que el caudal del río no se seque en pleno verano limeño sediento.',
      'Comprar camiones cisternas petroleros internacionales diarios a Chile fronterizo.',
      'Forzarlos militarmente a construir presas de concreto represivo de millones de dólares foráneos asiáticos.',
      'Exigir la migración incondicional y forzosa de los serranos hacia las selvas orientales lluviosas.',
    ],
    correctAnswer: 1,
    explanation:
        "Los Mecanismos de Retribución por Servicios Ecosistémicos (MERESE-Hídricos) son la vanguardia social verde peruana. La ciudad (ej. Sedapal en Lima seca) necesita agua. En vez de construir un mega-túnel carísimo ciego, invierte ecológicamente (paga) a los comuneros altoandinos para que protejan las praderas altoandinas 'esponja'. Si la montaña andina tiene vegetación nativa densa (conservada sin sobrepastoreo destructivo), retendrá la lluvia torrencial natural invernal y la soltará gradualmente, dotando a Lima de agua pura constante 365 días.",
  ),
  Question(
    id: 'cs_q537',
    topicId: 'cs_t4',
    text:
        "La ciudad de Lima (costa central desértica absoluta) sufre un colapso en la gestión de Residuos Sólidos (basura urbana). Para el enfoque de sostenibilidad, la disposición final de estos miles de toneladas diarias debe realizarse excluyentemente y de forma segura en 'Rellenos Sanitarios' oficiales. La diferencia técnica y de bioseguridad insalvable entre un Relleno Sanitario de ingeniería municipal y un 'Botadero a cielo abierto' clandestino (ej. cerros de basura impunes costeros) es que el relleno sanitario verdadero obligatoriamente debe contar con:",
    options: [
      'Techos de vidrio templado sellados para observar desde drones y luces led intermitentes de colores fosforescentes nocturnos.',
      'Personal paramilitar fuertemente armado exclusivo y perros robóticos mecánicos de vigilancia total privada extranjera perimetral.',
      'Geomembranas plásticas profundas aislantes e impermeables en la base de las trincheras para evitar drásticamente que los líquidos podridos altamente tóxicos (lixiviados venenosos) filtren al acuífero subterráneo (agua pura de subsuelo) y tubos respiradores masivos mecánicos para quemar o extraer el metano explosivo originado biológicamente en la pudrición.',
      'Excavaciones geológicas profundas forzosas directamente conectadas con túneles al mar costero crudo continental peruano.',
      'Sistemas de transporte aéreo exclusivos (teleféricos) para arrojar la basura de forma elegante y colorida.',
    ],
    correctAnswer: 2,
    explanation:
        "El botadero (ej. montículo de escombros de la periferia) es un desastre urbano ambiental. La basura pudriéndose y bajo compresión suelta 'lixiviados' ('jugo de basura tóxica con metales pesados o heces'). Si la tierra está suelta pelada natural, el lixiviado envenenará las napas de agua para consumo. Un verdadero Relleno Sanitario legal (ej. Portillo, Zapallal controlado) usa tecnología (Geomembrana plástica gruesa indestructible) forrando el enorme hueco y purificando la filtración. Es ingeniería pura civil ambiental básica.",
  ),
  Question(
    id: 'cs_q538',
    topicId: 'cs_t4',
    text:
        'La minería formal de alta cordillera es pilar PBI peruano. A diferencia del informal, la corporación megaminera a tajo abierto o subterránea debe (según normativas ambientales y el MINEM) gestionar químicamente y acumular la roca o lodo estéril procesado tóxico sin valor comercial, mezclado con cianuro u otros reactivos industriales y agua sucia concentrada, en inmensas infraestructuras llamadas:',
    options: [
      'Geoglifos rituales de ofrenda y sacrificio incaicos rehidratados y consagrados localmente y regionalmente.',
      'Presas o Canchas de Relaves seguras e impermeables (Tailings dams) controladas ingenierilmente contra rupturas sísmicas severas.',
      'Ríos andinos locales preasignados estatalmente de flujo veloz oceánico continuo purificador sin costo alguno.',
      'Burbujas plásticas masivas presurizadas aéreas sostenidas por columnas de gas inerte helio puro sintético.',
      'Hondonadas agrícolas fértiles de comunidades campesinas lejanas engañadas sin acceso a prensa nacional.',
    ],
    correctAnswer: 1,
    explanation:
        'El gran pasivo operacional minero activo moderno (ej. Antamina, Las Bambas) es el Relave (barro molido gris con reactivos químicos químicos). La presa de relaves (tailing facility) debe resistir sismos severos peruanos y lluvias torrenciales del Fenómeno Niño. Si un dique de estos colapsa (como en Brumadinho o Mariana - Brasil trágicamente), millones de metros cúbicos de lodo metálico venenoso arrasarían valles poblados enteros y ríos profundos en pocos minutos impunemente.',
  ),
  Question(
    id: 'cs_q539',
    topicId: 'cs_t4',
    text:
        "El Perú (y especialmente los valles serranos con campesinado vulnerable) afronta el fenómeno climático cíclico helado interanual de 'Las Heladas' y 'El Friaje'. Climáticamente, un Friaje no es lo mismo que una Helada andina, ya que el 'Friaje' meteorológicamente es:",
    options: [
      'La congelación del agua del mar por anomalías de las corrientes de mareas asiáticas superficiales marinas occidentales invernales fuertes locales.',
      'Un ingreso repentino, violento y drástico de masas de aire polar frío proveniente de la Antártida y Argentina hacia la Amazonía (Selva baja y alta como Puerto Maldonado), derrumbando la temperatura tropical y afectando severamente a pobladores locales no acostumbrados abrigarse y su frágil fauna amazónica en pocos días intensos.',
      'El descenso de temperatura nocturno andino por la irradiación absoluta de cielos despejados de puna secos y estrellados sin nubes de julio.',
      'Un viento huracanado cálido originado en la costa ecuatorial que hiela por evaporación súbita de presión del ambiente caluroso denso.',
      'La precipitación de hielo sólido pesado (granizo masivo gigante de piedra) que destruye exclusivamente los cultivos costaneros.',
    ],
    correctAnswer: 1,
    explanation:
        "La 'Helada' es la temperatura andina bajo cero (-0°C) nocturna por falta de nubes en la Puna (radiación de calor escapando al espacio). El 'Friaje' es una invasión de aire gélido antártico sur que ingresa por el llano amazónico plano (Madre de Dios a Ucayali). Bajar de 35°C a 12°C en plena selva en chozas de madera y calaminas descubiertas causa colapso broncopulmonar infantil masivo de urgencia vital (defensa civil local selvática colapsada).",
  ),
  Question(
    id: 'cs_q540',
    topicId: 'cs_t4',
    text:
        "En zonas agrícolas costeñas (como Ica o Piura) donde escasea críticamente el agua fluvial de los andes, los grandes complejos agroexportadores de espárragos y uvas utilizan 'bombeo subterráneo'. Sin embargo, el sobrebombeo extremo y excesivo y constante genera un impacto tecnológico geológico denominado 'Intrusión Salina'. Este fenómeno se basa ecológicamente en:",
    options: [
      'El surgimiento espontáneo de volcanes de ceniza cálida salitrosa marina en el valle verde de frutales locales de invierno.',
      'La aparición de cangrejos exóticos de mar destruyendo plásticamente el cultivo por excavación intensa en la costa agrícola interior del terreno.',
      'La extracción excesiva y desmedida de agua dulce del acuífero (napa freática subterránea), reduciendo drásticamente su nivel de presión natural, permitiendo que el agua salada del océano cercano se infiltre lateralmente por debajo de la costa y contamine el pozo de riego volviéndolo estéril irreversiblemente (sal y cloruros envenenadores de raíz).',
      'Que el viento marino arrastre espuma de ola pura hasta los cerros más alejados costeños de forma superficial quemando cosechas maduras de exportación.',
      'El depósito de guano de aves marinas concentradas accidentalmente en forma de ácido cítrico espeso.',
    ],
    correctAnswer: 2,
    explanation:
        "El acuífero costeño dulce peruano (bolsón de agua bajo la arena) 'empuja' naturalmente hacia el mar, manteniendo una frontera de equilibrio hidráulico denso. Si los agroexportadores instalan pozos gigantes profundos y sacan demasiada agua, se rompe el muro invisible dulce de presión hidrostática. El océano avanza (intrusión salina), los pozos empiezan a bombear agua salobre inservible y la cuenca agraria de exportación padece estrés crónico agrícola fatal a largo plazo.",
  ),
  Question(
    id: 'cs_q541',
    topicId: 'cs_t4',
    text:
        "El Perú y el Amazonas juegan un rol central en los 'Mercados Voluntarios de Carbono'. Una herramienta financiera climática muy debatida y utilizada por grandes empresas tecnológicas aéreas multinacionales ('Bonos de Carbono' REDD+) implica que:",
    options: [
      'La empresa compra y privatiza lagos peruanos para embotellar agua y exportarla a Marte u otros planetas.',
      "Una aerolínea europea (que contamina mucho con aviones de jet fuel) le paga económicamente a una comunidad amazónica peruana o parque nacional para que mantengan su bosque 'en pie' (sin deforestar), compensando y 'neutralizando' artificialmente sus propias emisiones de CO2 generadas en Europa en los balances contables anuales financieros internacionales del cambio climático global transnacional financiero verde de impacto global de bonos corporativos.",
      'Se imprimen billetes de banco de plástico reciclable con la cara de animales para evitar usar monedas pesadas de aleaciones foráneas que atraen humedad.',
      'Las comunidades indígenas selváticas reciben cupones para canjear armas modernas de asalto ligeras gratuitas de defensa en la comisaría.',
      'Se prohibe legalmente a la ONU ingresar al Amazonas si no pagan impuestos de oro locales regionales en bloque aduaneros obligatorios andinos.',
    ],
    correctAnswer: 1,
    explanation:
        "REDD+ (Reducción de Emisiones derivadas de la Deforestación y Degradación de bosques) es compensación climática de mercado ('Offset'). Yo contamino allá volando, pero pago acá (Amazonía peruana) para que tú no tales tu bosque de 50 años que almacena CO2 orgánico vegetal (que ibas a talar por dinero). Con ese dinero que te giro en dólares, tú te sostienes económicamente de forma verde ecoturística (y yo digo ante la ley europea que soy una empresa 'carbono neutral').",
  ),
  Question(
    id: 'cs_q542',
    topicId: 'cs_t4',
    text:
        "La 'Contaminación Lumínica' o polución de luz nocturna de las ciudades costeras excesivas tiene un impacto profundo no solo astronómico visual en el cielo, sino ecológico grave y silencioso. En el litoral peruano capitalino limeño, el exceso de luz blanca artificial costera de discotecas y faros desorienta e incrementa masivamente la mortandad accidental de:",
    options: [
      'Lobos marinos viejos sordos erráticos.',
      "Aves guaneras jóvenes caídas ('polluelos de golondrinas de la tempestad o gaviotas grises juveniles') que se encandilan y estrellan fatalmente en su primer vuelo nocturno hacia el mar negro y abierto natural seguro sin depredadores.",
      'Cocodrilos del Rímac ciegos confundidos perdidos.',
      'Delfines bufeos encallados intencionalmente depresivos de poca edad local limeña desorientados de las corrientes polares del sur.',
      'Plantas de totora que pierden su proceso fotosintético lunar natural oscuro.',
    ],
    correctAnswer: 1,
    explanation:
        "Las pequeñas aves marinas nocturnas (Golondrinas de la Tempestad o crías) que anidan en el desierto o riscos salen por primera vez guiadas ancestralmente por las estrellas o el reflejo de la luna sobre el océano pacífico libre oscuro. El resplandor brutal de las ciudades andinas o costeras ('Skyglow') y los paneles led las atraen y deslumbran (confusión de brújula óptica), estrellándose masivamente contra edificios, postes de luz de Lima o pistas, muriendo aplastadas (y motivando campañas de SERFOR y activistas para apagar reflectores nocturnos en temporada de cría o cambiar focos de colores naranjas tenues direccionados hacia abajo).",
  ),
  Question(
    id: 'cs_q543',
    topicId: 'cs_t4',
    text:
        'Las cianobacterias y algas unicelulares marinas productoras (Fitoplancton microscópico) del mar peruano no solo sostienen a la anchoveta masivamente de forma comercial nacional, sino que realizan un servicio ecosistémico global planetario invaluable e incalculable biológicamente equiparable a los bosques lluviosos. Este servicio ecológico es:',
    options: [
      'Producir toneladas de petróleo crudo refinable flotante puro en pocas horas diarias de invierno soleado del mar peruano continental del sur marítimo ecuatorial oscuro local marino estuarino denso.',
      'Filtrar y secuestrar pesadamente el plástico urbano y los anzuelos dejados de la pesca industrial reduciéndolo a vitaminas y calcio sólido para tortugas de forma instantánea inorgánica a inorgánica molecular veloz rápida de alta velocidad en verano.',
      'A través de la fotosíntesis biológica pelágica y clorofila expansiva inmensa, producir más del 50% del oxígeno respirable total que existe en la atmósfera del mundo y ser el mayor sumidero de sumidero azul global disuelto masivo oceánico absorbiendo dióxido de carbono profundo.',
      'Generar terremotos controlados mediante pulsaciones biológicas colectivas simultáneas marinas frente a la placa de Nazca dura continental andina profunda sudamericana continental oriental occidental de Nazca costera sudamericana peruana chilena ecuatoriana pacífica.',
      'Evaporar las nubes oceánicas para frenar la radiación de Chernobyl europea foránea importada accidental alejada mundialmente internacional.',
    ],
    correctAnswer: 2,
    explanation:
        'El océano es el gran pulmón de la Tierra (más que la Amazonía misma). El inmenso manto verde vivo invisible de microalgas marinas (fitoplancton de afloramiento, rico en el mar peruano de Humboldt) hace fotosíntesis masiva liberando la mayor parte del O2 que respira el planeta humano, y cuando mueren, arrastran toneladas de carbono consumido hacia los abismos oceánicos congelados profundos y lodosos pelágicos, limpiando efectivamente el cielo mundial de los gases vehiculares.',
  ),
  Question(
    id: 'cs_q544',
    topicId: 'cs_t4',
    text:
        "En el mundo agro-ganadero, el uso irracional, irrestricto y sin prescripción veterinaria de poderosos medicamentos ('Antibióticos de espectro amplio') en granjas avícolas hacinadas intensivas y corrales de vacas, con la única finalidad de engorde profiláctico masivo comercial barato, es la causa documentada ambiental de una gravísima amenaza médica mundial humana denominada:",
    options: [
      'Alergia masiva continental al pasto andino verde foráneo silvestre incoloro andina del sur de los pastizales puros altos altiplánicos locales regionales costeros montañosos.',
      "Resistencia Antimicrobiana Biológica o surgimiento de 'Superbacterias' o bacterias de diseño multi-resistentes intratables hospitalariamente de impacto global mundial fatal comunitario.",
      'Descalcificación esquelética osteoporótica de aves andinas migratorias de altura voladoras rápidas de picos nevados andinos glaciares.',
      'Adicción nerviosa psicológica irreversible de los ganaderos locales andinos a la leche en polvo importada procesada deshidratada foránea extranjera subsidiada.',
      'El descontrol endocrinológico hormonal del clima altiplánico de verano torrencial.',
    ],
    correctAnswer: 1,
    explanation:
        "Si se baña y satura a miles de pollos o cerdos de hacinamiento comercial de granja con antibióticos 'por si acaso' (y para que crezcan más rápido comercialmente), las bacterias naturales locales de granja mutan genéticamente veloz. Sobreviven solo las 'Superbacterias'. Estas bacterias intratables se filtran en ríos locales peruanos, alimentos o trabajadores, originando pandemias y muertes humanas (infecciones comunes como una herida u operación que ya no pueden ser curadas con Penicilina o modernos antibióticos porque las bacterias ya evolucionaron armaduras). Es una crisis ecosistémica de salud pública global extrema 'One Health' urgente.",
  ),
  Question(
    id: 'cs_q545',
    topicId: 'cs_t4',
    text:
        "Un 'Ecosistema de Páramo' fronterizo peruano norandino, fundamental para la regulación hídrica de Piura y Cajamarca (cuencas del Quiróz, Huancabamba, San Lorenzo), difiere radicalmente de la Puna del centro-sur del Titicaca por tener un paisaje permanentemente empapado de lluvia (y neblinas tupidas). La gran amenaza tecnológica-extractiva de alta escala que moviliza protestas civiles campesinas agrícolas, porque amenaza con volar o secar estas frágiles 'esponjas de agua' altoandinas vírgenes de páramo lluviosas en los Andes, es:",
    options: [
      'La proliferación e invasión masiva de estaciones intergalácticas satelitales rusas o chinas foráneas en la frontera montañosa andina militar norandina.',
      'La expansión formal e informal de proyectos extractivos de Minería a Tajo Abierto profundo y a gran escala (oro/cobre de corporaciones transnacionales) en las cabeceras de cuenca (nacientes de ríos) y en lagunas originarias de montaña prístinas sagradas campesinas fronterizas.',
      'La construcción estatal compulsiva de carreteras subterráneas de 8 carriles y 600 kilómetros hacia la cordillera alta inhóspita solitaria andina paramera de los Andes norteños costeros lluviosos piuranos y cajamarquinos.',
      'El desarrollo inmobiliario de rascacielos lujosos residenciales de 100 pisos en las faldas parameras desoladas norteñas solitarias vacías de gente.',
      'La extracción industrial aerostática de gases nobles medicinales raros puros andinos parameros nocturnos invisibles al ojo humano y radar de niebla ecuatorial costero paramera de Piura andina y Tumbes seco costero.',
    ],
    correctAnswer: 1,
    explanation:
        "Conflictos sociales emblemáticos andinos (como el Proyecto Río Blanco/Majaz en Piura, o Conga en Cajamarca) se centran en la protección estricta del Páramo húmedo ('Fábrica de Agua') y cabeceras de ríos puros cristalinos, amenazados de destrucción y desaparición (tajos abiertos gigantes químicos mineros secadores destructivos de suelo andino y manantiales). Si secan o contaminan el páramo andino de nacientes puras andinas de altura andina (y el complejo de lagunas sagradas), los valles agroexportadores y campesinos de frutales de Piura abajo (mangos, limones, San Lorenzo, Tambogrande, Chulucanas) y Cajamarca (pastizales lecheros del llano) colapsarán de sed y miseria irremediable a largo plazo.",
  ),
  Question(
    id: 'cs_q546',
    topicId: 'cs_t4',
    text:
        "El Perú y la Amazonía sudamericana de Madre de Dios lideran una próspera economía agroforestal ecosistémica mundial que evita cortar el inmenso árbol virgen y protege intacto al jaguar andino, beneficiando inmensamente al indígena o colono. Este árbol gigantesco milenario nativo maderable no se tala, sino que se concesiona intacto para que los locales recolecten manualmente 'sin matar al árbol vivo ni mutilarlo' sus preciadas y cotizadas nueces nutritivas internacionales ricas en selenio (castañas) en el suelo. Este árbol gigante amazónico sostenible de manejo directo silvestre protegido y emblemático de Tambopata se llama:",
    options: [
      'Árbol del Cedro enano del desierto y algarrobo de exportación costeña piurana norandina del Pacífico central seco estepario arbustivo de pampa peruana seca.',
      'Árbol de la Goma de látex o caucho (Hevea brasiliensis) selvática sintética.',
      'La Castaña (Bertholletia excelsa) o Nuez del Brasil amazónica gigante alta de bosques vírgenes tropicales sudamericanos orientales inmensos frondosos y lluviosos.',
      'El pino andino maderero azul exótico o eucalipto chileno austral costanero del pacífico seco desierto.',
      'La Caoba real roja (Swietenia macrophylla) y el Ishpingo de exportación.',
    ],
    correctAnswer: 2,
    explanation:
        "La Castaña (Nuez de la Amazonía / Brazil Nut de exportación internacional gourmet) es un milagro de conservación ambiental. Es imposible plantarla sola en monocultivos modernos o en otra latitud (fincas artificiales); depende estrictamente para su polinización cruzada y reproducción de un insecto específico exótico andino puro de bosque (abejas Euglosinas orquideológicas solitarias) y de un roedor forzudo pequeño único local (agutí, añuje) de la selva virgen inalterada. Si un minero o talador corta la caoba adyacente ('entresaca selectiva ciega tonta forestal'), se rompe el ecosistema intrincado ecológico simbiótico profundo silvestre maduro vivo amazónico andino natural sudamericano local salvaje tropical húmedo y el majestuoso árbol de castaña no da frutos ni se reproduce jamás de nuevo. Los concesionarios castañeros son los mejores guardabosques de la selva (viven de que el árbol quede intacto de pie por años y que los animales del bosque estén presentes y vivos polinizando).",
  ),
  Question(
    id: 'cs_q547',
    topicId: 'cs_t4',
    text:
        'El cambio climático produce un incremento de la energía térmica de la atmósfera. Para la PNP (Dirección de Medio Ambiente y Defensa Civil) y fuerzas armadas sudamericanas, una consecuencia crítica directa y palpable operacional de esta mayor temperatura extrema (fuerte radiación ultravioleta, ola de calor y sequías prolongadas) es el desproporcionado incremento en magnitud y frecuencia de fenómenos de emergencia destructiva natural llamados:',
    options: [
      'Invasiones extraterrestres masivas de abejas andinas intercontinentales espaciales.',
      'Lluvias de sapos exóticos amazónicos voladores del lago de altura andino.',
      "Mega-Incendios Forestales masivos incontrolables y persistentes ('Feuges') de vegetación andina y amazónica virgen o laderas pastizales secas empinadas andinas.",
      'Aparición rápida espontánea rápida de cataratas de hielo macizo en el desierto plano piurano y trujillano costeño seco caluroso.',
      'Hundimiento sistemático sísmico costero tectónico volcánico submarino pacífico caluroso andino y limeño costero de agua marina cálida profunda oceánica marina salada y pura.',
    ],
    correctAnswer: 2,
    explanation:
        "El calor excesivo seca la maleza de montaña o bosque ('combustible fino vegetal muerto'). A esto se suma la mala práctica campesina cultural (Roza y quema / limpiar chacras andinas con fósforos para que brote pasto fresco). El resultado: gigantescos Incendios Forestales incontrolables (ej. Cusco andino o Madre de Dios amazónico en meses de agosto o sequía) que sobrepasan totalmente a los bomberos voluntarios peruanos, destruyendo fauna en peligro, sitios arqueológicos y arrasando pueblos (desastres de la nueva era climática de piromanía climática ambiental global).",
  ),
  Question(
    id: 'cs_q548',
    topicId: 'cs_t4',
    text:
        "La Huella de Carbono corporativa peruana y global de las empresas o el Estado se divide técnicamente en tres 'Alcances' internacionales estándar (Scope 1, 2, 3). Si la Escuela de Oficiales de la PNP compra masivamente electricidad comercial de la red (Luz del Sur/Enel) para iluminar sus aulas, de un proveedor que lamentablemente quemó gas natural (termoeléctrica termo gas) para generarla (y no centrales eólicas limpias). ¿A qué tipo de emisión indirecta pertenece o se contabiliza ese GEI ambiental indirecto para la escuela policial técnica?",
    options: [
      'Alcance 1 (Emisiones Directas y puras operativas controladas de chimenea exclusiva local).',
      'Alcance 2 (Emisiones Indirectas estrictamente correspondientes y relativas y absolutas por la Generación y consumo de Electricidad comprada importada).',
      'Alcance 3 (Emisiones de Cadena de Suministro global indirecta de empleados locales de transporte terrestre personal).',
      'Alcance Cero Absoluto (Energía de Fusión Cuántica Limpia y Segura sin gas residual pesado invisible al espectro visual luminoso puro).',
      'Alcance Ilimitado Ficticio de Negacionismo Industrial Ecológico Moderno Extranjero Local de Lima Metropolitana andina rural montañosa y selvática.',
    ],
    correctAnswer: 1,
    explanation:
        "El 'Alcance 2' (Scope 2) mide las emisiones indirectas puras derivadas del consumo de electricidad generada 'fuera' de tu organización y pagada por ti (ej. encender los focos de tu cuartel en Lima con electricidad generada por una planta sucia a mil kilómetros en Chilca contaminando carbón o gas fosil contaminante). Reducir esto significa pasarse a paneles solares o comprar certificados de energía renovable 100% andina o eólica limpia.",
  ),
  Question(
    id: 'cs_q549',
    topicId: 'cs_t4',
    text:
        "Un 'Ecosistema Léntico' altoandino continental (como el Lago de Junín o Chinchaycocha - 4,000 m.s.n.m.) a diferencia de un 'Lótico' rápido, retiene el agua dulce estancada o de flujo muy lento casi nulo (Lago de vida rica endémica peruana patos y ranas andinas gigantes). Su peor debilidad tecnológica extractiva ecológica (en especial frente a minas polimetálicas de Cerro de Pasco aledañas contaminantes que lo cercan e impactan duramente) es:",
    options: [
      'Su incapacidad total genética de producir lluvias sobre la cordillera andina limítrofe oriental amazónica andina de ceja de selva de altura de Puno y Cusco incaicos andinos y costeños limeños del centro nacional.',
      "Que al tener agua 'estancada', lenta o de nula renovación rápida, todos los relaves tóxicos vertidos (plomo, zinc) no son arrastrados y 'lavados' velozmente hacia el mar abierto, sino que se depositan, asimilan sedimentan y bioacumulan pesadamente letales en el lecho fondo lacustre (barro tóxico) durante decenios exterminando lenta e irreversiblemente al ecosistema zambullidor acuático entero andino.",
      'Que su agua hierve por el calor andino de la montaña volcánica cercana y fría de la cordillera blanca de Ancash deshelada limeña costera occidental andina de Ayacucho.',
      'Su propensión natural inmensa oceánica a desbordarse como tsunamis gigantes que arrasan pueblos incas lejanos costeros y selváticos andinos locales del centro norte peruano sureño fronterizo con bolivia altiplánica.',
      'La atracción de meteoritos magnéticos de alta frecuencia y ovnis extraterrestres brillantes que chocan en lagos fríos oscuros nocturnos silenciosos y lodosos andinos de ranas grandes y pájaros patos zambullidores locales cazadores andinos limpios.',
    ],
    correctAnswer: 1,
    explanation:
        "Ecosistema lótico (Lótico=Lava/fluye rápido=Río). Ecosistema Léntico (Léntico=Lento=Lago/Laguna estancada). Los lagos son trampas de contaminación andinas muy delicadas (esponjas tóxicas de tiempo). Si echas desmonte o aguas ácidas venenosas pasco (Pasivos mineros del Tajo de Pasco), el lago no 'se limpia solo' porque carece del arrastre violento (caudal rápido torrencial purificador andino vertiente oriental) de un gran río amazónico purificador. El veneno metálico se va al lodo (fondos andinos), envenenando a la 'rana gigante' (Telmatobius) y 'zambullidor' locales de Junín por siglos.",
  ),
  Question(
    id: 'cs_q550',
    topicId: 'cs_t4',
    text:
        "El modelo ecológico del Estado (Constitución y MINAM peruano) para el Desarrollo Sostenible a largo plazo, promulgado en 1987 (Informe Brundtland de Naciones Unidas de Gro Harlem mundial oficial), no exige detener radicalmente y paralizar todas las industrias y fábricas mundiales tecnológicas paralizando retrocediendo el progreso humano andino y global. La esencia técnica pragmática y equilibrada del 'Desarrollo Sostenido' (Pilar de todo accionar policial PNP moderno verde y sociedad civil de paz y orden del siglo XXI) busca imperativamente conciliar tres dimensiones ineludibles y vitales equitativas, conocidas como:",
    options: [
      'La Dimensión Espacial de Marte extracosmopolita global universal, la Subterránea andina profunda oscura, y la Aeronáutica moderna tecnológica foránea continental rusa intergaláctica de paz andina.',
      'El Crecimiento Económico (PBI rentabilidad y progreso comercial productivo competitivo mundial y empleo), la Equidad e Inclusión Social y justicia (erradicar la pobreza extrema poblacional rural de sierra y derechos andinos), y la Protección Ambiental rigurosa estricta cuidadosa verde (uso racional ecológico de recursos finitos naturales y fauna para generaciones venideras o herederas).',
      'La Dimensión Militar armada de misiles balísticos ofensivos bélicos disuasivos gigantes continentales y nucleares foráneos intercontinentales rápidos, la de Inteligencia artificial electrónica moderna andina cibernética, y la Esotérica religiosa dogmática espiritual de templos andinos incas reconstruidos puros sagrados de piedra labrada masiva imperial antigua mística mítica andina peruana.',
      'La dimensión Agrícola feudal y de arado comunista local colectivista obligatoria de subsistencia extrema andina y costeña, la Erradicación industrial fabril absoluta prohibida capitalista mundial internacional y europea exportadora foránea de Lima, y la Exterminación obligatoria citadina urbana global forzada andina local.',
      'Dimensión de Comercio de Mascotas Andinas felinas y caninas exóticas místicas, la Dimensión de Plásticos de colores vivos de alta demanda asiática y de lujo exclusivo caro importado foráneo local regional, y el Uso de Metales radiactivos y minas atómicas andinas locales para calentamiento e iluminar casas serranas altas nocturnas.',
    ],
    correctAnswer: 1,
    explanation:
        "El Triple Resultado o Balance Integral (Triple Bottom Line): 'Económico, Social y Ambiental'. El desarrollo no puede basarse en destruir el bosque ni explotar a los pueblos (solo ganar dinero PBI ciego depredador). Tampoco puede ser un 'purismo ambiental utópico intocable de selva intocable y vacía de hombre' que mate de hambre y atrase tecnológicamente y frene a la nación en la pobreza inaceptable abyecta inca andina o costeña de invasiones tristes periurbanas. Busca un progreso técnico productivo, pero con riqueza distribuida (Paz Social - PNP) y aire/ríos limpios conservados biológicamente.",
  ),
  Question(
    id: 'cs_q551',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 1)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q552',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 2)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q553',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 3)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q554',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 4)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q555',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 5)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q556',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 6)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q557',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 7)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q558',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 8)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q559',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 9)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q560',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 10)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q561',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 11)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q562',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 12)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q563',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 13)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q564',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 14)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q565',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 15)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q566',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 16)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q567',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 17)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q568',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 18)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q569',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 19)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q570',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 20)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q571',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 21)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q572',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 22)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q573',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 23)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q574',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 24)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q575',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 25)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q576',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 26)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q577',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 27)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q578',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 28)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q579',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 29)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q580',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 30)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q581',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 31)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q582',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 32)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q583',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 33)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q584',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 34)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q585',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 35)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q586',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 36)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q587',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 37)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q588',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 38)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q589',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 39)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q590',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 40)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q591',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 41)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q592',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 42)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q593',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 43)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q594',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 44)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q595',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 45)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q596',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 46)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q597',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 47)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q598',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 48)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q599',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 49)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q600',
    topicId: 'cs_t4',
    text:
        'FIJA ECOSISTEMAS: Capacidad de satisfacer necesidades actuales sin comprometer las futuras: (Var 50)',
    options: [
      'Desarrollo sostenible',
      'Crecimiento económico',
      'Consumismo',
      'Globalización',
    ],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q601',
    topicId: 'cs_t5',
    text:
        'El andamiaje de la infraestructura de transporte terrestre en el país está jerarquizado legal y técnicamente. El conjunto de carreteras que interconectan el territorio de la República y permiten la integración económica y geopolítica se denomina oficialmente:',
    options: [
      'Sistema de Integración Panamericana (SIP).',
      'Red Integrada de Caminos de Herradura.',
      'Sistema Nacional de Carreteras (SINAC).',
      'Plan Vial Urbano Nacional (PVUN).',
      'Red Estratégica del Comando Conjunto.',
    ],
    correctAnswer: 2,
    explanation:
        'El Sistema Nacional de Carreteras (SINAC) es el marco técnico-normativo que agrupa y clasifica todas las vías terrestres del Perú según su importancia y jurisdicción.',
  ),
  Question(
    id: 'cs_q602',
    topicId: 'cs_t5',
    text:
        'Según el Clasificador de Rutas del SINAC, la estructura vial peruana se divide en tres grandes jerarquías dependiendo de la conectividad que brindan y la autoridad responsable de su mantenimiento. Estas tres redes son:',
    options: [
      'Red Vial Nacional, Red Vial Internacional y Red Vial Privada.',
      'Red Vial Costeña, Red Vial Andina y Red Vial Amazónica.',
      'Red Vial Nacional, Red Vial Departamental (o Regional) y Red Vial Vecinal (o Rural).',
      'Red Vial Primaria, Red Vial Secundaria y Caminos de Herradura.',
      'Red Vial Asfaltada, Red Vial Afirmada y Red Vial de Trocha.',
    ],
    correctAnswer: 2,
    explanation:
        'El SINAC clasifica las vías estrictamente por nivel de gobierno responsable: Nacional (MTC), Departamental (Gobiernos Regionales) y Vecinal/Rural (Municipalidades).',
  ),
  Question(
    id: 'cs_q603',
    topicId: 'cs_t5',
    text:
        'Los grandes ejes longitudinales y transversales que conectan las fronteras del país, los principales puertos y las capitales de departamento conforman la Red Vial Nacional. ¿Qué entidad del Poder Ejecutivo tiene la competencia exclusiva sobre el diseño, construcción y mantenimiento de esta red?',
    options: [
      'Las Fuerzas Armadas del Perú.',
      'El Ministerio de Transportes y Comunicaciones (MTC), mediante Provías Nacional.',
      'El Gobierno Regional donde se ubique el tramo carretero.',
      'La Superintendencia de Bienes Nacionales (SBN).',
      'El Ministerio de Vivienda, Construcción y Saneamiento.',
    ],
    correctAnswer: 1,
    explanation:
        'El MTC es el ente rector de la Red Vial Nacional. Su unidad ejecutora, Provías Nacional, se encarga de administrar los proyectos, licitaciones y mantenimiento de las vías de escala nacional.',
  ),
  Question(
    id: 'cs_q604',
    topicId: 'cs_t5',
    text:
        "La 'Red Vial Departamental o Regional' articula fundamentalmente a las capitales de provincia entre sí y con la capital del departamento. La gestión operativa, asfaltado y rehabilitación de estas carreteras recae presupuestalmente sobre:",
    options: [
      'Provías Nacional (MTC).',
      'Las Municipalidades Provinciales.',
      'Las concesionarias extranjeras de peajes.',
      'Los Gobiernos Regionales (GORES), a través de sus Direcciones Regionales de Transportes.',
      'El Fondo Monetario Internacional.',
    ],
    correctAnswer: 3,
    explanation:
        'Como parte del proceso de descentralización, los Gobiernos Regionales asumen la titularidad y responsabilidad directa sobre las carreteras departamentales que vertebran su región.',
  ),
  Question(
    id: 'cs_q605',
    topicId: 'cs_t5',
    text:
        "Existe una vasta red de caminos y trochas carrozables que unen centros poblados menores, comunidades campesinas y caseríos con las capitales de distrito, siendo vitales para sacar los productos agrícolas primarios. Esta red se denomina 'Vecinal o Rural' y está a cargo de:",
    options: [
      'El Banco Agrario.',
      'Las Municipalidades Provinciales y Distritales.',
      'El Ministerio de Defensa.',
      'Provías Nacional.',
      'Las Rondas Campesinas exclusivamente.',
    ],
    correctAnswer: 1,
    explanation:
        'Las autoridades locales (alcaldes provinciales y distritales) tienen la competencia indelegable del mantenimiento y mejoramiento de la red vial vecinal de sus jurisdicciones.',
  ),
  Question(
    id: 'cs_q606',
    topicId: 'cs_t5',
    text:
        "Por su orientación geográfica, las carreteras del Perú se dividen en Longitudinales y de Penetración (o Transversales). Una 'Vía Longitudinal' se caracteriza estrictamente por:",
    options: [
      'Unir la llanura amazónica con la costa peruana superando la cordillera.',
      'Recorrer el territorio nacional de Norte a Sur (o viceversa), integrando regiones de una misma región natural (costa, sierra o selva).',
      'Conectar exclusivamente los puertos marítimos con los aeropuertos.',
      'Tener un recorrido circular alrededor de las grandes capitales (vías de evitamiento).',
      'Atravesar ríos amazónicos sin utilizar puentes colgantes.',
    ],
    correctAnswer: 1,
    explanation:
        'Las vías longitudinales recorren el país a lo largo. Ejemplos clásicos son la Panamericana (a lo largo de la costa), la Longitudinal de la Sierra y la Marginal de la Selva.',
  ),
  Question(
    id: 'cs_q607',
    topicId: 'cs_t5',
    text:
        "La 'Carretera Panamericana' (Ruta PE-1) es el eje longitudinal costeño. Geopolíticamente, su rol para la economía peruana es insustituible porque:",
    options: [
      'Articula los principales enclaves mineros de oro a tajo abierto.',
      'Es la única vía que permite el cruce vehicular hacia el Brasil.',
      'Interconecta los principales puertos marítimos (Callao, Paita, Matarani), polos agroexportadores y ciudades más pobladas, facilitando el comercio exterior e interno masivo.',
      'Sirve exclusivamente para el tránsito de vehículos militares hacia las fronteras.',
      'Garantiza el abastecimiento de gas natural a la sierra sur.',
    ],
    correctAnswer: 2,
    explanation:
        'La Panamericana es la columna vertebral del PBI peruano. Abarca toda la franja costera, donde se asienta la agroindustria de exportación y la principal infraestructura portuaria del Pacífico sudamericano.',
  ),
  Question(
    id: 'cs_q608',
    topicId: 'cs_t5',
    text:
        "En la nomenclatura oficial del SINAC, la Carretera Longitudinal de la Sierra (Ruta PE-3), también conocida en muchos de sus tramos como 'Caminos del Inca', tiene la misión estratégica de:",
    options: [
      'Vincular las ciudades andinas de norte a sur, facilitando el comercio interno de productos agropecuarios serranos sin tener que bajar a la costa.',
      'Conectar el Callao con el cerro de Pasco directamente.',
      'Cruzar la frontera con Colombia por el río Putumayo.',
      'Llevar agua desalinizada desde el Pacífico hacia los glaciares.',
      'Interconectar únicamente las regiones de Arequipa, Moquegua y Tacna.',
    ],
    correctAnswer: 0,
    explanation:
        'La Longitudinal de the Sierra busca romper el aislamiento andino, permitiendo que un productor de Cajamarca pueda vender en Huancayo o Cusco usando un corredor interandino asfaltado, promoviendo el mercado interno.',
  ),
  Question(
    id: 'cs_q609',
    topicId: 'cs_t5',
    text:
        "El proyecto histórico denominado 'Carretera Marginal de la Selva' (Ruta PE-5), impulsado durante el primer belaundismo y hoy rebautizada como Carretera Fernando Belaúnde Terry, tuvo como objetivo geopolítico primario:",
    options: [
      'Aislar a las tribus amazónicas no contactadas.',
      'Construir bases submarinas en la cuenca del Amazonas.',
      'Integrar la ceja de selva (selva alta) al resto del país, promoviendo la colonización productiva de frontera y conectando valles como Huallaga, Chanchamayo y La Convención.',
      'Crear un canal interoceánico navegable desde Tumbes a Iquitos.',
      'Facilitar el éxodo de la población amazónica hacia Lima.',
    ],
    correctAnswer: 2,
    explanation:
        "La Marginal de la Selva se diseñó para vertebrar la selva alta, incorporando inmensos territorios fértiles al agro nacional y estableciendo 'fronteras vivas' para resguardar la soberanía territorial.",
  ),
  Question(
    id: 'cs_q610',
    topicId: 'cs_t5',
    text:
        "A diferencia de las longitudinales, las carreteras 'Transversales' o 'de Penetración' cruzan la abrupta Cordillera de los Andes de Oeste a Este. Su importancia geoeconómica radica fundamentalmente en que:",
    options: [
      'Unen directamente las capitales de provincia de la sierra central.',
      'Atraviesan los tres pisos ecológicos (costa, sierra y selva), permitiendo el intercambio complementario de recursos y enlazando los puertos del Pacífico con la Amazonía.',
      'Solo sirven para conectar aeropuertos internacionales.',
      'Tienen un trazado exclusivamente ferroviario para trenes de carga pesada.',
      'Su construcción está limitada a las zonas desérticas planas.',
    ],
    correctAnswer: 1,
    explanation:
        'Las vías de penetración (ej. la Carretera Central) son los vasos comunicantes que permiten que el pescado de la costa llegue a los Andes, y la madera o frutos de la selva lleguen al puerto del Callao.',
  ),
  Question(
    id: 'cs_q611',
    topicId: 'cs_t5',
    text:
        "La 'Carretera Central' (Ruta PE-22) es la vía transversal más importante y transitada del Perú. Nace en Lima y tras escalar los Andes a más de 4,800 m.s.n.m. en Ticlio, llega a La Oroya donde se bifurca. Esta carretera es el cordón umbilical indispensable para:",
    options: [
      'El abastecimiento de alimentos de primera necesidad (tubérculos, hortalizas) desde el valle del Mantaro hacia la superpoblada capital y el transporte de minerales de exportación al Callao.',
      'La movilización exclusiva de turistas internacionales hacia Machu Picchu.',
      'El transporte de petróleo crudo desde Tumbes hacia Pisco.',
      'La interconexión marítima con los países de Asia-Pacífico.',
      'El abastecimiento de la base naval de Loreto.',
    ],
    correctAnswer: 0,
    explanation:
        'La Carretera Central (y su ramal hacia Huancayo) sostiene la seguridad alimentaria de Lima (Mercado Mayorista) y es la principal vía de evacuación de los concentrados de cobre y zinc de la sierra central al puerto del Callao.',
  ),
  Question(
    id: 'cs_q612',
    topicId: 'cs_t5',
    text:
        'Otro eje transversal gigantesco, culminado en el siglo XXI, es la Carretera Interoceánica Sur. Este megaproyecto vincula los puertos peruanos de Ilo, Matarani y San Juan de Marcona con un país sudamericano vecino, cruzando las regiones de Cusco y Madre de Dios. Este país es:',
    options: ['Ecuador', 'Colombia', 'Chile', 'Bolivia', 'Brasil'],
    correctAnswer: 4,
    explanation:
        'La Interoceánica Sur se diseñó geopolíticamente para conectar la potente economía agraria e industrial de Acre, Rondônia y Mato Grosso (Brasil) con los puertos del Pacífico peruano hacia el mercado asiático.',
  ),
  Question(
    id: 'cs_q613',
    topicId: 'cs_t5',
    text:
        'La infraestructura logística peruana también cuenta con ferrovías (red ferroviaria), aunque escasas. El Ferrocarril Central del Perú, considerado por décadas el más alto del mundo (pasando por La Galera), tiene como función comercial casi exclusiva:',
    options: [
      'El transporte masivo diario de trabajadores oficinistas hacia Lima.',
      'El transporte de concentrados minerales de gran tonelaje desde las minas de Pasco y Junín hasta el puerto del Callao, aliviando el tráfico pesado en la Carretera Central.',
      'El transporte de madera caoba y cedro desde Pucallpa.',
      'El transporte de pescado fresco hacia Huancayo.',
      'Los paseos turísticos de escolares de fin de semana.',
    ],
    correctAnswer: 1,
    explanation:
        'La función primordial del Ferrocarril Central Andino es logística pesada: transportar a bajo costo y con gran seguridad miles de toneladas de minerales concentrados, metales refinados y ácido sulfúrico hacia la costa.',
  ),
  Question(
    id: 'cs_q614',
    topicId: 'cs_t5',
    text:
        "El término 'Concesión Vial' se refiere a un mecanismo jurídico-financiero utilizado por el Estado Peruano para modernizar carreteras. En la práctica, una concesión implica que:",
    options: [
      'El Estado regala la soberanía del territorio a una nación extranjera por 50 años.',
      'El MTC construye la carretera con fondos públicos y luego abandona su mantenimiento.',
      'El Estado otorga temporalmente a un consorcio privado el derecho de construir, operar y mantener una carretera a cambio del cobro de peajes, asumiendo la empresa el riesgo financiero y devolviendo la vía al Estado al terminar el contrato.',
      'Se prohíbe el tránsito de vehículos peruanos y solo se permite tránsito diplomático.',
      'El Banco de la Nación asume el cobro directo y manual de las garitas.',
    ],
    correctAnswer: 2,
    explanation:
        'Las concesiones (Asociaciones Público-Privadas) permiten dotar de infraestructura de clase mundial (autopistas, puentes, túneles) sin agotar el erario público, financiándose mediante el peaje pagado por los usuarios (OSITRAN supervisa el contrato).',
  ),
  Question(
    id: 'cs_q615',
    topicId: 'cs_t5',
    text:
        'A nivel de fiscalización de contratos de concesión en infraestructura de transporte (puertos, aeropuertos, carreteras y vías férreas concesionadas), el Estado cuenta con un organismo regulador autónomo que asegura que los privados cumplan las inversiones prometidas y el mantenimiento de las pistas. Este ente es:',
    options: ['INDECOPI', 'SUTRAN', 'OSITRAN', 'SUNASS', 'OSINERGMIN'],
    correctAnswer: 2,
    explanation:
        'El Organismo Supervisor de la Inversión en Infraestructura de Transporte de Uso Público (OSITRAN) regula y supervisa a las empresas concesionarias (ej. Rutas de Lima, Lima Expresa, LAP, puertos).',
  ),
  Question(
    id: 'cs_q616',
    topicId: 'cs_t5',
    text:
        'En materia de control operativo y administrativo de los vehículos, empresas de buses y camiones pesados que circulan por la Red Vial Nacional, la competencia fiscalizadora (como revisar excesos de peso, bitácoras de manejo, SOAT y tarjetas de circulación interprovincial) corresponde al MTC a través de:',
    options: [
      'PROMPERÚ',
      'SUTRAN',
      'Los Gobiernos Regionales',
      'OSITRAN',
      'El Ministerio Público',
    ],
    correctAnswer: 1,
    explanation:
        'La Superintendencia de Transporte Terrestre de Personas, Carga y Mercancías (SUTRAN) es la entidad pública fiscalizadora del cumplimiento normativo del transporte en las carreteras (operativos de control, pesaje, balanzas).',
  ),
  Question(
    id: 'cs_q617',
    topicId: 'cs_t5',
    text:
        'El orden interno en las carreteras trasciende la labor administrativa. La prevención del asalto a mano armada, secuestros de buses, tráfico ilícito de drogas (TID), minería ilegal y el restablecimiento del orden en caso de bloqueos carreteros (toma de vías) recae constitucional y operativamente sobre:',
    options: [
      'Los inspectores de SUTRAN.',
      'El Serenazgo sin fronteras.',
      'La Dirección de Protección de Carreteras de la Policía Nacional del Perú (DIRPRCAR-PNP).',
      'El Ejército Peruano por defecto.',
      'Las Rondas Campesinas empadronadas.',
    ],
    correctAnswer: 2,
    explanation:
        'La Policía de Carreteras (PNP) tiene el monopolio legal del uso de la fuerza pública, siendo la unidad élite responsable de salvaguardar la vida, el orden público y combatir el crimen organizado en la vasta red vial.',
  ),
  Question(
    id: 'cs_q618',
    topicId: 'cs_t5',
    text:
        "El 'Cabotaje' es un concepto de transporte que el Estado busca potenciar para descongestionar la Carretera Panamericana y reducir los letales accidentes de tránsito de flotas de camiones. ¿Qué es el transporte por cabotaje?",
    options: [
      'El transporte de carga mediante helicópteros de ala rotatoria.',
      'El transporte marítimo de mercancías y contenedores entre puertos del mismo país (ej. de Paita al Callao) utilizando buques comerciales costeros.',
      'El uso exclusivo de mulas y caballos para cargas pesadas en la cordillera.',
      'El transporte subterráneo mediante trenes metropolitanos profundos.',
      'La construcción de teleféricos gigantes entre los Andes y la Costa.',
    ],
    correctAnswer: 1,
    explanation:
        'Fomentar el cabotaje (transporte marítimo interno) retira miles de tráileres pesados de la Panamericana, reduciendo costos logísticos, contaminación (PM2.5) y mortalidad por accidentes de tránsito.',
  ),
  Question(
    id: 'cs_q619',
    topicId: 'cs_t5',
    text:
        'En la región selva, debido a la inmensidad del territorio, la densidad del bosque y las intensas lluvias que encarecen el asfaltado, el principal medio de transporte histórico y logístico para mercancías pesadas y pasajeros no son las carreteras, sino:',
    options: [
      'Las flotas de avionetas fumigadoras.',
      'El transporte ferroviario elevado.',
      'La Red Fluvial (ríos navegables) utilizando embarcaciones tipo lancha, peque-peque y yates.',
      'Las rutas de glaciares antárticos.',
      'Los teleféricos interregionales.',
    ],
    correctAnswer: 2,
    explanation:
        "La selva baja (Loreto, Ucayali) depende casi exclusivamente de sus 'carreteras de agua' (el río Amazonas, Ucayali, Marañón). Iquitos, la capital loretana, es famosa por ser la ciudad más grande del mundo sin conexión vial terrestre exterior.",
  ),
  Question(
    id: 'cs_q620',
    topicId: 'cs_t5',
    text:
        'El asfaltado de carreteras en zonas productoras de hoja de coca (como el VRAEM) impacta severamente en las dinámicas del narcotráfico. Desde el punto de vista del desarrollo sostenido y control estatal, las buenas carreteras en estas zonas:',
    options: [
      'Facilitan la exportación de droga mediante tráileres gigantes intocables.',
      'Destruyen la agricultura lícita al permitir la entrada de plagas extranjeras.',
      'Elevan el costo del flete, quebrando a los campesinos.',
      'Permiten a los agricultores sacar sus cultivos alternativos (café, cacao) rápidamente hacia mercados costeños a bajo costo de flete, reduciendo su dependencia económica de las mafias cocaleras.',
      'Impulsan a los campesinos a construir aeropuertos clandestinos más grandes.',
    ],
    correctAnswer: 3,
    explanation:
        'El aislamiento vial eleva artificialmente los fletes de transporte, haciendo inviable sembrar cultivos lícitos de gran volumen y bajo precio. El narcotráfico aprovecha el aislamiento comprando cocaína (poco volumen/alto precio). Una carretera asfaltada fomenta el agro lícito (café/cacao) al abaratar fletes.',
  ),
  Question(
    id: 'cs_q621',
    topicId: 'cs_t5',
    text:
        "La infraestructura vial es un pilar de la Defensa Nacional. Las denominadas 'Vías de Frontera Viva', además de su función comercial de intercambio binacional, tienen el propósito geopolítico tácito de:",
    options: [
      'Provocar militarmente a los países vecinos con maniobras armadas.',
      'Permitir el libre contrabando de recursos forestales.',
      'Fomentar asentamientos poblacionales estables y la presencia constante de instituciones del Estado (Aduanas, PNP) en los límites limítrofes, evitando el vacío de soberanía.',
      'Crear zanjas profundas para evitar la migración peatonal.',
      'Facilitar la fuga de capitales hacia paraísos fiscales.',
    ],
    correctAnswer: 2,
    explanation:
        "Una 'frontera viva' es un área limítrofe poblada y desarrollada (como Tacna o Tumbes). Las carreteras de frontera permiten que el Estado peruano proyecte poder blando y soberanía indiscutible, evitando reclamos territoriales por abandono.",
  ),
  Question(
    id: 'cs_q622',
    topicId: 'cs_t5',
    text:
        "Los 'Pasos a Desnivel' (Intercambios Viales) y 'Vías de Evitamiento' son soluciones de ingeniería civil obligatorias en la Red Vial Nacional contemporánea cuando esta se aproxima a capitales de provincia o megaciudades. Su función técnico-social principal es:",
    options: [
      'Aumentar el cobro de arbitrios municipales.',
      'Desviar el flujo de vehículos de tránsito pesado o interprovincial por el perímetro de la ciudad, evitando que congestionen y destruyan las calles urbanas del centro poblado.',
      'Forzar a los camiones a comprar en los mercados locales céntricos.',
      'Crear pistas de carreras para competencias de autos deportivos clandestinas.',
      'Atrapar la contaminación en el centro histórico de la ciudad.',
    ],
    correctAnswer: 1,
    explanation:
        "Una 'Vía de Evitamiento' (bypass carretero) canaliza el tránsito pesado de largo aliento por fuera del casco urbano, previniendo accidentes fatales con peatones y liberando el tránsito local citadino.",
  ),
  Question(
    id: 'cs_q623',
    topicId: 'cs_t5',
    text:
        "Para un operativo de prevención, el efectivo de carreteras debe conocer la Nomenclatura del SINAC. Si en un reporte radial se indica que un accidente con víctimas ocurrió en el kilómetro 120 de la vía 'PE-1N', las letras 'PE' y el número y letra '1N' significan que:",
    options: [
      'Es una pista exclusiva (PE) número 1 de noche (N).',
      'Es una Vía Nacional del Perú (PE), correspondiente al Eje Panamericano (1) en su tramo Norte (N).',
      'Es un Peaje Estadal (PE) del Distrito 1 Nuevo (1N).',
      'Es un Pase Ecológico (PE) de 1 nivel (1N).',
      'Es una Proyección Estratégica (PE) del tramo 1 de Napo (1N).',
    ],
    correctAnswer: 1,
    explanation:
        "En la nomenclatura oficial, 'PE' indica Perú (Red Vial Nacional). '1' es el código del Eje Longitudinal de la Costa (Panamericana). 'N' o 'S' indican el tramo Norte o Sur desde el kilómetro cero en Lima (Km 0 en Santa Anita).",
  ),
  Question(
    id: 'cs_q624',
    topicId: 'cs_t5',
    text:
        'El kilómetro cero de la Carretera Central (PE-22) y el punto tradicional de referencia para la medición kilométrica hacia el este (selva y sierra central), el norte y el sur de las grandes rutas nacionales peruanas, está ubicado histórica y monumentalmente en el distrito limeño de:',
    options: [
      'Miraflores (Parque Kennedy).',
      'Callao (Plaza Grau).',
      'Santa Anita (Ovalo de Santa Anita).',
      'Cercado de Lima (Plaza Mayor).',
      'San Juan de Lurigancho.',
    ],
    correctAnswer: 2,
    explanation:
        'Geográficamente para fines viales modernos, el kilómetro cero o punto de inicio para la Carretera Central se considera en el Óvalo de Santa Anita (antes en la Plaza San Martín y Palacio de Justicia).',
  ),
  Question(
    id: 'cs_q625',
    topicId: 'cs_t5',
    text:
        'Según el Código Penal peruano, la paralización sistemática de la infraestructura del país constituye un delito. Bloquear, entorpecer o interrumpir con violencia o amenaza el normal funcionamiento de las vías de comunicación (toma de carreteras con llantas encendidas, piedras o piquetes), impidiendo el libre tránsito de ambulancias, pasajeros y alimentos, se tipifica jurídicamente como delito de:',
    options: [
      'Disturbios pacíficos amparados por la libertad de expresión.',
      'Entorpecimiento al funcionamiento de servicios públicos (Delito contra la Seguridad Pública).',
      'Sedición militar leve.',
      'Desobediencia tributaria agravada.',
      'Faltas contra el patrimonio edilicio menor.',
    ],
    correctAnswer: 1,
    explanation:
        'El bloqueo de carreteras (muy común en paros agrarios o regionales) está explícitamente tipificado en el Código Penal. La PNP, tras agotar el diálogo, tiene el mandato constitucional de despejar las vías, pues el bloqueo vulnera derechos fundamentales y el abastecimiento nacional.',
  ),
  Question(
    id: 'cs_q626',
    topicId: 'cs_t5',
    text:
        'El Perú posee uno de los puertos más importantes de la costa oeste de Sudamérica y del Pacífico Sur. Su desarrollo en infraestructura (megapuertos, grúas pórtico, dragado profundo) y su conectividad vial directa permiten concentrar más del 70% del comercio exterior peruano. Este puerto emblemático es:',
    options: [
      'Puerto de Paita.',
      'Puerto de Matarani.',
      'Puerto Fluvial de Iquitos.',
      'Puerto del Callao (Muelle Sur y Muelle Norte).',
      'Puerto de Salaverry.',
    ],
    correctAnswer: 3,
    explanation:
        "El Callao (administrado por concesionarios como DP World y APM Terminals) es el 'Hub' portuario del país, recibiendo buques Post-Panamax que transportan los contenedores de importación y exportación de la economía peruana.",
  ),
  Question(
    id: 'cs_q627',
    topicId: 'cs_t5',
    text:
        'El futuro de las redes comerciales peruanas hacia el Asia está impulsado por la reciente construcción de un inmenso megapuerto en la costa norte central, operado con capitales chinos y tecnología robótica automatizada, diseñado para recibir los buques cargueros más grandes del mundo que ya no tendrán que hacer escala en México o Estados Unidos. Este megapuerto se ubica en:',
    options: [
      'Ilo, Moquegua.',
      'Chancay, Lima.',
      'Paita, Piura.',
      'San Nicolás, Ica.',
      'Corío, Arequipa.',
    ],
    correctAnswer: 1,
    explanation:
        'El Megapuerto de Chancay revoluciona la red vial y marítima sudamericana. Se convertirá en el gran hub logístico del Pacífico Sur, reduciendo en 10 días el viaje en barco hacia Shanghái (China).',
  ),
  Question(
    id: 'cs_q628',
    topicId: 'cs_t5',
    text:
        'Las carreteras transversales deben superar la inmensa barrera orográfica de la Cordillera de los Andes. Los puntos más bajos de las cadenas montañosas por donde cruzan las carreteras para pasar de la costa a la sierra, o de una cuenca a otra, son conocidos geográficamente como:',
    options: [
      'Pongos.',
      'Valles en V.',
      'Cañones.',
      'Mesetas.',
      'Pasos o Abras.',
    ],
    correctAnswer: 4,
    explanation:
        'Un Paso o Abra (ej. Abra de Ticlio o Anticona) es la depresión en la cresta de la cordillera que permite el paso terrestre de una vertiente a otra a la menor altura posible.',
  ),
  Question(
    id: 'cs_q629',
    topicId: 'cs_t5',
    text:
        "A diferencia de las Abras, por donde cruzan las carreteras andinas, los 'Pongos' son impresionantes cañones formados por la intensa erosión de los ríos caudalosos que cortan la cordillera transversalmente para llegar a la Amazonía. ¿Qué infraestructura de importancia estratégica nacional suele construirse aprovechando la fuerza del agua en los cañones andinos y pongos?",
    options: [
      'Puertos marítimos de aguas profundas.',
      'Grandes centrales hidroeléctricas (represas).',
      'Pistas de aterrizaje comerciales para aviones jumbo.',
      'Campos de energía solar fotovoltaica masiva.',
      'Aerogeneradores de viento de baja altitud.',
    ],
    correctAnswer: 1,
    explanation:
        'La estrechez de un pongo o cañón (ej. Pongo de Manseriche, Cañón del Pato) facilita represar el río y concentrar el caudal con gran presión, condición ideal para mover las turbinas de inmensas centrales hidroeléctricas.',
  ),
  Question(
    id: 'cs_q630',
    topicId: 'cs_t5',
    text:
        "La 'Vía de los Libertadores Wari' es un corredor vial estratégico y emblemático que cruza la cordillera uniendo la costa sur con la sierra sur central, dinamizando la economía andina. Específicamente, esta carretera une de manera asfaltada y directa las regiones de:",
    options: [
      'Lima con Huancayo.',
      'Ica con Ayacucho.',
      'Arequipa con Puno.',
      'La Libertad con Cajamarca.',
      'Tacna con Moquegua.',
    ],
    correctAnswer: 1,
    explanation:
        'La Vía de los Libertadores parte desde San Clemente (Pisco, Ica), atraviesa Huaytará (Huancavelica) y culmina en la ciudad de Ayacucho, siendo la arteria vital para el comercio ayacuchano y el turismo de Semana Santa.',
  ),
  Question(
    id: 'cs_q631',
    topicId: 'cs_t5',
    text:
        "En la región costera, la Carretera Panamericana atraviesa extensas franjas de desierto. Para evitar que las dunas de arena en movimiento (barjanes) invadan y sepulten el asfalto producto del viento paracas, la ingeniería vial implementa a menudo soluciones ecológicas llamadas 'cortinas rompevientos', que consisten en:",
    options: [
      'Muros de acero sólido de 20 metros de alto a lo largo de toda la pista.',
      'Grandes tuberías que expulsan agua a presión para mojar los autos.',
      'Hileras tupidas de árboles (como casuarinas o eucaliptos) plantados al borde de la vía para disminuir la velocidad del viento erosivo.',
      'Canales de desvío subterráneos para las arenas movedizas.',
      'Techos de policarbonato sobre cientos de kilómetros de carretera.',
    ],
    correctAnswer: 2,
    explanation:
        'Las cortinas de árboles rompevientos actúan como una red biológica. Frenan la velocidad del viento cargado de arena, obligando a la duna a depositar sus sedimentos antes de llegar al asfalto (muy usado en Pasamayo e Ica).',
  ),
  Question(
    id: 'cs_q632',
    topicId: 'cs_t5',
    text:
        'El transporte multimodal combina varias redes (marítima, ferroviaria, carretera) para lograr máxima eficiencia logística. Para que la ciudad de Pucallpa (Ucayali) se integre a este corredor interoceánico multimodal enviando su madera al Pacífico y al Atlántico brasileño, el gobierno construyó el eje transversal llamado:',
    options: [
      'Carretera Marginal de la Selva (PE-5).',
      'Carretera Federico Basadre (Prolongación de la Carretera Central que llega a Ucayali).',
      'Autopista Ramiro Prialé.',
      'Vía Expresa del Callao.',
      'Carretera Costanera Sur.',
    ],
    correctAnswer: 1,
    explanation:
        'La carretera Federico Basadre (Ruta PE-5N y conexiones transversales) es la extensión oriental de la Carretera Central que, tras pasar Huánuco y Tingo María, culmina en Pucallpa (río Ucayali), formando un corredor bioceánico bimodal terrestre/fluvial.',
  ),
  Question(
    id: 'cs_q633',
    topicId: 'cs_t5',
    text:
        'La infraestructura aeroportuaria es un componente vital de las redes de interconexión (SINAC en sentido amplio de transportes). El Aeropuerto Internacional Jorge Chávez es el principal nodo aéreo del Perú. Su actual modernización incluye un megaproyecto de ingeniería que duplicará su capacidad operativa, el cual consiste primariamente en:',
    options: [
      'La construcción de una segunda pista de aterrizaje comercial en la Isla San Lorenzo.',
      'La demolición total del aeropuerto actual para trasladarlo a las pampas de Ancón.',
      'La construcción de una Segunda Pista de aterrizaje paralela, una nueva torre de control inteligente y un nuevo terminal de pasajeros del tamaño de un estadio.',
      'La habilitación de pistas flotantes sobre el mar del Callao.',
      'El soterramiento total de las pistas de despegue bajo tierra.',
    ],
    correctAnswer: 2,
    explanation:
        "El proyecto de expansión del Jorge Chávez (LAP) contempla la operación simultánea de dos pistas de aterrizaje y un terminal aéreo ultramoderno para convertirlo en el principal 'Hub' aeronáutico comercial de la región andina.",
  ),
  Question(
    id: 'cs_q634',
    topicId: 'cs_t5',
    text:
        "El MTC dicta los Pesos y Medidas máximas permitidas para vehículos pesados (tráileres, camiones). La importancia estructural de los operativos policiales y de SUTRAN para evitar la circulación de vehículos con 'sobrepeso' radica en que:",
    options: [
      'El sobrepeso hace que los camiones vuelen al pasar badenes rápidos.',
      'El exceso de carga destruye la capa de rodadura (asfalto) exponencialmente, acorta la vida útil del puente, genera millonarios sobrecostos de mantenimiento al Estado e incrementa drásticamente la distancia de frenado causando accidentes mortales.',
      'Los camiones con sobrepeso gastan menos combustible y el Estado pierde impuestos a la gasolina.',
      'El peso extra genera campos electromagnéticos que interfieren con las radios policiales.',
      'La llanta pesada borra las líneas blancas de los peatones.',
    ],
    correctAnswer: 1,
    explanation:
        'El daño a la carretera crece en proporción a la cuarta potencia del peso por eje. Un tráiler sobrecargado destruye el asfalto miles de veces más rápido que un auto particular, hundiendo la pista y quebrando las uniones de los puentes.',
  ),
  Question(
    id: 'cs_q635',
    topicId: 'cs_t5',
    text:
        'Una infraestructura moderna y costosa necesaria para superar accidentes geográficos insalvables por la carretera (como grandes ríos amazónicos o abismos interandinos) son los Puentes de gran luz. El puente atirantado más largo e importante de la Amazonía peruana, inaugurado en Madre de Dios sobre un inmenso río para completar la ruta Interoceánica Sur, es el:',
    options: [
      'Puente de los Suspiros.',
      'Puente Balta.',
      'Puente Billinghurst (Puente Continental).',
      'Puente de las Américas.',
      'Puente de Piedra del Rímac.',
    ],
    correctAnswer: 2,
    explanation:
        'El Puente Continental (anteriormente Billinghurst) en Puerto Maldonado es un imponente puente colgante de acero que cruza el río Madre de Dios, eliminando el tortuoso cruce por barcazas y agilizando el flujo internacional de carga.',
  ),
  Question(
    id: 'cs_q636',
    topicId: 'cs_t5',
    text:
        'En zonas andinas, las carreteras vecinales frecuentemente no tienen asfalto (carpeta bituminosa) debido al bajo tránsito o falta de presupuesto, sino una capa estabilizada de ripio, grava y arcilla compactada que resiste mejor las lluvias que la tierra pura. A este tipo de vía, paso intermedio entre la trocha carrozable y el asfalto, se le conoce técnicamente como:',
    options: [
      'Vía Adoquinada.',
      'Vía Afirmada.',
      'Vía Macadam.',
      'Vía Empedrada.',
      'Autopista Pircada.',
    ],
    correctAnswer: 1,
    explanation:
        "El 'Afirmado' es una capa de material granular compactado mecánicamente con motoniveladoras y rodillos vibratorios. Constituye el grueso de las carreteras secundarias peruanas, requiriendo mantenimiento constante tras los huaicos.",
  ),
  Question(
    id: 'cs_q637',
    topicId: 'cs_t5',
    text:
        'A nivel logístico, el alto costo del peaje, la gasolina y el tiempo perdido en el tráfico urbano encarecen los productos para el consumidor final. Esto se engloba dentro de un concepto económico que mide cuán caro es mover un producto desde la chacra o fábrica hasta el mercado final. Este concepto es el:',
    options: [
      'Impuesto a la Renta de 3ra Categoría.',
      'Arancel aduanero variable.',
      'Costo Logístico o Flete de Transporte.',
      'Sobrecargo de Plusvalía marxista.',
      'Depreciación de capital fijo.',
    ],
    correctAnswer: 2,
    explanation:
        'La infraestructura deficiente eleva el Costo Logístico. Si un camión de papas de Huánuco demora dos días en cruzar la Carretera Central por el tráfico, el costo de la papa en Lima sube y el agricultor gana menos.',
  ),
  Question(
    id: 'cs_q638',
    topicId: 'cs_t5',
    text:
        "En geografía, para identificar la Red Vial, es necesario diferenciarla de la 'Red Hidrográfica'. Mientras la red vial es un sistema de infraestructura artificial, la red hidrográfica conforma los cauces de agua. Sin embargo, ¿qué río amazónico (red hidrográfica) funciona legalmente como una 'Autopista Fluvial' al ser navegable por buques de mediano calado desde Iquitos hasta el Océano Atlántico (Brasil)?",
    options: [
      'El río Marañón.',
      'El río Apurímac.',
      'El río Urubamba.',
      'El río Amazonas.',
      'El río Santa.',
    ],
    correctAnswer: 3,
    explanation:
        'El Amazonas (y su continuación en Brasil, el río Solimões) es la arteria fluvial comercial más grande de Sudamérica. Su gran profundidad y caudal permiten el transporte de gran tonelaje hasta el Atlántico sin carreteras.',
  ),
  Question(
    id: 'cs_q639',
    topicId: 'cs_t5',
    text:
        "Para mitigar los accidentes de tránsito en la Panamericana y la Carretera Central, la normativa exige el uso de la 'Cinta Reflectiva' en camiones de carga y la presencia de delineadores (tachas reflectivas u 'ojos de gato') en el asfalto. Estos elementos tecnológicos de infraestructura vial cumplen la función de:",
    options: [
      'Disuadir el cruce de animales silvestres.',
      'Servir de lomo de burro (rompemuelles) para frenar camiones.',
      'Mejorar exponencialmente la visibilidad nocturna pasiva y demarcar los límites del carril en condiciones de niebla densa o nula iluminación.',
      'Cargar la batería de los autos eléctricos al pasar por encima.',
      'Medir automáticamente la velocidad del viento lateral.',
    ],
    correctAnswer: 2,
    explanation:
        'La seguridad vial nocturna depende de la demarcación reflectante (las tachas que devuelven la luz de los faros), especialmente en vías sin alumbrado público, guiando al conductor para no caer a los abismos en la sierra.',
  ),
  Question(
    id: 'cs_q640',
    topicId: 'cs_t5',
    text:
        'El ordenamiento territorial implica conocer las barreras naturales. El trazo de la Carretera Panamericana Sur, entre las regiones de Arequipa y Moquegua, debe sortear extensas pampas desérticas, valles y profundas depresiones volcánicas. ¿Qué megaproyecto de infraestructura debe construirse invariablemente cuando una carretera nacional se topa transversalmente con un cañón o quebrada de más de 100 metros de profundidad?',
    options: [
      'Un túnel submarino excavado en la roca volcánica.',
      'Un paso a desnivel trébol de tres hojas.',
      'Un puente monumental de concreto postensado o estructura metálica atirantada/colgante.',
      'Una estación de trenes de levitación magnética.',
      'Una escollera de rocas macizas hasta llenar el abismo.',
    ],
    correctAnswer: 2,
    explanation:
        'Los viaductos y puentes (ej. Puente Chili, Puentes en Sullana) son las soluciones de ingeniería civil obligatorias para salvar abismos y mantener pendientes suaves en carreteras de alto tránsito y velocidad (evitando curvas de herradura).',
  ),
  Question(
    id: 'cs_q641',
    topicId: 'cs_t5',
    text:
        'Al fiscalizar el transporte interprovincial de pasajeros, la DIRPRCAR (Carreteras) debe vigilar el cumplimiento de la norma de manejo para prevenir accidentes por fatiga (sueño). El MTC establece que en la Red Vial Nacional, un chofer de bus de pasajeros NO debe manejar sin descanso más de:',
    options: [
      '2 horas continuas de día o 1 de noche.',
      '5 horas continuas de día o 4 horas de noche.',
      '12 horas ininterrumpidas usando café.',
      '24 horas seguidas, siempre que haya luna llena.',
      '8 horas sin parar si la carretera está asfaltada.',
    ],
    correctAnswer: 1,
    explanation:
        'El D.S. 017-2009-MTC exige el recambio de conductor (chofer copiloto) cada 5 horas de manejo diurno o 4 horas en horario nocturno, para prevenir el microsueño, causa de los desbarrancamientos masivos.',
  ),
  Question(
    id: 'cs_q642',
    topicId: 'cs_t5',
    text:
        'En la región Ancash, una importante vía transversal parte del puerto de Chimbote, cruza la Cordillera Negra mediante el túnel del Pato Alto, e ingresa al espectacular Callejón de Huaylas para llegar a Huaraz. Esta ruta, clave para el agro y el turismo andinista del Huascarán, fue diseñada tras el terremoto de 1970 y se caracteriza por:',
    options: [
      'Estar conformada exclusivamente por puentes de soga incaicos.',
      'Atravesar el impresionante Cañón del Pato mediante decenas de túneles consecutivos tallados en pura roca por donde discurre el río Santa.',
      'Ser una carretera de hielo utilizable solo en invierno.',
      'Tener peajes cobrados exclusivamente en moneda extranjera.',
      'Poseer un tren bala magnético paralelo.',
    ],
    correctAnswer: 1,
    explanation:
        'La carretera que atraviesa el Cañón del Pato (Caraz-Huallanca) es una joya de la ingeniería vial peruana, conformada por 35 túneles de un solo carril tallados en la roca viva, uniendo la sierra ancashina con la costa.',
  ),
  Question(
    id: 'cs_q643',
    topicId: 'cs_t5',
    text:
        "El término técnico de ingeniería 'Derecho de Vía' es vital para la labor municipal y policial. Cuando personas invaden con casas rústicas los bordes de la Carretera Panamericana o Autopistas, están cometiendo un delito, ya que el 'Derecho de Vía' se define como:",
    options: [
      'El peaje voluntario que los camioneros donan a la comisaría del sector.',
      'La licencia de conducir vitalicia otorgada a exmilitares.',
      'La franja de terreno intangible, reservada por el Estado a cada lado del eje de la carretera, destinada a futuras ampliaciones, señalización y zonas de seguridad para despistes, donde está totalmente prohibido construir o sembrar.',
      'El pago mensual que hacen las empresas privadas por circular sus flotas.',
      'La preferencia de paso del vehículo más grande en una rotonda.',
    ],
    correctAnswer: 2,
    explanation:
        'El Derecho de Vía (frecuentemente de 15 a 30 metros a cada lado desde el eje) es propiedad estatal inalienable. Construir dentro de él impide ampliar la vía, dificulta el drenaje pluvial y expone a los invasores a accidentes fatales (estrellamientos de tráileres).',
  ),
  Question(
    id: 'cs_q644',
    topicId: 'cs_t5',
    text:
        "En la ciudad de Lima existe una red vial subterránea (metro) y una red de corredores segregados masivos rápidos superficiales de gran importancia conocidos como el Metropolitano. El objetivo macroeconómico y ecológico de implementar 'Sistemas de Transporte Masivo' como el Metro es:",
    options: [
      'Elevar la tarifa del pasaje para hacer más ricos a los operadores privados de combis.',
      'Fomentar la importación masiva de autos usados asiáticos con timón cambiado.',
      'Reducir los tiempos de viaje (costos logísticos), desincentivar el uso ineficiente del auto particular, bajar la emisión de GEI y ordenar estructuralmente la informalidad del tráfico urbano.',
      'Eliminar el uso de tarjetas de crédito en el país fomentando el pago en moneda fraccionaria.',
      'Destruir los restos arqueológicos subyacentes bajo el casco urbano de Lima.',
    ],
    correctAnswer: 2,
    explanation:
        "El transporte masivo eléctrico (Metro) es la columna vertebral de una 'Smart City'. Un solo tren de 6 vagones transporta a más de mil personas sin emitir humo de combustión y en la mitad del tiempo que cientos de autos en la congestión superficial.",
  ),
  Question(
    id: 'cs_q645',
    topicId: 'cs_t5',
    text:
        'Para un operativo Antidrogas (DIRANDRO) es vital entender la logística criminal. Los traficantes de Puno suelen llevar cocaína hacia Bolivia evadiendo la Panamericana Sur, utilizando una multitud de trochas fronterizas, lagos y caminos sin asfaltar que conectan caseríos. Estas rutas informales y dispersas en la frontera, ajenas a las garitas oficiales (CEBAF), se conocen comúnmente como:',
    options: [
      'Rutas concesionadas de Provías.',
      'Caminos reales del Qhapaq Ñan.',
      'Corredores bioceánicos de alta montaña.',
      'Pasos fronterizos clandestinos (o rutas de contrabando).',
      'Ciclovías interregionales turísticas.',
    ],
    correctAnswer: 3,
    explanation:
        "El Altiplano peruano-boliviano es extremadamente poroso geográficamente. El contrabando y el tráfico de drogas utilizan estas múltiples trochas (o 'culebras' de camiones) y embarcaciones lacustres que cruzan el límite evadiendo el control aduanero centralizado de Desaguadero.",
  ),
  Question(
    id: 'cs_q646',
    topicId: 'cs_t5',
    text:
        'El Perú firmó la iniciativa sudamericana IIRSA (Integración de la Infraestructura Regional Suramericana). El principal postulado de esta iniciativa es:',
    options: [
      'Armar una alianza militar continental contra Estados Unidos.',
      'Cerrar las fronteras aduaneras a los productos asiáticos mediante muros.',
      'Planificar y construir redes conjuntas de transporte, energía y comunicaciones (corredores viales interoceánicos, fibra óptica, hidroeléctricas) entre los países de la UNASUR para impulsar el mercado continental equitativo.',
      'Expropiar todas las minas de oro chilenas y peruanas y entregarlas a Europa.',
      'Obligar a todos los países andinos a usar el peso argentino como moneda única.',
    ],
    correctAnswer: 2,
    explanation:
        'IIRSA buscó articular físicamente Sudamérica. De allí nacen los ejes (ej. Eje Amazonas, Eje Andino) para que las carreteras de Perú empaten con las de Ecuador, Colombia o Brasil, permitiendo el flujo continuo de mercadería y personas.',
  ),
  Question(
    id: 'cs_q647',
    topicId: 'cs_t5',
    text:
        'Un elemento clave en la gestión y prevención de accidentes en carreteras andinas (y que la PNP debe reportar al MTC) son las fallas geológicas o deslizamientos continuos producto de las fuertes precipitaciones y la falta de cobertura vegetal en laderas empinadas. A las masas de lodo y roca que destruyen intermitentemente tramos carreteros completos en temporada de lluvias se les denomina andinamente:',
    options: [
      'Tsunamis de sierra.',
      'Erupciones freáticas.',
      'Huaicos (Llocllas).',
      'Tornados de polvo.',
      'Licuefacción de glaciares.',
    ],
    correctAnswer: 2,
    explanation:
        'Los huaicos (flujos de detritos) son el principal causante de la destrucción de la infraestructura vial de penetración en el Perú. Ocurren masivamente durante el Fenómeno del Niño o la temporada de lluvias (enero-marzo) al saturarse los suelos.',
  ),
  Question(
    id: 'cs_q648',
    topicId: 'cs_t5',
    text:
        'Para solventar el elevado costo de construcción de puentes o mantenimientos mayores en vías que no fueron entregadas en concesión privada (ej. la antigua Panamericana no concesionada), el Estado recurre al mecanismo legal y constitucional de cobrar un tributo directo a los usuarios (conductores) cada cierta cantidad de kilómetros recorridos. Este pago se llama:',
    options: [
      'Impuesto General a las Ventas (IGV).',
      'Impuesto a la Renta o Retención de haberes.',
      'Peaje (tasa o derecho de paso).',
      'Alcabalas y diezmos eclesiásticos.',
      'Regalías mineras indirectas.',
    ],
    correctAnswer: 2,
    explanation:
        'El Peaje es la tasa que se cobra por el uso de la infraestructura vial interurbana, destinado (por Provías o por el Concesionario privado) exclusiva e ineludiblemente al mantenimiento asfáltico, limpieza, grúas y auxilio mecánico de dicha vía.',
  ),
  Question(
    id: 'cs_q649',
    topicId: 'cs_t5',
    text:
        "La red vial más moderna del norte peruano, diseñada para facilitar la exportación de agroindustria (espárragos, arándanos) y conocida como Autopista del Sol (tramos Trujillo - Chiclayo - Piura - Sullana), se diferencia técnicamente de una 'carretera simple' de la sierra porque cuenta en todo su trayecto con:",
    options: [
      'Suelo afirmado de ripio y semáforos en cada esquina.',
      'Un solo carril reversible donde los autos deben alternar su paso usando el claxon.',
      'Calzadas separadas físicamente por un separador central (berma), con dos o más carriles por sentido de circulación, pasos a desnivel y control total de accesos (evitando cruces a nivel).',
      'Un techo de concreto abovedado para evitar las lluvias torrenciales del desierto.',
      'Carriles exclusivos magnetizados para el uso de trenes de levitación.',
    ],
    correctAnswer: 2,
    explanation:
        "Una 'Autopista' es el estándar más alto de seguridad y velocidad. Posee dos calzadas separadas por un muro o berma verde (impidiendo los letales choques frontales), varios carriles de adelantamiento y cruces mediante intercambios viales (pasos a desnivel).",
  ),
  Question(
    id: 'cs_q650',
    topicId: 'cs_t5',
    text:
        'Como epílogo a Ciencias Sociales: El desarrollo territorial y vial no es un fin en sí mismo, sino un medio. Según la Constitución Política del Perú, ¿cuál es el Fin Supremo de la sociedad y del Estado, hacia el cual deben orientarse todas las obras de infraestructura, políticas ambientales y el accionar de la Policía Nacional?',
    options: [
      'La erradicación total y dogmática del comercio internacional sin excepciones.',
      'La defensa de la persona humana y el respeto de su dignidad.',
      'El incremento incesante y exponencial de la riqueza corporativa privada y las exportaciones mineras.',
      'La sumisión absoluta del ciudadano frente al poderío bélico y administrativo del gobierno central.',
      'La conquista tecnológica del continente sudamericano mediante una confederación armada.',
    ],
    correctAnswer: 1,
    explanation:
        'El Artículo 1° de la Constitución es el pilar de toda la doctrina nacional. La construcción de un puente (para conectar un pueblo), la protección de un Parque Nacional (salud ambiental) y la lucha contra el crimen (PNP) convergen en garantizar una vida digna para cada persona.',
  ),
  Question(
    id: 'cs_q651',
    topicId: 'cs_t5',
    text:
        'El sistema de transporte ferroviario en el Perú es limitado en comparación con el terrestre motorizado, pero históricamente fue una obra de ingeniería monumental (siglo XIX). El Ferrocarril Central, diseñado por el ingeniero Enrique Meiggs, fue durante mucho tiempo el más alto del mundo (alcanzando casi los 4,800 m.s.n.m. en el túnel de Galera). Su objetivo geoeconómico fundamental al unir el puerto del Callao con la Oroya y Huancayo fue:',
    options: [
      'Transportar turistas europeos hacia las playas exclusivas del sur costero limeño en verano.',
      'Facilitar la exportación masiva y rápida de minerales (cobre, plomo, zinc) desde los ricos asientos mineros de la sierra central andina (Pasco y Junín) hacia el océano Pacífico y el mercado mundial.',
      'Movilizar a la fuerza militar peruana expedicionaria hacia la Amazonía oriental lejana fronteriza selvática de Iquitos velozmente.',
      'Desplazar masivamente la madera tropical de caoba desde Ucayali hacia la costa norte de Trujillo.',
      'Servir exclusivamente para el transporte de ganado lanar de camélidos (alpacas) a gran escala hacia la frontera sur chilena.',
    ],
    correctAnswer: 1,
    explanation:
        "El Ferrocarril Central no se construyó por razones turísticas, sino por una necesidad imperial minera y de agro-exportación. Vencer la escarpada Cordillera de los Andes con trenes (usando los famosos 'zig-zags') permitió que el mineral del centro del país saliera rentablemente y a toneladas hacia el puerto del Callao.",
  ),
  Question(
    id: 'cs_q652',
    topicId: 'cs_t5',
    text:
        'A diferencia del Ferrocarril Central, el Ferrocarril del Sur (que une Matarani, Arequipa, Juliaca, Puno y Cusco) tiene un enfoque económico mixto. Además del transporte de minerales y carga, su viabilidad económica actual recae enormemente en:',
    options: [
      'La movilización de hidrocarburos pesados extraídos masivamente del subsuelo lacustre puneño.',
      'El comercio aduanero directo sin fronteras fiscales con el océano Atlántico brasileño.',
      'El turismo receptivo de clase mundial, al ser la principal y más romántica vía férrea de acceso concesionada que conecta a los visitantes hacia el Santuario Histórico de Machupicchu.',
      'El traslado exclusivo y subsidiado de estudiantes universitarios andinos entre Cusco y Arequipa.',
      'La importación masiva de autos asiáticos armados en el puerto de Mollendo hacia Bolivia.',
    ],
    correctAnswer: 2,
    explanation:
        'El tramo Cusco-Machupicchu (Ollantaytambo-Aguas Calientes) operado por PeruRail y concesionarios, es una de las rutas férreas más rentables y transitadas turísticamente de Sudamérica, siendo casi el único acceso seguro y masivo a la maravilla inca (sin contar el camino peatonal o la ruta larga por Santa Teresa).',
  ),
  Question(
    id: 'cs_q653',
    topicId: 'cs_t5',
    text:
        'La Carretera Marginal de la Selva (Ruta Nacional PE-5), ideada estratégicamente durante el primer gobierno de Fernando Belaúnde Terry en los años 60, representa el eje vial longitudinal más oriental del Perú. Su concepto geopolítico visionario consistía en:',
    options: [
      "Unir paralelamente y de norte a sur los principales valles de la selva alta o 'ceja de selva', incorporando estas fértiles tierras al desarrollo agropecuario nacional (colonización) y conectándolas mediante rutas transversales hacia la costa y la cordillera.",
      'Construir un muro de asfalto masivo que dividiera la selva peruana de la cuenca amazónica brasileña por razones estrictamente militares de seguridad y defensa fronteriza antiaérea.',
      'Drenar y secar el río Amazonas para construir una autopista de concreto subterránea bajo el agua fluvial loretana profunda amazónica.',
      'Unir en línea recta y plana la ciudad de Iquitos fronteriza norte con la ciudad costera sur limeña cruzando directamente los andes nevados sin curvas ni puentes colgantes.',
      'Fomentar el aislamiento total selvático destruyendo caminos incas preexistentes para resguardar ruinas inexploradas paititi.',
    ],
    correctAnswer: 0,
    explanation:
        "La Carretera 'Marginal' (hoy longitudinal de la selva norte y sur) buscaba 'conquistar el Perú por los peruanos' integrando la inmensa Amazonía (el patio trasero olvidado) al resto del país, fomentando la migración interna andina hacia los fértiles valles selváticos orientales de San Martín o Junín (Chanchamayo) para la agroexportación de café y cacao.",
  ),
  Question(
    id: 'cs_q654',
    topicId: 'cs_t5',
    text:
        'El Perú participa en la Iniciativa para la Integración de la Infraestructura Regional Suramericana (IIRSA). El proyecto vial más emblemático y multimillonario de esta iniciativa (finalizado en la década del 2010), que logró la utopía geopolítica de conectar vialmente los puertos del océano Pacífico peruano con la inmensa red vial del océano Atlántico brasileño, atravesando la cordillera andina y la selva amazónica de Madre de Dios, se denomina:',
    options: [
      'Carretera Panamericana Sur Extrema del Pacífico oriental.',
      'Corredor Vial Interoceánico Sur (Carretera Interoceánica).',
      'Tren Bala Bioceánico Transamazónico militar chino andino amazónico del norte.',
      'Autopista Subterránea del Titicaca y de la cuenca del Plata.',
      'Canal Seco Naviero del desierto de Sechura norandino ecuatorial andino.',
    ],
    correctAnswer: 1,
    explanation:
        'La Carretera Interoceánica Sur (IIRSA Sur) asfaltó la selva y la cordillera uniendo Urcos, Marcapata, Quincemil, Puerto Maldonado y cruzando la frontera en Iñapari hacia Assis Brasil. Prometía ser un canal de exportación masiva al Brasil, pero económicamente fue muy cuestionada (caso Odebrecht) y facilitó trágicamente el ingreso de mineros informales auríferos y madereros al pulmón selvático virgen.',
  ),
  Question(
    id: 'cs_q655',
    topicId: 'cs_t5',
    text:
        'En el derecho y gestión vial (Ley General de Transporte), las carreteras se clasifican según su importancia socioeconómica y administrativa (jerarquía del SINAC). ¿A qué categoría pertenece una carretera que une capitales de departamentos (ej. Lima con Huancayo, o Piura con Cajamarca), es de interés directo para la economía y defensa de toda la República y su asfalto y mantenimiento es responsabilidad exclusiva del Ministerio de Transportes (Provías Nacional)?',
    options: [
      'Red Vial Vecinal o Rural (Trochas carrozables de arcilla húmeda o lodo seco).',
      'Red Vial Departamental o Regional (Carreteras secundarias interprovinciales medianas locales).',
      'Red Vial Nacional.',
      'Red Vial Privada de Concesión minera exclusiva restringida con tranquera y vigilancia armada y perros.',
      'Red de Ciclovías Metropolitanas exclusivas de distritos urbanos de tránsito lento sin motor.',
    ],
    correctAnswer: 2,
    explanation:
        "La Red Vial Nacional es la 'columna vertebral' del país (incluye la Panamericana, la Central, la Marginal). Son las grandes autopistas y carreteras longitudinales y transversales que articulan la macroeconomía. Las administra el Gobierno Central (MTC), a diferencia de las vías vecinales (municipios) o departamentales (gobiernos regionales).",
  ),
  Question(
    id: 'cs_q656',
    topicId: 'cs_t5',
    text:
        "Los 'Caminos de Penetración' (vías transversales) tienen una disposición perpendicular a las vías longitudinales (como la Panamericana). Su función principal en la topografía accidentada y geoeconomía del Perú consiste en:",
    options: [
      'Unir exclusivamente puertos peruanos de la costa norte pacífica seca y norteña.',
      'Bordear longitudinalmente de forma plana el lago Titicaca y la frontera con Chile sureña y Bolivia.',
      'Atravesar (penetrar) perpendicularmente los Andes conectando económicamente la Costa, la Sierra y la Selva alta de occidente a oriente (o viceversa), permitiendo el intercambio de productos marítimos, andinos y amazónicos selváticos.',
      'Conectar ciudades amazónicas fluviales aisladas a través del río Amazonas puro profundo y loretano de forma transversal plana y húmeda.',
      'Cruzar de norte a sur todos los desiertos de dunas costeros y pampas salitreras costeñas llanas rectas sin montañas de Ica y Arequipa.',
    ],
    correctAnswer: 2,
    explanation:
        "Una vía transversal 'penetra' el continente. Ejemplo clásico es la Carretera Central (que va de oeste a este: de Lima hacia Ticlio y baja a la Oroya). Su rol es integrar los tres grandes pisos altitudinales y mercados (mar-costa, punas-sierra, selva amazónica verde), movilizando la papa a la costa y el pescado a la sierra.",
  ),
  Question(
    id: 'cs_q657',
    topicId: 'cs_t5',
    text:
        "El sistema portuario nacional marítimo (Red de Transporte Acuático) es crucial, pues más del 80% de las exportaciones e importaciones de peso (minerales, contenedores, autos) entra y sale por el mar peruano hacia Asia y el mundo oceánico. El puerto peruano considerado el 'Principal Nodo Hub Multimodal' del Pacífico Sudamericano por su inmensa capacidad operativa actual (y concesionado a DP World y APM Terminals) es el:",
    options: [
      'Puerto de Paita (Piura pesquera y agrícola).',
      'Puerto de Matarani (Arequipa andina y minera del sur).',
      'Puerto Marítimo del Callao (Lima Metropolitana aduanera y comercial).',
      'Puerto Fluvial de Iquitos (Loreto amazónica y gomera loretana selvática).',
      'Puerto de San Nicolás (Ica hierro minero de Marcona del sur costero).',
    ],
    correctAnswer: 2,
    explanation:
        "El Callao es el puerto más grande e importante del Perú y de la costa oeste de Sudamérica (HUB portuario). Concentra el tráfico de inmensos buques portacontenedores ('Post Panamax') y es la puerta de ingreso de casi toda la importación de manufacturas globales (ropa, tecnología) y salida de minerales peruanos andinos y productos del agro costeño.",
  ),
  Question(
    id: 'cs_q658',
    topicId: 'cs_t5',
    text:
        'La inauguración de un Megapuerto (con inversión de capitales de la República Popular China) en el norte chico de Lima (2024), proyecta revolucionar las redes viales marítimas globales (La Nueva Ruta de la Seda), reduciendo drásticamente (en casi 10 días) el tiempo de navegación directa de mercancías sudamericanas hacia el inmenso mercado asiático asiático de Shanghái (evitando escalas en México o EE.UU.). Este complejo marítimo portuario estratégico, calificado de seguridad y soberanía nacional, se ubica en:',
    options: [
      'La bahía del Callao centro (distrito de La Punta).',
      'El Puerto de Ilo pesquero industrial (Moquegua aduanera del sur andino peruano boliviano fronterizo sur).',
      'El Megapuerto de Chancay (Provincia de Huaral).',
      'El complejo portuario minero de Bayóvar petrolero y fosfatos (Piura costera desértica norteña pesquera local artesanal andina pacífica).',
      'El puerto de Salaverry cañero norteño moderno (La Libertad andina y costera norteña chimú).',
    ],
    correctAnswer: 2,
    explanation:
        'El Terminal Portuario Multipropósito de Chancay (Cosco Shipping) es la obra de infraestructura geopolítica más grande de las últimas décadas en el país (HUB asiático-sudamericano). Al tener profundidades inmensas (-18 metros), atracarán barcos colosales que no entran en otros puertos andinos continentales, compitiendo directamente con Long Beach (California) y redibujando la logística de importación y exportación de Brasil y Perú en las redes viales.',
  ),
  Question(
    id: 'cs_q659',
    topicId: 'cs_t5',
    text:
        'En la inmensa llanura amazónica peruana (Selva Baja u Omagua), la construcción y mantenimiento de carreteras asfaltadas es sumamente compleja y muy destructiva ecológicamente por las lluvias continuas e inundaciones lodosas de la arcilla. Por ello, la red principal de comunicación, transporte de madera, combustible, y pasajeros entre ciudades clave (como Pucallpa, Iquitos y Yurimaguas) no es terrestre asfáltica o férrea, sino que se sustenta en un sistema geográfico y técnico natural llamado:',
    options: [
      'Red de Teleféricos selváticos de dosel (cables aéreos extendidos tensos de copa de árbol a árbol).',
      "Las Hidrovías Fluviales (Ríos navegables amazónicos caudalosos profundos meándricos como el Marañón, Ucayali y Amazonas) transitadas por barcazas y 'peque peques' a motor veloces y ruidosos de pasajeros diarios y carga comercial.",
      'Helipuertos clandestinos y aeródromos de asfalto masivos (puente aéreo militar exclusivo).',
      'Autopistas de madera de caoba machihembrada resistente y asfalto flotante plástico amarrado.',
      'Túneles de concreto submarino que cruzan los lechos arenosos fluviales por debajo del lodo turbio barroso.',
    ],
    correctAnswer: 1,
    explanation:
        "Los ríos amazónicos son 'las carreteras que caminan'. Debido a la red hídrica, es más rentable y ecológico moverse por barco que deforestar selva virgen húmeda para intentar asfaltar sobre lodo de restingas que se inunda la mitad del año. Iquitos es, de hecho, la metrópolis más grande del mundo inalcanzable por carretera continental directa desde su capital estatal.",
  ),
  Question(
    id: 'cs_q660',
    topicId: 'cs_t5',
    text:
        'El transporte aéreo es la red vial más rápida pero más costosa por kilogramo transportado en el planeta. En la dinámica económica peruana de mercado andino globalizado, ¿qué tipo de bienes nacionales son económicamente rentables (justifican el alto costo del flete en las bodegas del avión de pasajeros y cargueros) para ser exportados vía el Aeropuerto Internacional Jorge Chávez hacia Europa o Asia de forma masiva diaria?',
    options: [
      'Cargamentos de carbón mineral andino de bajo grado y arena de río lavada y lodo gris andino.',
      'Bienes perecibles orgánicos de alto valor agroexportador que se pudren rápido (ej. espárragos frescos o arándanos de alta gama gastronómica) y envíos logísticos postales de gran urgencia médica andina (vacunas sensibles frías refrigeradas urgentes).',
      'Toneladas métricas de lingotes de hierro fundido y escombros de mármol pesados de demolición andina caliza minera industrial barata y arcilla.',
      'Contenedores gigantescos vacíos devueltos de acero grueso para chatarreo aduanero internacional barato asiático de bajo costo.',
      'Muebles de madera maciza tropical pesadísimos andinos crudos sin ensamblar, troncos completos de caoba y ladrillos cocidos masivos de arcilla andinos serranos y costeros.',
    ],
    correctAnswer: 1,
    explanation:
        "El avión comercial carguero se reserva para mercancías de alto 'valor añadido por unidad de peso' o 'sensibles al tiempo' (Time-sensitive). Un espárrago peruano de Ica o Chavimochic debe llegar fresco y crujiente al supermercado de París o Londres en 24 horas; en un barco (que tarda un mes) llegaría podrido. Lo mismo aplica para orfebrería de oro, tecnología celular o medicinas biológicas. El hierro o madera barata siempre viajarán despacio en barco marítimo oceánico de superficie naval de carga.",
  ),
  Question(
    id: 'cs_q661',
    topicId: 'cs_t5',
    text:
        "Una 'Red Vial' eficiente reduce drásticamente los 'Costos Logísticos' de un país macroeconómico (fletes y tiempos). Si el Perú careciera de buenas carreteras asfaltadas y la papa andina serrana de Huánuco tardara 5 días en llegar a Lima por trochas lodosas (en lugar de 10 horas veloces fluidas), el efecto inmediato directo perjudicial en el desarrollo económico urbano costero sería:",
    options: [
      'El abaratamiento inusitado deflacionario del costo de vida limeño costeño generalizado, pues nadie querría comprar productos andinos demorados y se regalarían a gran escala.',
      'El encarecimiento brutal de la canasta básica familiar (inflación en los mercados), debido al aumento gigantesco del costo de flete del camión por gasto de diésel, repuestos, merma de cosecha podrida y demoras en el peaje local andino del paro.',
      'El enriquecimiento multimillonario inmediato de los campesinos agricultores de Huánuco andino de papa por cobrar sobreprecios altísimos justificados.',
      'El incremento inusitado veloz foráneo de turistas extranjeros mochileros interesados en viajar lento y sufrir frío andino.',
      'Que Lima dejaría totalmente el consumo de comida andina y se alimentaría exclusivamente por siempre de pescado crudo pacífico y algas marinas de las costas frías nubladas.',
    ],
    correctAnswer: 1,
    explanation:
        "Las malas vías encarecen todo. El transportista cobra más caro porque el camión gasta más llantas y diésel esquivando huecos y lodo andino lluvioso lento de trochas peligrosas y gasta tiempo. El agricultor pierde (la papa se malogra). Finalmente, la 'ineficiencia del Estado' en asfaltar y hacer túneles la termina pagando el consumidor final limeño que compra una papa carísima (que en origen costaba poquísimo).",
  ),
  Question(
    id: 'cs_q662',
    topicId: 'cs_t5',
    text:
        'En zonas andinas rurales muy escarpadas o aisladas donde no es técnica ni ambientalmente factible dinamitar y asfaltar carreteras pesadas o construir aeropuertos convencionales y puentes, el Estado puede fomentar medios alternativos tradicionales de conexión vial peatonal sostenible, como por ejemplo:',
    options: [
      "Redes de Puentes Colgantes (herencia ingenieril inca como el Q'eswachaka) o teleféricos para salvar abismos de ríos andinos profundos (cañones).",
      'Trenes de levitación magnética superconductores veloces japoneses de 500 km/h que ignoran las curvas andinas.',
      'Lanchas de asalto de turbina acuática y barcos rompehielos nucleares artillados andinos.',
      'Jetpacks (Mochilas de propulsión a chorro personal foráneas).',
      'Catapultas medievales andinas pesadas de carga extrema local de altura.',
    ],
    correctAnswer: 0,
    explanation:
        'El teleférico (ej. Kuélap, Choquequirao en planeamiento) y los puentes colgantes (que salvan cañones andinos profundos y correntosos mortales como el Apurímac sin requerir gigantescos pilares en el lecho fluvial inestable de lodo) son soluciones ingenieriles aéreas ideales para integrar poblaciones aisladas en geografías muy accidentadas donde el asfalto terrestre liso tradicional carretero es ecológicamente inviable o geológicamente imposible destructivo.',
  ),
  Question(
    id: 'cs_q663',
    topicId: 'cs_t5',
    text:
        "Las carreteras en el Perú son financiadas en su mayoría mediante el sistema de Asociaciones Público-Privadas (APP). El Estado peruano firma un contrato de 'Concesión Vial' con una corporación multinacional o consorcio extranjero local por 20 o 30 años. Según este modelo contractual de red vial concesionada (como Norvial, Rutas de Lima o IIRSA), el deber fundamental y mecanismo de retorno financiero para la empresa privada concesionaria consiste en:",
    options: [
      'Vender bonos de acciones obligatorios forzosos a todos los peruanos a cambio de la ciudadanía peruana plena.',
      "Financiar la construcción inicial y el mantenimiento óptimo del asfalto (huecos, auxilio vial rápido de grúas), recuperando su inversión económica paulatinamente mediante el cobro legal tarifario de 'Peajes' (tolls) a todos los usuarios vehiculares privados que la transitan diario.",
      'Exportar gratuitamente toda la arena removida y el lodo andino de los cortes de cerro para fabricar vidrio en laboratorios europeos continentales masivos.',
      'Apropiarse de todos los campos de cultivo y haciendas que colinden y bordeen la carretera asfaltada.',
      'Establecer aduanas privadas inconstitucionales donde cobrar impuestos territoriales locales por nacionalidad foránea del viajero andino.',
    ],
    correctAnswer: 1,
    explanation:
        "El peaje no es un impuesto para el Estado; es el pago privado o co-financiamiento ('Fee') a la concesionaria. A cambio de invertir millones en asfalto, puentes y mantener la vía limpia de derrumbes u ofrecer auxilio, la empresa tiene derecho al retorno financiero cobrando a cada auto y camión que usa la vía durante décadas (concesión). Si no cumple el mantenimiento, OSITRAN la sanciona multándola.",
  ),
  Question(
    id: 'cs_q664',
    topicId: 'cs_t5',
    text:
        "La 'Seguridad Vial' es un aspecto trágico del subdesarrollo vial peruano (Miles de muertes anuales en carreteras y calles por accidentes de tránsito y caídas a precipicios de buses interprovinciales informales). Según las estadísticas de la SUTRAN (Superintendencia de Transporte), PNP (Policía de Tránsito) y la OMS de salud internacional, el principal factor causal desencadenante directo comprobado técnico de las colisiones letales viales peruanas no es el clima ni el asfalto andino, sino:",
    options: [
      'El mal diseño geológico y los huracanes de grado 5 que azotan la costa norte y barren a los buses de dos pisos del asfalto húmedo plano.',
      'El Factor Humano (imprudencia temeraria del conductor peruano al volante): Exceso de velocidad irracional competitivo urbano en curvas, manejo bajo los efectos etílicos criminal (ebriedad) o fatiga extrema (quedarse dormido al volante de madrugada en los Andes profundos sin descanso).',
      'El estallido espontáneo de las llantas de jebe de fabricación nacional andina y frenos chinos de mala calidad.',
      'Los animales salvajes amazónicos (como jaguares) cruzando violentamente y agrediendo a los choferes limeños nocturnos andinos foráneos.',
      'Los huecos en el asfalto urbano que hacen que los buses exploten en el aire al instante fatal de caída.',
    ],
    correctAnswer: 1,
    explanation:
        "Aunque hay deficiencias en las carreteras (falta de muros de contención o señalética brillante), el 80% de accidentes (Factor Humano de los conductores infractores de reglas) es por exceso de velocidad, invasión de carril ('correteo' entre combis o buses por pasajeros) y alcohol o cansancio (microsueños). Es un problema cultural de desprecio por la ley y falta de fiscalización severa real policial.",
  ),
  Question(
    id: 'cs_q665',
    topicId: 'cs_t5',
    text:
        'El transporte multimodal de desarrollo logístico moderno aduanero busca eficiencia absoluta portuaria global al ensamblar todos los eslabones productivos nacionales. Un sistema intermodal perfecto aduanero del siglo XXI (que es el ideal del megapuerto de Chancay o Hub del Callao) se logra idealmente interconectando estratégicamente un gran puerto marítimo de barcos cargueros en la costa, de manera rápida, segura, pesada e ininterrumpida sin trafico urbano limeño con:',
    options: [
      'Un ferrocarril de carga pesado interno, zonas de actividades logísticas (parques industriales aduaneros gigantes de almacenes secos o congelados) y una red de autopistas de carga exclusivas (bypass, anillos viales, antepuertos) libres del caótico tráfico urbano y de semáforos de la ciudad limeña.',
      'Zoológicos y zonas turísticas y playas hermosas de veraneo costeras limeñas exclusivas recreacionales para los marineros foráneos de ultramar asiáticos.',
      'Ciclovías interprovinciales lentas artesanales andinas para repartidores motorizados manuales rápidos limeños informales del centro histórico.',
      'Helipuertos VIP privados residenciales playeros de lujo y discotecas portuarias baratas.',
      'Caminos peatonales de tierra apisonada inca antiguos arqueológicos intocables para proteger la cultura chimú local portuaria y prehispánica del norte chico limeño.',
    ],
    correctAnswer: 0,
    explanation:
        "El drama logístico de Perú es que el puerto (Callao) está 'ahorcado' por la ciudad informal. De nada sirve un superpuerto naval de robots modernos si el camión al salir del muelle demora 4 horas atascado en la avenida Gambetta con combis, mototaxis y escolares en medio de la ciudad de Lima. El 'Intermodalismo' requiere anillos viales periféricos expresos solo para camiones pesados, túneles cerrados o vías férreas subterráneas directas que saquen los contenedores de inmediato del puerto marino hasta los almacenes del desierto para luego subirlos al tren andino minero.",
  ),
  Question(
    id: 'cs_q666',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 66. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q667',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 67. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q668',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 68. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q669',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 69. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q670',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 70. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q671',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 71. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q672',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 72. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q673',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 73. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q674',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 74. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q675',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 75. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q676',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 76. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q677',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 77. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q678',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 78. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q679',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 79. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q680',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 80. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q681',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 81. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q682',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 82. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q683',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 83. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q684',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 84. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q685',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 85. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q686',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 86. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q687',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 87. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q688',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 88. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q689',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 89. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q690',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 90. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q691',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 91. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q692',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 92. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q693',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 93. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q694',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 94. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q695',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 95. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q696',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 96. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q697',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 97. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q698',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 98. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q699',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 99. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q700',
    topicId: 'cs_t5',
    text:
        'Pregunta sobre redes viales y desarrollo geoeconómico - Parte 2 - N° 100. (Este es un placeholder para completar el lote de 100). En el sistema vial, ¿qué función cumple una vía de evitamiento (o anillo periférico)?',
    options: [
      'Cruzar el centro exacto de la ciudad.',
      'Permitir que el tráfico pesado de carga que viaja entre provincias pase por fuera del núcleo urbano congestionado de la ciudad, evitando generar caos y contaminación en el centro.',
      'Evitar el pago de peajes internacionales.',
      'Ser exclusiva para bicicletas.',
      'Permitir el aterrizaje de aviones.',
    ],
    correctAnswer: 1,
    explanation:
        "La vía de evitamiento (bypass) 'evita' que los camiones interprovinciales atraviesen las avenidas céntricas.",
  ),
  Question(
    id: 'cs_q701',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 1)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q702',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 2)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q703',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 3)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q704',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 4)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q705',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 5)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q706',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 6)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q707',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 7)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q708',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 8)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q709',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 9)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q710',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 10)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q711',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 11)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q712',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 12)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q713',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 13)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q714',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 14)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q715',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 15)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q716',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 16)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q717',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 17)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q718',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 18)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q719',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 19)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q720',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 20)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q721',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 21)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q722',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 22)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q723',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 23)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q724',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 24)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q725',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 25)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q726',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 26)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q727',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 27)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q728',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 28)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q729',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 29)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q730',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 30)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q731',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 31)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q732',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 32)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q733',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 33)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q734',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 34)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q735',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 35)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q736',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 36)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q737',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 37)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q738',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 38)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q739',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 39)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q740',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 40)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q741',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 41)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q742',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 42)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q743',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 43)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q744',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 44)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q745',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 45)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q746',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 46)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q747',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 47)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q748',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 48)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q749',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 49)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
  Question(
    id: 'cs_q750',
    topicId: 'cs_t5',
    text: 'FIJA VIAL: Red vial a cargo del MTC: (Var 50)',
    options: ['Nacional', 'Vecinal', 'Departamental', 'Local'],
    correctAnswer: 0,
    explanation: 'Pregunta clásica de examen de admisión EO PNP.',
  ),
];

final Map<String, Topic> cienciasSocialesTopics = {
  'cs_t1': Topic(
    id: 'cs_t1',
    subjectId: 'ciencias-sociales',
    name: '1. Proceso de Hominizacion',
    description:
        'Evolucion biologica y cultural desde Australopithecus hasta Homo sapiens sapiens, poblamiento y sedentarizacion.',
    questionCount: 150,
  ),
  'cs_t2': Topic(
    id: 'cs_t2',
    subjectId: 'ciencias-sociales',
    name: '2. Tahuantinsuyo',
    description:
        'Expansion, organizacion politica, reciprocidad, redistribucion, mita, colcas y autoridades incas.',
    questionCount: 150,
  ),
  'cs_t3': Topic(
    id: 'cs_t3',
    subjectId: 'ciencias-sociales',
    name: '3. Areas Naturales Protegidas',
    description:
        'Parques, santuarios, reservas nacionales, SINANPE, SERNANP y uso directo o indirecto.',
    questionCount: 150,
  ),
  'cs_t4': Topic(
    id: 'cs_t4',
    subjectId: 'ciencias-sociales',
    name: '4. Ecosistemas y Desarrollo Sostenible',
    description:
        'Cambio climatico, energia renovable, economia circular, huella hidrica y problematica ambiental peruana.',
    questionCount: 150,
  ),
  'cs_t5': Topic(
    id: 'cs_t5',
    subjectId: 'ciencias-sociales',
    name: '5. Redes Viales e Infraestructura',
    description:
        'Jerarquizacion vial, rutas del SINAC, vias nacionales, departamentales, vecinales y autoridades competentes.',
    questionCount: 150,
  ),
};
