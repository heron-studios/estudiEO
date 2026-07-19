# 🎓 EDUPOL 2026 - Guía Completa de la Arquitectura

Esta guía reemplaza cualquier documentación antigua. Refleja el estado real, actualizado y masivo del código de EDUPOL.

---

## 📱 1. ¿QUÉ ES EDUPOL AHORA?

EDUPOL es un **Simulador y Entrenador de Alta Tecnología** diseñado específicamente para postulantes a las Fuerzas Policiales (EO PNP, EETSPN) y Fuerzas Armadas, así como para la preparación universitaria avanzada.

Combina:
1.  **Conocimientos Académicos** (Sistema de Repetición Espaciada, Quizzes).
2.  **Entrenamiento Físico y Médico** (Calculadoras de puntaje y tests psicométricos).
3.  **Preparación Táctica** (Simulador de entrevistas con IA).
4.  **Competitividad** (Arena multijugador y Leaderboards).

---

## 🚀 2. FUNCIONALIDADES CLAVE (Características Actuales)

### 🤖 El Tutor ARIA (Inteligencia Artificial)
*   **¿Qué es?** El cerebro de la app en tu Dashboard. Analiza tus tiempos, aciertos y errores en tiempo real.
*   **¿Para qué sirve?** Te dice exactamente qué estás haciendo mal y te guía hacia la materia que debes reforzar.

### ⚔️ Arena Policial (PvP Multijugador)
*   **¿Qué es?** Matchmaking 1 contra 1. 
*   **¿Cómo funciona?** Entras a la arena, el sistema busca un oponente real (o asigna un Bot de entrenamiento). Quien responda mejor gana XP masiva (+50 XP).

### 🏃 Simuladores Oficiales (Físico y de Mérito)
*   **Aptitud Física:** Usa el módulo `fitness` para ingresar la cantidad de planchas, dominadas (barras) o tiempo de carrera. La app calcula el puntaje basado en los Anexos 05 y 06 oficiales.
*   **Cuadro de Mérito:** El módulo `merit` junta tus puntajes de físico, conocimientos y psicométrico para darte tu nota final real.

### 🧠 Área Médica y Psicométrica
La app incluye verdaderos tests psicológicos que toman en las escuelas:
*   **Test de Eysenck:** Mide dimensiones de la personalidad (introversión/neuroticismo).
*   **Test de Sacks:** Completamiento de frases (análisis emocional).
*   **Trail Making Test (TMT):** Evaluación neurológica y de atención focalizada.
*   **Módulo PsicoLearn:** Entrenamiento de silogismos y lógica espacial.

### 🎤 Simulador de Entrevista (Táctico)
*   **Modo Realismo:** Preguntas tipo jurado con una cuenta regresiva que te pone bajo presión constante.
*   **Feedback Táctico:** Te muestra un "Enfoque Táctico" (qué busca el jurado con esa pregunta) y una "Respuesta en Lenguaje Natural". Puedes exportar tu rendimiento a PDF.

### 🎓 Núcleo de Aprendizaje (Core Study)
*   **Sistema SRS:** El clásico sistema de tarjetas de repetición espaciada que evita la curva del olvido.
*   **Flashcards IA:** ¿Cansado de hacer resúmenes? Pega un texto y la app crea las flashcards automáticamente.
*   **Roadmaps:** Una ruta guiada semana a semana para estructurar tu estudio.

---

## 💾 3. ESTRUCTURA DE ALMACENAMIENTO

EDUPOL utiliza una arquitectura híbrida:
*   **Local (Offline First):** Todo tu avance, XP, Quizzes y SRS se guardan localmente. No necesitas internet para estudiar.
*   **Nube (Firebase):** Solo se usa internet para batallas de la Arena, el Ranking en vivo (Leaderboard) y la Autenticación/Módulo Premium.

---

## 🎨 4. NEURAL DESIGN SYSTEM

Si modificas la app, debes seguir las reglas del `NeuralTheme`:
*   **Backgrounds:** Oscuros, con colores espaciales (Dark Mode nativo).
*   **Glassmorphism:** Tarjetas semitransparentes con efecto de cristal esmerilado.
*   **Colores:** Acentos vibrantes (Verde éxito, Rosado neón para alertas, Púrpuras profundos para UI principal).
*   **Animaciones:** Uso de `RepaintBoundary` en loops y animaciones fluidas como el "Orbe de Voz" en el Simulador de Entrevista.

---

## ⚙️ 5. CÓMO EJECUTAR O COMPILAR

```bash
# Descargar dependencias
flutter pub get

# Ejecutar en el dispositivo actual
flutter run

# Generar APK de Android listo para Producción
flutter build apk --release

# Generar IPA de iOS (Requiere macOS)
flutter build ios --release
```

**Conclusión:** Estás ante una plataforma integral (Conocimiento, Físico, Mente y Entrevista). ¡El límite es tu imaginación!
