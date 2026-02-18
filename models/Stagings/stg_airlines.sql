-- Selection des colonnes depuis la table AIRLINES
SELECT 
    "Airline_Code" as airline_code,
    "Airline_Name" as airline_name,
    "Description" as description
FROM 
    {{source('aircraft_db', 'AIRLINES')}}