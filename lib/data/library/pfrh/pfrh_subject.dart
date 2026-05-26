import 'package:learn/models/subject.dart';

final Subject pfrhSubject = Subject(
  id: 'pfrh',
  name: "PFRH",
  color: '#FFD3B6',
  icon: '🤝',
  topicIds: [
    // Solo topics con teoría para modo aprendizaje guiado
    'pfrh_persona_familia',
    'pfrh_derechos_humanos',
    'pfrh_identidad_normas',
    'pfrh_autoestima_autocuidado'
  ],
);
