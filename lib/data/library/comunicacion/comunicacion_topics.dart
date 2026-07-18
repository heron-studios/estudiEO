import 'package:learn/models/topic.dart';

import 'reglas_ortograficas_ext_10q_theory.dart';
import 'oracion_gramatical_ext_10q_theory.dart';
import 'narracion_ext_10q_theory.dart';
import 'literatura_peruana_ext_10q_theory.dart';
import 'literatura_peruana_rebuscada_ext_10q_theory.dart';

final Map<String, Topic> comunicacionTopics = {
  // Topics con teoría (modo aprendizaje guiado)
  'eo_pnp_reglas_ortograficas_ext_10q': Topic(
    id: 'eo_pnp_reglas_ortograficas_ext_10q',
    subjectId: 'comunicacion',
    name: 'Reglas Ortográficas y Normativas RAE (Teoría Completa 10Q)',
    description:
        'Grafías, acentuación, mayúsculas, signos de puntuación y concurrencia vocálica.',
    questionCount: 40,
    theoryByLevel: {
      'easy': reglasOrtograficasExt10qTheoryEasy,
      'medium': reglasOrtograficasExt10qTheoryMedium,
      'hard': reglasOrtograficasExt10qTheoryHard,
      'extreme': reglasOrtograficasExt10qTheoryExtreme,
    },
  ),
  'eo_pnp_narracion_ext_10q': Topic(
    id: 'eo_pnp_narracion_ext_10q',
    subjectId: 'comunicacion',
    name: 'La Narración: Estructura y Elementos (Teoría Completa 10Q)',
    description:
        'Aprende los elementos fundamentales de la narración, tipos de narradores, personajes y alteraciones temporales.',
    questionCount: 40,
    theoryByLevel: {
      'easy': narracionExt10qTheoryEasy,
      'medium': narracionExt10qTheoryMedium,
      'hard': narracionExt10qTheoryHard,
      'extreme': narracionExt10qTheoryExtreme,
    },
  ),
  'eo_pnp_oracion_gramatical_ext_10q': Topic(
    id: 'eo_pnp_oracion_gramatical_ext_10q',
    subjectId: 'comunicacion',
    name: 'La Oración Gramatical (Teoría Completa 10Q)',
    description:
        'Estudio de la oración gramatical, unimembres, bimembres y estructura del sintagma nominal y verbal.',
    questionCount: 40,
    theoryByLevel: {
      'easy': oracionGramaticalExt10qTheoryEasy,
      'medium': oracionGramaticalExt10qTheoryMedium,
      'hard': oracionGramaticalExt10qTheoryHard,
      'extreme': oracionGramaticalExt10qTheoryExtreme,
    },
  ),
  'eo_pnp_literatura_peruana_ext_10q': Topic(
    id: 'eo_pnp_literatura_peruana_ext_10q',
    subjectId: 'comunicacion',
    name: 'Literatura Peruana (Teoría Completa 10Q)',
    description:
        'Estudio de la literatura peruana desde la época prehispánica hasta la Generación del 70.',
    questionCount: 40,
    theoryByLevel: {
      'easy': literaturaPeruanaExt10qTheoryEasy,
      'medium': literaturaPeruanaExt10qTheoryMedium,
      'hard': literaturaPeruanaExt10qTheoryHard,
      'extreme': literaturaPeruanaExt10qTheoryExtreme,
    },
  ),
  'eo_pnp_literatura_peruana_rebuscada_ext_10q': Topic(
    id: 'eo_pnp_literatura_peruana_rebuscada_ext_10q',
    subjectId: 'comunicacion',
    name: 'Literatura Peruana Rebuscada (Teoría Completa 10Q)',
    description:
        'Estudio detallado de la literatura peruana, crónicas, movimientos rupturistas y narrativa.',
    questionCount: 40,
    theoryByLevel: {
      'easy': literaturaPeruanaRebuscadaExt10qTheoryEasy,
      'medium': literaturaPeruanaRebuscadaExt10qTheoryMedium,
      'hard': literaturaPeruanaRebuscadaExt10qTheoryHard,
      'extreme': literaturaPeruanaRebuscadaExt10qTheoryExtreme,
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
