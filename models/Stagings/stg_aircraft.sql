-- Etape de nettoyage des données brutes => staging : on normalise le nom des colonnes (ex:Type Aircraft => remplacer par modèle )
-- et on gère les types
SELECT 
    "Aircraft_Id" as aircraft_id, --Clé primaire !
    "Aircraft_Type" as aircraft_model, -- => Nom de l'avion
    "Capacity" as capacity,
    "Mass" as mass,
    "Length" as longueuraircraft,
    "Cost" as cost
FROM 
    -- Type de code Jinja source avec schema et nom de la table
    {{source('aircraft_db', 'AIRCRAFT')}}