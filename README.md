# 🦅 EDUPOL 2026 - El Simulador Definitivo (PNP & FFAA)

![EDUPOL Banner](screenshot.png)

EDUPOL es una **plataforma integral de entrenamiento y simulación** desarrollada en Flutter. Está diseñada exclusivamente para postulantes a las Escuelas de Oficiales (EO PNP) y Suboficiales (EETSPN), así como para postulantes exigentes de las Fuerzas Armadas y Universidades.

No es un simple banco de preguntas. Es un **entrenador táctico, físico, médico y académico** potenciado por Inteligencia Artificial.

---

## 🔥 Características Principales

*   🤖 **Tutor ARIA (IA):** Cerebro analítico que evalúa tu progreso en tiempo real y te dice exactamente qué temas estudiar para mejorar.
*   ⚔️ **Arena Policial:** Matchmaking multijugador 1v1 para competir en vivo contra otros postulantes y dominar el Leaderboard Nacional.
*   🏃‍♂️ **Simulador de Aptitud Física:** Calculadora de puntajes exacta basada en los anexos oficiales de la policía (Anexo 05 y 06).
*   🧠 **Área Médica y Psicométrica:** Simuladores de los exámenes de Eysenck, Sacks y Trail Making Test (TMT), fundamentales para la evaluación médica.
*   🎤 **Simulador Táctico (Entrevista Personal):** Modo de presión con cuenta regresiva. Te entrena en cómo formular respuestas con enfoque táctico.
*   📚 **Tecnología Educativa Core:** Motor SRS (Spaced Repetition System) y Flashcards generadas automáticamente con Inteligencia Artificial.
*   📊 **Cuadro de Mérito:** Herramienta predictiva para calcular tu orden de mérito final ponderando todos tus exámenes.
*   📱 **100% Offline (Core):** Estudia el contenido académico sin internet usando la arquitectura local (Hive/GetStorage).

---

## 🚀 Inicio Rápido (Desarrollo)

### Prerrequisitos
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (última versión estable)
- Android Studio o Xcode (para emulación)

### Ejecutar el Proyecto
1. Clona o descarga este repositorio.
2. Abre una terminal en la raíz del proyecto.
3. Descarga las dependencias:
   ```bash
   flutter pub get
   ```
4. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

### Construir para Producción
Para generar el instalador de Android (APK):
```bash
flutter build apk --release
```

Para iOS (requiere Mac):
```bash
flutter build ios --release
```

---

## 📁 Estructura del Código (Arquitectura Limpia y Modular)

El proyecto está diseñado bajo una arquitectura modular por características (`Feature-First`):

```text
lib/
├── core/                   # Tema (NeuralTheme), utilidades, servicios compartidos.
├── features/               # Módulos principales de la aplicación:
│   ├── arena/              # Multijugador PvP
│   ├── dashboard/          # Tutor ARIA, Leaderboards
│   ├── interview/          # Simulador de Entrevista
│   ├── medical/            # Tests (Eysenck, Sacks, TMT)
│   ├── fitness/            # Calculadora Física
│   ├── psicolearn/         # Psicotécnico
│   ├── srs/ & flashcards/  # Motor de aprendizaje espaciado e IA
│   ├── quiz/ & exam/       # Evaluaciones y simulacros
│   ├── miniapps/           # Herramientas interactivas
│   └── premium/            # Módulo de monetización
├── providers/              # Gestión de estado global
└── main.dart               # Punto de entrada
```

---

## 🎨 Neural Design System
Este proyecto utiliza un sistema de diseño propio llamado **Neural Design System**. 
Si vas a contribuir, asegúrate de mantener el estándar:
- Uso extensivo de **Glassmorphism** (Cards translúcidas sobre fondos oscuros).
- Colores **Cyberpunk / Neón** (Deep Purple, Cyan, Pink, Success Green).
- Optimización estricta: Uso de `RepaintBoundary` para animaciones continuas (ej. Orbe de voz del simulador de entrevista) garantizando un rendimiento óptimo en móviles de gama baja.

---
**Hecho para asegurar el puesto número 1. Desarrollado en 2026.**
