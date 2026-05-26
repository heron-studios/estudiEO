import 'package:learn/models/learning_level.dart';

final Map<Dificultad, String> vegetalesFotosintesisTheory = {
  Dificultad.facil: r'''
La fotosíntesis es el proceso mediante el cual los vegetales, las algas y algunas bacterias transforman la energía de la luz solar en energía química. Para que este proceso inicie, los organismos requieren tres componentes básicos: dióxido de carbono (CO2) del aire, agua (H2O) absorbida por las raíces y la energía de la luz del sol. Las plantas realizan este proceso en unos orgánulos especiales llamados cloroplastos, los cuales contienen un pigmento verde llamado clorofila encargado de capturar la energía solar. Como resultado de esta asombrosa fábrica química, la planta produce glucosa (un tipo de azúcar que le sirve de alimento y energía) y libera oxígeno (O2) a la atmósfera, un gas vital para la respiración de los animales y seres humanos.
''',
  Dificultad.medio: r'''
El proceso de la fotosíntesis no ocurre de un solo golpe, sino que se divide en dos fases principales íntimamente ligadas: la fase luminosa y la fase oscura (o ciclo de Calvin). La fase luminosa ocurre en los tilacoides de los cloroplastos; aquí la luz solar se utiliza para excitar los electrones de la clorofila, rompiendo moléculas de agua y generando oxígeno, al mismo tiempo que se produce energía química en forma de ATP y una molécula transportadora de electrones llamada NADPH. Posteriormente, en la fase oscura, que tiene lugar en el espacio líquido llamado estroma, no se necesita luz directamente. Utilizando el ATP y el NADPH generados previamente, la planta "fija" el dióxido de carbono del aire para sintetizar glucosa y otros azúcares complejos.

Factores ambientales como la luz, la temperatura y la concentración de CO2 afectan este rendimiento. Si hay sequía, las plantas cierran sus estomas para no perder agua, pero esto también detiene la entrada de CO2. En otoño, la eficiencia de este proceso disminuye al bajar la luz y las temperaturas, causando que muchas hojas cambien de color al perder clorofila.
''',
  Dificultad.dificil: r'''
El proceso de la fotosíntesis puede analizarse con mucho mayor rigor químico. Durante la fase luminosa, la captura de la energía ocurre a través de redes de pigmentos llamadas "fotosistemas" ubicados en los tilacoides. El Fotosistema II capta luz a 680 nm (P680) y el Fotosistema I capta luz a 700 nm (P700). Cuando el Fotosistema II pierde un electrón excitado por la luz, debe reponerlo mediante la fotólisis del agua: la ruptura de H2O libera electrones, protones (H+) y el oxígeno molecular (O2) que respiramos. En un proceso denominado "fotofosforilación acíclica", intervienen ambos fotosistemas para producir ATP y NADPH. Si la planta sólo requiere ATP, puede hacer "fotofosforilación cíclica", donde sólo interviene el Fotosistema I y no se produce oxígeno ni NADPH.

Por otro lado, existe un antagonismo natural con otro proceso vital: la respiración celular. Mientras la fotosíntesis es un proceso anabólico reductor que consume energía y CO2 para fabricar glucosa, la respiración es un proceso catabólico oxidativo que destruye la glucosa consumiendo oxígeno para liberar energía química, formando una ecuación casi opuesta.
''',
  Dificultad.extremo: r'''
A un nivel bioquímico profundo, el Ciclo de Calvin consta de tres etapas: carboxilación, reducción y recuperación. En la fijación, el CO2 se incorpora a un azúcar de 5 carbonos (Ribulosa-1,5-difosfato) generando un inestable intermedio de 6 carbonos que se rompe en dos moléculas de Ácido 3-fosfoglicérico (3C). Estas son reducidas mediante gasto de ATP y NADPH formando Gliceraldehido-3-fosfato (G3P). Para generar una sola molécula de glucosa (6C), el ciclo debe dar vueltas incorporando 6 moléculas de CO2, y el balance energético total resulta en el brutal consumo de 18 moléculas de ATP y 12 de NADPH.

De modo paralelo a la fotosíntesis, existen organismos capaces de fijar carbono sin luz: los quimioautótrofos. La quimiosíntesis permite obtener energía de la oxidación de compuestos inorgánicos reducidos (NH3, H2S, CH4) en ambientes extremos. Las ferrobacterias, por ejemplo, oxidan el hierro ferroso a hierro férrico, o las sulfobacterias oxidan el azufre, cerrando ciclos vitales de materia en ecosistemas donde la luz solar es inexistente.
''',
};
