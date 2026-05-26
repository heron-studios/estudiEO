import 'package:learn/models/subject.dart';

final Subject cienciasSocialesSubject = Subject(
  id: 'ciencias-sociales',
  name: "Ciencias Sociales",
  color: '#95E1D3',
  icon: '🌍',
  topicIds: [
    // Solo topics con teoría para modo aprendizaje guiado
    'cs_t1', // Proceso de Hominización (tiene teoría)
  ],
);
