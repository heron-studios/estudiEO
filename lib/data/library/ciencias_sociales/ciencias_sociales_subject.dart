import 'package:learn/models/subject.dart';

final Subject cienciasSocialesSubject = Subject(
  id: 'ciencias-sociales',
  name: 'Ciencias Sociales',
  color: '#95E1D3',
  icon: '🌍',
  topicIds: [
    // Solo topics con teoría para modo aprendizaje guiado
    'cs_t1', // Proceso de Hominización
    'cs_t2', // Tahuantinsuyo: Evolución y Organización
    'cs_t3', // Áreas Naturales Protegidas
    'cs_t4', // Ecosistemas, Tecnología y Desarrollo Sostenible
    'cs_t5', // Redes Viales: Características, Tipos e Importancia
  ],
);
