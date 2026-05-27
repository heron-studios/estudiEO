import 'package:learn/models/topic.dart';
import 'reglas_ortograficas_theory.dart';
import 'oracion_gramatical_theory.dart';
import 'reglas_ortograficas_ext_10q_theory.dart';

final Map<String, Topic> comunicacionTopics = {
  // Topics con teoría (modo aprendizaje guiado)
  'eo_pnp_reglas_ortograficas_ext_10q': Topic(
    id: 'eo_pnp_reglas_ortograficas_ext_10q',
    subjectId: 'comunicacion',
    name: "Reglas Ortográficas y Normativas RAE (Teoría Completa 10Q)",
    description: "Grafías, acentuación, mayúsculas, signos de puntuación y concurrencia vocálica.",
    questionCount: 40,
    theoryByLevel: {
      'easy': reglasOrtograficasExt10qTheoryEasy,
      'medium': reglasOrtograficasExt10qTheoryMedium,
      'hard': reglasOrtograficasExt10qTheoryHard,
      'extreme': reglasOrtograficasExt10qTheoryExtreme,
    },
  ),
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
  'eo_pnp_oracion_gramatical_01': Topic(
    id: 'eo_pnp_oracion_gramatical_01',
    subjectId: 'comunicacion',
    name: "2. La Oración Gramatical",
    description: "Sujeto, predicado, modificadores del sujeto, y complementos del predicado.",
    questionCount: 8,
    theoryByLevel: {
      'easy': oracionGramaticalTheoryEasy,
      'medium': oracionGramaticalTheoryMedium,
      'hard': oracionGramaticalTheoryHard,
      'extreme': oracionGramaticalTheoryExtreme,
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
