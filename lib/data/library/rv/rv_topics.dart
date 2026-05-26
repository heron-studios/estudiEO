import 'package:learn/models/topic.dart';

final Map<String, Topic> razonamientoVerbalTopics = {
  'rv_sinonimos': Topic(
    id: 'rv_sinonimos',
    subjectId: 'rv',
    name: "1. Sinónimos",
    description: "Sinonimos directos, contextuales y por transgresion morfologica.",
    questionCount: 150,
  ),
  'rv_antonimos': Topic(
    id: 'rv_antonimos',
    subjectId: 'rv',
    name: "2. Antónimos",
    description: "Antonimos absolutos y relativos.",
    questionCount: 100,
  ),
  'rv_conectores': Topic(
    id: 'rv_conectores',
    subjectId: 'rv',
    name: "3. Conectores lógicos",
    description: "Causalidad, contraste, adicion y eufonia simple.",
    questionCount: 100,
  ),
  'rv_plan': Topic(
    id: 'rv_plan',
    subjectId: 'rv',
    name: "4. Plan de redacción",
    description: "Orden logico, temporal y jerarquico de textos.",
    questionCount: 100,
  ),
  'rv_lectura': Topic(
    id: 'rv_lectura',
    subjectId: 'rv',
    name: "5. Comprensión de lectura",
    description: "Inferencias, extrapolacion e idea principal.",
    questionCount: 100,
  ),
};
