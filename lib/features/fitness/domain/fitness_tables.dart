// ─────────────────────────────────────────────────────────────────────────────
//  fitness_tables.dart — Tablas exactas del Prospecto Oficial EO-PNP 2026
//  Fuente: Anexo 05 (Varones) y Anexo 06 (Damas)
// ─────────────────────────────────────────────────────────────────────────────

enum FitnessGender { male, female }

enum FitnessTest { sprint100m, run1000m, strength, swim25m }

class FitnessTables {
  // ── 100 metros planos ──────────────────────────────────────────────────────
  static int score100mMale(double s) {
    if (s <= 13.9) return 20;
    if (s <= 14.0) return 19;
    if (s <= 14.1) return 18;
    if (s <= 14.2) return 17;
    if (s <= 14.3) return 16;
    if (s <= 14.4) return 15;
    if (s <= 14.5) return 14;
    if (s <= 14.6) return 13;
    if (s <= 14.7) return 12;
    if (s <= 14.8) return 11;
    if (s <= 14.9) return 10;
    if (s <= 15.0) return 9;
    if (s <= 15.1) return 8;
    if (s <= 15.2) return 7;
    if (s <= 15.3) return 6;
    if (s <= 15.4) return 5;
    if (s <= 15.5) return 4;
    if (s <= 15.6) return 3;
    if (s <= 15.7) return 2;
    if (s <= 15.8) return 1;
    return 0;
  }

  static int score100mFemale(double s) {
    if (s <= 16.9) return 20;
    if (s <= 17.0) return 19;
    if (s <= 17.1) return 18;
    if (s <= 17.2) return 17;
    if (s <= 17.3) return 16;
    if (s <= 17.4) return 15;
    if (s <= 17.5) return 14;
    if (s <= 17.6) return 13;
    if (s <= 17.7) return 12;
    if (s <= 17.8) return 11;
    if (s <= 17.9) return 10;
    if (s <= 18.0) return 9;
    if (s <= 18.1) return 8;
    if (s <= 18.2) return 7;
    if (s <= 18.3) return 6;
    if (s <= 18.4) return 5;
    if (s <= 18.5) return 4;
    if (s <= 18.6) return 3;
    if (s <= 18.7) return 2;
    if (s <= 18.8) return 1;
    return 0;
  }

  // ── 1000 metros planos ─────────────────────────────────────────────────────
  static int score1000mMale(int t) {
    if (t <= 206) return 20;
    if (t <= 209) return 19;
    if (t <= 212) return 18;
    if (t <= 215) return 17;
    if (t <= 218) return 16;
    if (t <= 221) return 15;
    if (t <= 224) return 14;
    if (t <= 227) return 13;
    if (t <= 230) return 12;
    if (t <= 233) return 11;
    if (t <= 236) return 10;
    if (t <= 239) return 9;
    if (t <= 242) return 8;
    if (t <= 245) return 7;
    if (t <= 248) return 6;
    if (t <= 251) return 5;
    if (t <= 254) return 4;
    if (t <= 257) return 3;
    if (t <= 260) return 2;
    if (t <= 263) return 1;
    return 0;
  }

  static int score1000mFemale(int t) {
    if (t <= 245) return 20;
    if (t <= 248) return 19;
    if (t <= 251) return 18;
    if (t <= 254) return 17;
    if (t <= 257) return 16;
    if (t <= 260) return 15;
    if (t <= 263) return 14;
    if (t <= 266) return 13;
    if (t <= 269) return 12;
    if (t <= 272) return 11;
    if (t <= 275) return 10;
    if (t <= 278) return 9;
    if (t <= 281) return 8;
    if (t <= 284) return 7;
    if (t <= 287) return 6;
    if (t <= 290) return 5;
    if (t <= 293) return 4;
    if (t <= 296) return 3;
    if (t <= 299) return 2;
    if (t <= 302) return 1;
    return 0;
  }

  // ── Barras (Varones) ───────────────────────────────────────────────────────
  static int scoreBarsMale(int reps) {
    if (reps >= 16) return 20;
    if (reps == 15) return 19;
    if (reps == 14) return 18;
    if (reps == 13) return 17;
    if (reps == 12) return 16;
    if (reps == 11) return 15;
    if (reps == 10) return 14;
    if (reps == 9) return 13;
    if (reps == 8) return 12;
    if (reps == 7) return 11;
    if (reps == 6) return 10;
    if (reps == 5) return 9;
    if (reps == 4) return 8;
    if (reps == 3) return 7;
    if (reps == 2) return 6;
    if (reps == 1) return 5;
    return 4;
  }

  // ── Abdominales (Damas) ────────────────────────────────────────────────────
  static int scoreAbsFemale(int reps) {
    if (reps >= 45) return 20;
    if (reps == 44) return 19;
    if (reps == 43) return 18;
    if (reps == 42) return 17;
    if (reps == 41) return 16;
    if (reps == 40) return 15;
    if (reps == 39) return 14;
    if (reps == 38) return 13;
    if (reps == 37) return 12;
    if (reps == 36) return 11;
    if (reps == 35) return 10;
    if (reps == 34) return 9;
    if (reps == 33) return 8;
    if (reps == 32) return 7;
    if (reps == 31) return 6;
    if (reps == 30) return 5;
    if (reps == 29) return 4;
    if (reps == 28) return 3;
    if (reps == 27) return 2;
    if (reps == 26) return 1;
    return 0;
  }

  // ── Natación 25m ──────────────────────────────────────────────────────────
  static int scoreSwimMale(double s) {
    if (s <= 22) return 20;
    if (s <= 23) return 19;
    if (s <= 24) return 18;
    if (s <= 25) return 17;
    if (s <= 26) return 16;
    if (s <= 27) return 15;
    if (s <= 28) return 14;
    if (s <= 29) return 13;
    if (s <= 30) return 12;
    if (s <= 31) return 11;
    if (s <= 32) return 10;
    if (s <= 33) return 9;
    if (s <= 34) return 8;
    if (s <= 35) return 7;
    if (s <= 36) return 6;
    if (s <= 37) return 5;
    if (s <= 38) return 4;
    if (s <= 39) return 3;
    if (s <= 40) return 2;
    if (s <= 41) return 1;
    return 0;
  }

  static int scoreSwimFemale(double s) {
    if (s <= 27) return 20;
    if (s <= 28) return 19;
    if (s <= 29) return 18;
    if (s <= 30) return 17;
    if (s <= 31) return 16;
    if (s <= 32) return 15;
    if (s <= 33) return 14;
    if (s <= 34) return 13;
    if (s <= 35) return 12;
    if (s <= 36) return 11;
    if (s <= 37) return 10;
    if (s <= 38) return 9;
    if (s <= 39) return 8;
    if (s <= 40) return 7;
    if (s <= 41) return 6;
    if (s <= 42) return 5;
    if (s <= 43) return 4;
    if (s <= 44) return 3;
    if (s <= 45) return 2;
    if (s <= 46) return 1;
    return 0;
  }

  // -1 = NSN (No Sabe Nadar) → eliminado
  static int getScore({
    required FitnessTest test,
    required FitnessGender gender,
    required double value,
    bool nsn = false,
  }) {
    if (test == FitnessTest.swim25m && nsn) return -1;
    switch (test) {
      case FitnessTest.sprint100m:
        return gender == FitnessGender.male
            ? score100mMale(value)
            : score100mFemale(value);
      case FitnessTest.run1000m:
        return gender == FitnessGender.male
            ? score1000mMale(value.toInt())
            : score1000mFemale(value.toInt());
      case FitnessTest.strength:
        return gender == FitnessGender.male
            ? scoreBarsMale(value.toInt())
            : scoreAbsFemale(value.toInt());
      case FitnessTest.swim25m:
        return gender == FitnessGender.male
            ? scoreSwimMale(value)
            : scoreSwimFemale(value);
    }
  }
}
