
/// Compara as versões para garantir que possa executar
/// Caso 
bool compareVersion(String currentVersion, String minimumVersion) {
  return currentVersion.compareTo(minimumVersion) >= 0;
}