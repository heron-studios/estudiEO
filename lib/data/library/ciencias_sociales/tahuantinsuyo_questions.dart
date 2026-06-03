import 'package:learn/models/question.dart';

final List<Question> tahuantinsuyoQuestions = [
  // ====== NIVEL FÁCIL ======
  Question(
    id: 'pfrh_tahua_easy_1',
    topicId: 'cs_t2',
    text: r'''¿Cuál es el significado etimológico de la palabra quechua "Tahuantinsuyo" y cuál era su ciudad de origen y capital?''',
    options: [
      r'''El imperio del dios Sol y su capital Quito.''',
      r'''Las cuatro regiones que se integran y su capital el Cusco.''',
      r'''La confederación de los Andes y su capital Chan Chan.''',
      r'''El gran territorio de los mitimaes y su capital Vilcabamba.''',
    ],
    correctAnswer: 1,
    explanation: r'''El nombre Tahuantinsuyo proviene de las palabras "tahua" (cuatro) y "suyo" (región), significando "las cuatro regiones que se integran", teniendo como capital sagrada y administrativa al Cusco.''',
  ),

  Question(
    id: 'pfrh_tahua_easy_2',
    topicId: 'cs_t2',
    text: r'''De la división geopolítica del Imperio Inca en cuatro grandes regiones, ¿qué suyo se ubicaba hacia el Noroeste del Cusco, abarcando la costa norte, la sierra central y llegando hasta el río Ancasmayo en Colombia?''',
    options: [
      r'''Collasuyo''',
      r'''Antisuyo''',
      r'''Contisuyo''',
      r'''Chinchaysuyo''',
    ],
    correctAnswer: 3,
    explanation: r'''El Chinchaysuyo era la región ubicada al noroeste de la capital imperial, abarcando la vasta costa norte y sierra central del Perú, expandiéndose hasta Ecuador y Colombia.''',
  ),

  // ====== NIVEL MEDIO ======
  Question(
    id: 'pfrh_tahua_medium_1',
    topicId: 'cs_t2',
    text: r'''La dinámica económica del Imperio Incaico, que carecía de moneda y mercado, se sostenía estructuralmente en dos principios básicos de gestión de bienes y servicios. ¿Cuáles eran?''',
    options: [
      r'''Libre comercio y Acumulación privada.''',
      r'''Trueque internacional y Centralismo.''',
      r'''Reciprocidad y Redistribución.''',
      r'''Monopolio estatal y Tributo metálico.''',
    ],
    correctAnswer: 2,
    explanation: r'''La economía inca operó basada en la reciprocidad (ayuda simétrica entre familias del ayllu) y la redistribución (acopio de excedentes por el Estado para su posterior reparto en épocas de escasez o para la administración).''',
  ),

  Question(
    id: 'pfrh_tahua_medium_2',
    topicId: 'cs_t2',
    text: r'''El trabajo en el Tahuantinsuyo fue la principal actividad económica. ¿Qué nombre recibía el trabajo obligatorio que los hombres adultos realizaban por turnos a favor del Estado imperial en la construcción de caminos, puentes y fortalezas?''',
    options: [
      r'''Ayni''',
      r'''Mita''',
      r'''Minca''',
      r'''Chunca''',
    ],
    correctAnswer: 1,
    explanation: r"""La Mita (mit'a) era un sistema de trabajo obligatorio, temporal y rotativo movilizado por el Estado incaico para la ejecución de grandes obras públicas y servicios imperiales.""",
  ),

  // ====== NIVEL DIFÍCIL ======
  Question(
    id: 'pfrh_tahua_hard_1',
    topicId: 'cs_t2',
    text: r'''La historia incaica marca su tránsito de una confederación local a un vasto y hegemónico Imperio en el año 1438. ¿Qué suceso militar y político marcó el inicio de este Periodo de Gran Expansión?''',
    options: [
      r'''La muerte del Inca Huayna Cápac por viruela.''',
      r'''La victoria definitiva del Inca Pachacútec sobre los ejércitos de la cultura Chanca.''',
      r'''La fundación del templo del Coricancha por Manco Cápac.''',
      r'''La asimilación pacífica del reino Chimú al norte del Perú.''',
    ],
    correctAnswer: 1,
    explanation: r'''El Periodo Imperial expansivo y la reorganización total del Estado iniciaron en 1438, cuando Pachacútec logró la victoria decisiva sobre sus grandes enemigos, los Chancas.''',
  ),

  Question(
    id: 'pfrh_tahua_hard_2',
    topicId: 'cs_t2',
    text: r'''Dentro de la jerarquía y administración social del Imperio Inca, existía un grupo de pobladores separados de su etnia de origen y enviados por el Estado hacia zonas recién conquistadas. ¿Quiénes eran y qué función cumplían?''',
    options: [
      r'''Eran los Piñas, destinados a la extracción minera y esclavitud de por vida.''',
      r'''Eran los Mitimaes, enviados con sus familias para colonizar, asegurar el dominio político y asimilar culturalmente a los pueblos sometidos.''',
      r'''Eran los Hatun Runa, cuya única tarea era ser la guardia de élite del Sapa Inca.''',
      r'''Eran los Yanaconas, dedicados exclusivamente al registro de los quipus contables.''',
    ],
    correctAnswer: 1,
    explanation: r'''Los Mitimaes o mitmakuna eran poblaciones estratégicamente trasplantadas por el imperio para labores productivas, colonización y la enseñanza de las costumbres estatales en territorios hostiles o recientemente anexados.''',
  ),

  // ====== NIVEL EXTREMO ======
  Question(
    id: 'pfrh_tahua_extreme_1',
    topicId: 'cs_t2',
    text: r'''La compleja maquinaria administrativa y tributaria inca controló a millones de súbditos implementando un estricto modelo demográfico de base decimal. ¿Qué título ostentaba el funcionario responsable de dirigir la política agraria y supervisar a un conjunto de 10,000 familias?''',
    options: [
      r'''Huno camayoc''',
      r'''Huaranga camayoc''',
      r'''Pachaca camayoc''',
      r'''Chunca camayoc''',
    ],
    correctAnswer: 0,
    explanation: r'''En la rígida jerarquía decimal del Tahuantinsuyo, el Huno camayoc era la autoridad responsable de gobernar, censar y organizar un conjunto poblacional equivalente a 10,000 familias (un Huno), reportando a los gobernadores regionales.''',
  ),

  Question(
    id: 'pfrh_tahua_extreme_2',
    topicId: 'cs_t2',
    text: r'''El Sapa Inca gobernaba respaldado por una compleja élite dinástica. En este contexto, ¿qué eran exactamente las "Panacas" reales y cuál era su función primordial en la sociedad cusqueña?''',
    options: [
      r'''Eran escuelas estatales dedicadas a la formación física (Huarachicuy) de la élite militar para las campañas en el Chinchaysuyo.''',
      r'''Eran linajes conformados por la descendencia directa de un soberano fallecido (excluyendo a su heredero al trono), encargados de preservar su memoria, riquezas y cuidar su momia (mallqui).''',
      r'''Constituían la guardia personal selecta conformada por guerreros Cañaris y Chachapoyas al servicio directo del Sapa Inca.''',
      r'''Eran los grupos de expertos contables encargados de la lectura matemática e interpretación de los quipus.''',
    ],
    correctAnswer: 1,
    explanation: r'''Las Panacas eran los extensos y poderosos linajes reales integrados por los descendientes de un Inca, exceptuando siempre a su sucesor. Tenían como rol sagrado el perpetuar la memoria, las hazañas y el cuidado del cuerpo momificado del gobernante para las futuras generaciones.''',
  ),
];
