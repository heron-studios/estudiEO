import 'package:learn/models/topic.dart';
import 'hominizacion_theory.dart';
import 'tahuantinsuyo_theory.dart';

final Map<String, Topic> cienciasSocialesTopics = {
  // Topics con teoría (modo aprendizaje guiado)
  'cs_t1': Topic(
    id: 'cs_t1',
    subjectId: 'ciencias-sociales',
    name: "1. Proceso de Hominizacion",
    description: "Evolucion biologica y cultural desde Australopithecus hasta Homo sapiens sapiens, poblamiento y sedentarizacion.",
    questionCount: 190,
    theoryByLevel: {
      'easy': hominizacionTheoryEasy,
      'medium': hominizacionTheoryMedium,
      'hard': hominizacionTheoryHard,
      'extreme': hominizacionTheoryExtreme,
    },
  ),
  'cs_t2': Topic(
    id: 'cs_t2',
    subjectId: 'ciencias-sociales',
    name: "2. Tahuantinsuyo: Evolucion y Organizacion",
    description: "Expansion, organizacion politica, reciprocidad, redistribucion, mita, colcas y autoridades incas.",
    questionCount: 190,
    theoryByLevel: {
      'easy': tahuantinsuyoTheoryEasy,
      'medium': tahuantinsuyoTheoryMedium,
      'hard': tahuantinsuyoTheoryHard,
      'extreme': tahuantinsuyoTheoryExtreme,
    },
  ),
  
  // Topics sin teoría (solo quiz) - comentados para ocultar del modo aprendizaje guiado
  // 'cs_t3': Topic(
  //   id: 'cs_t3',
  //   subjectId: 'ciencias-sociales',
  //   name: "3. Areas Naturales Protegidas",
  //   description: "Parques, santuarios, reservas nacionales, SINANPE, SERNANP y uso directo o indirecto.",
  //   questionCount: 220,
  // ),
  // 'cs_t4': Topic(
  //   id: 'cs_t4',
  //   subjectId: 'ciencias-sociales',
  //   name: "4. Ecosistemas y Desarrollo Sostenible",
  //   description: "Cambio climatico, energia renovable, economia circular, huella hidrica y problematica ambiental peruana.",
  //   questionCount: 190,
  // ),
  // 'cs_t5': Topic(
  //   id: 'cs_t5',
  //   subjectId: 'ciencias-sociales',
  //   name: "5. Redes Viales e Infraestructura",
  //   description: "Jerarquizacion vial, rutas del SINAC, vias nacionales, departamentales, vecinales y autoridades competentes.",
  //   questionCount: 190,
  // ),
};
