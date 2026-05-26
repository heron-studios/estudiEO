import 'package:learn/models/topic.dart';
import 'reglas_ortograficas_theory.dart';

final Map<String, Topic> comunicacionTopics = {
  // Topics con teoría (modo aprendizaje guiado)
  'eo_pnp_reglas_ortograficas_01': Topic(
    id: 'eo_pnp_reglas_ortograficas_01',
    subjectId: 'comunicacion',
    name: "1. Reglas Ortográficas y Normativa RAE",
    description: "Grafías, acentuación, mayúsculas, signos de puntuación y concurrencia vocálica.",
    questionCount: 8,
    theoryByLevel: {
      'easy': reglasOrtograficasTheoryEasy,
      'medium': reglasOrtograficasTheoryMedium,
      'hard': reglasOrtograficasTheoryHard,
      'extreme': reglasOrtograficasTheoryExtreme,
    },
  ),

  // Topics sin teoría (solo quiz) - comentados hasta agregar contenido teórico
  // 'com_t2': Topic(
  //   id: 'com_t2',
  //   subjectId: 'comunicacion',
  //   name: "2. La Oracion Gramatical",
  //   description: "Sujeto, predicado, complementos, categorias gramaticales y oraciones simples o compuestas.",
  //   questionCount: 165,
  // ),
  // 'com_t3': Topic(
  //   id: 'com_t3',
  //   subjectId: 'comunicacion',
  //   name: "3. La Narracion",
  //   description: "Estructura narrativa, narrador, personajes, tiempo, espacio y especies narrativas.",
  //   questionCount: 164,
  // ),
  // 'com_t4': Topic(
  //   id: 'com_t4',
  //   subjectId: 'comunicacion',
  //   name: "4. Literatura Peruana",
  //   description: "Autores, obras, etapas literarias, figuras y movimientos de la literatura peruana.",
  //   questionCount: 189,
  // ),
};
