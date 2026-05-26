import 'package:learn/models/topic.dart';

final Map<String, Topic> matematicasTopics = {
  'mat_algebra': Topic(
    id: 'mat_algebra',
    subjectId: 'matematicas',
    name: "1. Operaciones algebraicas",
    description: "Ecuaciones, polinomios y simplificacion algebraica.",
    questionCount: 100,
  ),
  'mat_angulos': Topic(
    id: 'mat_angulos',
    subjectId: 'matematicas',
    name: "2. Angulos en el triangulo",
    description: "Propiedades fundamentales de triangulos y geometria plana.",
    questionCount: 100,
  ),
  'mat_pitagoras': Topic(
    id: 'mat_pitagoras',
    subjectId: 'matematicas',
    name: "3. Teorema de Pitagoras",
    description: "Triangulos rectangulos, catetos e hipotenusa.",
    questionCount: 100,
  ),
  'mat_trigo': Topic(
    id: 'mat_trigo',
    subjectId: 'matematicas',
    name: "4. Funciones trigonometricas",
    description: "Seno, coseno, tangente y razones notables.",
    questionCount: 100,
  ),
};
