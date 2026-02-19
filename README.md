# ✈️ Aviation Data Analytics: Projet ELT (Snowflake, dbt, Deepnote)

## 📌 Présentation du Projet
Ce projet met en œuvre une architecture **ELT (Extract, Load, Transform)** complète pour analyser les données d'une flotte aérienne.L'objectif est de transformer des données brutes stockées dans **Snowflake** en modèles de données structurés via **dbt**, afin de répondre à des questions stratégiques sur les performances des compagnies, des aéroports et des appareils.

---

## 🏗️ Architecture du Projet
Le projet suit une structure de données moderne en trois étapes :
1.  **Ingestion (Load)** : Chargement de 5 tables brutes dans l'entrepôt Snowflake : AIRCRAFT, AIRLINES, AIRPORTS, FLIGHT_SUMMARY_DATA et INDIVIDUAL_FLIGHTS.
2.  **Transformation (dbt)** : 
    * **Couche Staging** : Nettoyage, renommage des colonnes et typage des données (ex: conversion de `Aircraft_Type` en `aircraft_model`).
    * **Couche Dimension** : Création de tables dimensionnelles agrégées : `dim_aircraft`, `dim_airports` et `dim_airlines`.
3.  **Analyse & Visualisation (Deepnote)** : Requêtage SQL final et création de visualisations pour l'Exploratory Data Analysis (EDA).

---

## 🛠️ Stack Technique
* **Base de données :** Snowflake.
* **Transformation :** dbt Cloud.
* **Analyse de données :** Deepnote.
* **Langage :** SQL (Jinja pour dbt).

---

## 📉 Modélisation des Données (dbt)

### 1. Couche Staging (`stg_`)
* **Normalisation** : Passage du format bruts vers une nomenclature snake_case et renommage métier (ex: `Departure_Airport_Code` devient `origin_airport_code`).
* **Nettoyage** : Utilisation de `try_to_date` pour sécuriser le formatage des dates et `coalesce` pour la gestion des valeurs nulles dans le résumé des vols.

### 2. Couche Dimension (`dim_`)
* **`dim_aircraft`** : Calcule le nombre total de vols par modèle d'avion via une jointure entre les tables aircraft et individual_flights.
* **`dim_airlines`** : Identifie les meilleures années par compagnie en utilisant la fonction `max_by` sur le trafic (RPM) et la croissance (ASM).
* **`dim_airports`** : Calcule le trafic passager total en additionnant les capacités des vols au départ et à l'arrivée via un `UNION ALL`.

---

## 📊 Résultats & Analyses (Deepnote)

### 1. Performance des Appareils
* **Question** : Quel avion a effectué le plus de vols ?
* **Insight** : Le modèle **Goose** est le plus utilisé avec **1 008 vols** répertoriés.

### 2. Hubs Aéroportuaires
* **Question** : Quel aéroport a transporté le plus de passagers ?
* **Insight** : L'aéroport **Amazon Mothership** arrive en tête avec **2 423 400 passagers** transportés.

### 3. Croissance des Compagnies
* **Question** : Quelle est la meilleure année de croissance par compagnie ?
* **Insight** : Pour **Amazon Airlines**, l'année 2013 est la plus performante tant en volume (RPM) qu'en croissance.

---

## ⚙️ Guide d'installation et Configuration

### 1. Configuration Snowflake
* Créez une base de données nommée `AIRCRAFTS` et un schéma `PUBLIC`.
* Chargez les fichiers sources dans les tables correspondantes définies dans le projet.

### 2. Configuration dbt
* Clonez ce repository.
* Configurez votre accès Snowflake dans dbt Cloud ou via un profil local.
* Installez les dépendances et lancez les transformations :
  ```bash
  dbt deps
  dbt run

### 3. Analyse dans Deepnote
* Connectez votre intégration Snowflake à votre projet Deepnote.
* Exécutez les requêtes SQL finales pour générer les visualisations et valider les insights à partir des modèles `dim_` créés.