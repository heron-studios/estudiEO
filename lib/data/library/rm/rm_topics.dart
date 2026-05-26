import 'package:learn/models/topic.dart';

final Map<String, Topic> razonamientoMatematicoTopics = {
  'rm_sucesiones': Topic(
    id: 'rm_sucesiones',
    subjectId: 'rm',
    name: "1. Sucesiones numericas",
    description: "Progresiones aritmeticas, geometricas y series compuestas.",
    questionCount: 71,
  ),
  'rm_edades': Topic(
    id: 'rm_edades',
    subjectId: 'rm',
    name: "2. Problemas de edades",
    description: "Planteo de tiempos en el pasado, presente y futuro.",
    questionCount: 57,
  ),
  'rm_fracciones': Topic(
    id: 'rm_fracciones',
    subjectId: 'rm',
    name: "3. Fracciones y porcentajes",
    description: "Problemas de mezclas, descuentos y variaciones porcentuales.",
    questionCount: 55,
  ),
  'rm_ecuaciones': Topic(
    id: 'rm_ecuaciones',
    subjectId: 'rm',
    name: "4. Planteo de ecuaciones",
    description: "Problemas generales, razonamiento logico y metodos operativos.",
    questionCount: 117,
  ),
};
