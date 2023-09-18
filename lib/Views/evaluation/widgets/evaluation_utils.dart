bool checkAccesPilotage(Map accesEvaluation) {
  if (accesEvaluation["est_bloque"]) {
    return false;
  }
  if (accesEvaluation["est_spectateur"] || accesEvaluation["est_collecteur"] || accesEvaluation["est_validateur"] || accesEvaluation["est_admin"]) {
    return true;
  }
  return false;
}