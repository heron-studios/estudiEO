import 'package:learn/models/topic.dart';
import 'sinonimos_ext_10q_theory.dart';
import 'antonimos_ext_10q_theory.dart';

final Map<String, Topic> razonamientoVerbalTopics = {
  'eo_pnp_sinonimos_ext_10q': Topic(
    id: 'eo_pnp_sinonimos_ext_10q',
    subjectId: 'rv',
    name: "Sinónimos (Teoría Completa 10Q)",
    description: "Sinónimos directos, contextuales y precisión léxica.",
    questionCount: 40,
    theoryByLevel: {
      'easy': sinonimosExt10qTheoryEasy,
      'medium': sinonimosExt10qTheoryMedium,
      'hard': sinonimosExt10qTheoryHard,
      'extreme': sinonimosExt10qTheoryExtreme,
    },
  ),
  'eo_pnp_antonimos_ext_10q': Topic(
    id: 'eo_pnp_antonimos_ext_10q',
    subjectId: 'rv',
    name: "Antónimos (Teoría Completa 10Q)",
    description: "Antónimos gramaticales, lexicales y antonimia contextual.",
    questionCount: 40,
    theoryByLevel: {
      'easy': antonimosExt10qTheoryEasy,
      'medium': antonimosExt10qTheoryMedium,
      'hard': antonimosExt10qTheoryHard,
      'extreme': antonimosExt10qTheoryExtreme,
    },
  ),
  // Topics sin teoría (solo quiz) - comentados hasta agregar contenido teórico
  // 'rv_sinonimos': Topic(
  //   id: 'rv_sinonimos',
  //   subjectId: 'rv',
  //   name: "1. Sinónimos",
  //   description: "Sinonimos directos, contextuales y por transgresion morfologica.",
  //   questionCount: 150,
  // ),
  // 'rv_antonimos': Topic(
  //   id: 'rv_antonimos',
  //   subjectId: 'rv',
  //   name: "2. Antónimos",
  //   description: "Antonimos absolutos y relativos.",
  //   questionCount: 100,
  // ),
  // 'rv_conectores': Topic(
  //   id: 'rv_conectores',
  //   subjectId: 'rv',
  //   name: "3. Conectores lógicos",
  //   description: "Causalidad, contraste, adicion y eufonia simple.",
  //   questionCount: 100,
  // ),
  // 'rv_plan': Topic(
  //   id: 'rv_plan',
  //   subjectId: 'rv',
  //   name: "4. Plan de redacción",
  //   description: "Orden logico, temporal y jerarquico de textos.",
  //   questionCount: 100,
  // ),
  // 'rv_lectura': Topic(
  //   id: 'rv_lectura',
  //   subjectId: 'rv',
  //   name: "5. Comprensión de lectura",
  //   description: "Inferencias, extrapolacion e idea principal.",
  //   questionCount: 100,
  // ),
};
