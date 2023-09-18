
bool chekcAccesPilotage(Map accesPilotage) {
  if (accesPilotage["est_bloque"]) {
    return false;
  }
  if (accesPilotage["est_spectateur"] || accesPilotage["est_collecteur"] || accesPilotage["est_validateur"] || accesPilotage["est_admin"]) {
    return true;
  }
  return false;
}