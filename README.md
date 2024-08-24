# 🚀 Ruby WEBrick App

## 📝 Description

Ce projet est une application web simple en Ruby utilisant **WEBrick** comme serveur HTTP, **MySQL** pour la base de données, et **ERB** pour le rendu des vues. L'application permet à un utilisateur de se connecter, de saisir des informations personnelles, et de consulter une liste des utilisateurs avec leurs informations professionnelles.

## 📁 Structure des fichiers

- **`app.rb`** : Le cœur de l'application qui définit les routes pour l'authentification, l'entrée d'informations personnelles, et l'affichage de la liste des utilisateurs.
  
- **`login.erb`** : Vue pour la page de connexion, avec un formulaire pour entrer le login et le mot de passe.

- **`information.erb`** : Vue pour la page d'entrée des informations personnelles, où l'utilisateur peut saisir son prénom, nom, email, et profession.

- **`liste.erb`** : Vue qui affiche la liste des utilisateurs avec leurs informations professionnelles dans un format simple.

## 🚀 Comment lancer le projet

1. Assurez-vous d'avoir Ruby, WEBrick, et le gem `mysql2` installés :
   ```bash
   gem install webrick mysql2
   ```

2. Lancez le serveur avec la commande :
   ```bash
   ruby app.rb
   ```

3. Accédez à l'application via votre navigateur à l'adresse : [http://localhost:3003/login](http://localhost:3003/login).

---
