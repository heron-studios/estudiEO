import 'package:learn/models/subject.dart';

final Subject ctaSubject = Subject(
  id: 'cta',
  name: "CTA",
  color: '#A8E6CF',
  icon: '🔬',
  topicIds: [
    // Solo topics con teoría para modo aprendizaje guiado
    'cta_materia_energia',
    'cta_sistema_solar',
    'cta_tabla_periodica',
    'cta_vegetales_fotosintesis',
    'cta_fenomenos_cambioclimatico'
  ],
);
