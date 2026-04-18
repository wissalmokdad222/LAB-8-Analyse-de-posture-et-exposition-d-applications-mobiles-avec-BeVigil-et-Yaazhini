# Notes d'analyse Yaazhini

## Éléments identifiés

### Élément 1: Hardcoded API Key
- **Localisation**: assets/config.json
- **Description**: Une clé API est stockée en clair dans un fichier de configuration accessible dans l’APK.
- **Impact potentiel**: Un attaquant peut extraire cette clé et l’utiliser pour accéder aux services backend ou consommer des API à l’insu du propriétaire.
- **Remédiation suggérée**: Ne jamais stocker les clés sensibles côté client. Utiliser un backend sécurisé ou des variables d’environnement.

---

### Élément 2: Données sensibles dans SharedPreferences
- **Localisation**: /data/data/<package_name>/shared_prefs/
- **Description**: Des informations utilisateur (tokens ou identifiants) sont stockées en clair dans les SharedPreferences.
- **Impact potentiel**: En cas d’accès au device (root ou malware), ces données peuvent être récupérées et utilisées pour usurper une session utilisateur.
- **Remédiation suggérée**: Utiliser le chiffrement (EncryptedSharedPreferences) pour protéger les données sensibles.

---

### Élément 3: Permissions excessives
- **Localisation**: AndroidManifest.xml
- **Description**: L’application demande des permissions non nécessaires (ex: accès au stockage ou à Internet sans justification claire).
- **Impact potentiel**: Augmente la surface d’attaque et peut exposer les données utilisateur.
- **Remédiation suggérée**: Appliquer le principe du moindre privilège en supprimant les permissions inutiles.

---

### Élément 4: Absence de certificate pinning
- **Localisation**: Configuration réseau / code source
- **Description**: L’application ne vérifie pas les certificats SSL du serveur distant.
- **Impact potentiel**: Vulnérable aux attaques Man-In-The-Middle (MITM), permettant l’interception des communications.
- **Remédiation suggérée**: Implémenter le certificate pinning pour sécuriser les communications HTTPS.

---

### Élément 5: Code de debug activé
- **Localisation**: AndroidManifest.xml (android:debuggable="true")
- **Description**: L’application est compilée avec l’option debug activée.
- **Impact potentiel**: Facilite l’analyse et le reverse engineering par un attaquant.
- **Remédiation suggérée**: Désactiver le mode debug en production (android:debuggable="false").

---