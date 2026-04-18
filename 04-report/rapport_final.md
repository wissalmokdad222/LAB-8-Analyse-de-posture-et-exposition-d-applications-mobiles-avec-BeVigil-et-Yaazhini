# Rapport d'analyse de sécurité mobile

## A. Informations générales
- **Date**: 2026-04-18
- **Analyste**: Wissal MOKDAD
- **Cible**: application_pedagogique.apk
- **Version/Hash**: 4546544a3ffb85bc27b6fbf7afe004b7a226798b83397e93eb56c7d33600c185 (SHA-256)
- **Outils utilisés**: BeVigil v2.1.0, Yaazhini

## B. Résumé exécutif
L'analyse de sécurité a permis d'identifier 5 constats principaux répartis en 2 sévérités Hautes, 2 Moyennes et 1 Basse. Le niveau de risque global est jugé **Élevé** en raison de l'exposition de données sensibles côté client (clés d'API et identifiants locaux). Les catégories de vulnérabilités les plus fréquentes concernent le stockage local non sécurisé et la configuration réseau laxiste. Une remédiation rapide est fortement recommandée sur la gestion de ces secrets et sur les paramètres du Manifest.

## C. Top 5 constats

### 1. API Key exposée - FIND-001
- **Sévérité**: High
- **Preuve**: `bevigil_export.json:` section assets (`assets/config.json`)
- **Impact**: Accès non autorisé aux services backend de l'application ou abus de quota d'API.
- **Remédiation**: Stocker cette clé de manière sécurisée ou utiliser un backend sécurisé pour requêter l'API au lieu de la mettre côté client.
- **Référence OWASP**: MASVS-STORAGE-1

### 2. Données sensibles dans SharedPreferences - FIND-004
- **Sévérité**: High
- **Preuve**: `/data/data/<package_name>/shared_prefs/` (Rapport Yaazhini)
- **Impact**: En cas d'accès physique à l'appareil via un malware ou root, usurpation d'une session utilisateur possible.
- **Remédiation**: Utiliser la bibliothèque `EncryptedSharedPreferences` pour chiffrer les données sensibles localement.
- **Référence OWASP**: MASVS-STORAGE-2

### 3. Communication en clair / Absence de Certificate Pinning - FIND-002
- **Sévérité**: Medium
- **Preuve**: `yaazhini_report:section network` et code source
- **Impact**: Vulnérabilité aux attaques Man-In-The-Middle (MITM) permettant l'interception et la modification des données.
- **Remédiation**: Implémenter strictement SSL/TLS pour toutes les communications et ajouter le niveau Certificate Pinning.
- **Référence OWASP**: MASVS-NETWORK-1

### 4. Sauvegarde (Backup) activée - FIND-003
- **Sévérité**: Medium
- **Preuve**: `AndroidManifest.xml` (`allowBackup="true"`)
- **Impact**: Un attaquant peut extraire une grande partie des données du répertoire de l'application via `adb backup`.
- **Remédiation**: Désactiver la fonctionnalité de backup automatique dans `AndroidManifest.xml` (mettre `android:allowBackup="false"`).
- **Référence OWASP**: MASVS-STORAGE-4

### 5. Mode debug activé en production - FIND-005
- **Sévérité**: Low
- **Preuve**: `AndroidManifest.xml` (`android:debuggable="true"`)
- **Impact**: Facilite largement l'analyse dynamique et le reverse engineering par un attaquant en lui permettant d'attacher un débogueur.
- **Remédiation**: Compiler systématiquement l'application avec l'option debug désactivée pour la publication et la production.
- **Référence OWASP**: MASVS-RESILIENCE-2

## D. Faux positifs notables
- **URLs publiques détectées** : BeVigil a signalé plusieurs URLs sortantes (comme https://www.example.com/privacy). Ces liens sont légitimes pour le fonctionnement et l'information de l'utilisateur. Ils ne constituent pas une fuite de données ou un point de terminaison vulnérable.
- **Firebase détecté comme "danger potentiel"** : L'utilisation de bibliothèques tierces comme Firebase a été listée. Si elle n'est utilisée que de manières sécurisées (sans règles Firebase Database public par exemple, ce qui n'est pas le cas ici), sa simple présence est un faux positif en matière de vulnérabilité directe.

## E. Recommandations prioritaires
1. **Sécuriser de toute urgence le stockage des secrets client** (Retirer la clé de l'API hardcodée dans `config.json` et implémenter `EncryptedSharedPreferences`).
2. **Durcir la configuration de l'application via le Manifest** (Mettre impérativement `android:debuggable="false"` et `allowBackup="false"`).
3. **Renforcer la sécurité réseau des API** (Désactiver tout trafic en clair et implémenter le Certificate Pinning vers les points de terminaisons critiques).

## F. Annexes
- [Lien vers exports BeVigil](../01-bevigil/bevigil_export.json)
- [Lien vers rapport Yaazhini](../02-yaazhini/yaazhini_notes.litcoffee)
- [Lien vers triage.csv](../03-triage/triage.csv)
