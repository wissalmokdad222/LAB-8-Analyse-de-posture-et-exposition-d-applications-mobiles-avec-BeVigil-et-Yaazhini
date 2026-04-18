# Notes d'analyse BeVigil

## Ce qui est certain
- L'APK est signé avec la signature V2 et SHA-256 vérifiable.
- Endpoints API détectés : `/login` (POST) et `/data` (GET).
- Technologies principales utilisées : Firebase, Retrofit, Glide.
- URLs publiques détectées : https://www.example.com/privacy et https://www.example.com/terms.
- Assets détectés : `res/drawable/logo.png` et `assets/config.json`.

## Ce qui est hypothèse
- Les endpoints pourraient exposer des données sensibles si mal configurés.
- Les technologies détectées pourraient contenir des vulnérabilités si non mises à jour.
- Les URLs détectées pourraient pointer vers des ressources externes non sécurisées.
- D’autres assets ou endpoints non détectés pourraient contenir des informations sensibles.

## Points d'intérêt
- Vérifier si les endpoints nécessitent une authentification correcte.
- Contrôler que toutes les URLs sont sécurisées (HTTPS).
- Surveiller les versions de Firebase, Retrofit et Glide pour d’éventuelles vulnérabilités.

## Domaines et sous-domaines
- api.example.com

## Endpoints et APIs
- POST https://api.example.com/login → authentification
- GET https://api.example.com/data → récupération de données

## URLs HTTP/HTTPS
- https://www.example.com/privacy
- https://www.example.com/terms

## Emails et identifiants
- Aucun email détecté dans le JSON, possibilité de rechercher dans le code source si nécessaire.

## Technologies détectées
- Firebase
- Retrofit
- Glide