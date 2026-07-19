# 📦 EDUPOL - RESUMEN DEL PROYECTO (ACTUALIZADO 2026)

## 🎯 Visión General

EDUPOL ha evolucionado de ser una simple app de estudio a convertirse en una **Plataforma Integral de Entrenamiento para Postulantes a las Fuerzas Policiales y Armadas (EO PNP, EETSPN)**.

El sistema está diseñado para cubrir absolutamente todas las fases del proceso de admisión, combinando Inteligencia Artificial, Gamificación Extrema y Simuladores Reales.

---

## 🚀 Arquitectura de Funcionalidades Principales

El código actual está estructurado en módulos (`lib/features/`) altamente especializados:

### 1️⃣ Preparación Académica (Conocimientos)
- **Motor SRS (`srs`)**: Sistema de Repetición Espaciada basado en el algoritmo SM-2. Evalúa en tiempo real si el usuario domina un tema o necesita repasarlo.
- **Flashcards IA (`flashcards`)**: Generador automático de tarjetas de memoria potenciado por IA a partir de textos.
- **Quizzes y Exámenes (`quiz`, `exam`)**: Simulacros de exámenes de admisión.
- **Ruta de Aprendizaje (`roadmap`)**: Caminos guiados para asegurar la progresión lógica del postulante.

### 2️⃣ Entrenamiento Psicométrico y Médico (`medical`, `psicolearn`)
EDUPOL no solo prepara conocimientos, sino también la mente del postulante:
- **Test de Eysenck (`medical/presentation/eysenck_test_screen.dart`)**: Simulador oficial de evaluación de personalidad (introversión/extroversión, neuroticismo).
- **Test de Sacks (`medical/presentation/sacks_test_screen.dart`)**: Evaluación de frases incompletas.
- **Trail Making Test (`medical/presentation/trail_making_test_screen.dart`)**: Examen de atención y función cognitiva.
- **PsicoLearn (`psicolearn`)**: Entrenamiento para superar evaluaciones psicométricas (Silogismos, Razonamiento abstracto, Reentrenamiento).

### 3️⃣ Simulador de Entrevista Personal (`interview`)
- **Simulador Táctico (`interview_screen.dart`)**: Someta al postulante a preguntas de entrevista bajo presión (Modo Realismo con cuenta regresiva).
- Proporciona el "Enfoque Táctico" de la respuesta y el "Lenguaje Natural" ideal a utilizar.
- Exportación de resultados a PDF.

### 4️⃣ Simuladores Físicos y de Mérito
- **Calculadora de Aptitud Física (`fitness`)**: Algoritmo exacto basado en los Anexos 05 y 06 para calcular puntajes en base a flexiones, barras y carrera.
- **Cuadro de Mérito (`merit`)**: Simulador ponderado para saber exactamente qué puntaje final se obtendrá promediando todas las fases (Física, Psicométrica, Conocimientos, Entrevista).

### 5️⃣ IA, Gamificación y Competencia Social
- **Tutor Analítico ARIA (`dashboard`)**: Un "Cerebro" de Inteligencia Artificial que monitoriza el progreso global del postulante, detecta sus materias más débiles e instruye en tiempo real.
- **Leaderboards (Firebase)**: Rankings en vivo separados por escuela (EO PNP vs EETSPN), combinando usuarios reales y bots (para mantener competitividad 24/7).
- **Arena Policial (`arena`)**: Matchmaking multijugador 1v1 donde los usuarios compiten en duelos de preguntas para robar XP.

### 6️⃣ MiniApps e Interactivos (`miniapps`)
Herramientas secundarias para repaso dinámico:
- Tabla Periódica Interactiva
- ANP Master (Áreas Naturales Protegidas)
- Productos Notables
- Calculadoras VIP.

### 7️⃣ Infraestructura Core
- **Diseño**: "Neural Design System" - Estética cyberpunk, glassmorphism, orbes de voz y animaciones fluidas.
- **Monetización (`premium`)**: Módulo de suscripción para desbloquear funciones avanzadas (MiniApps bloqueadas).
- **Almacenamiento Local**: Todo el núcleo educativo persiste offline vía `LocalStorageService` (Hive/GetStorage), protegiendo la privacidad y funcionando sin internet.

---

## 📈 Conclusión de Arquitectura

EDUPOL ya no compite con academias pre-policiales tradicionales; **las reemplaza por completo**. Es un simulador inmersivo y de alta tecnología, listo para llevar a los postulantes al número 1 del Cuadro de Mérito.
