-- Selection des colonnes depuis la table AIRPORTS
SELECT
    "Airport_Code" as airport_code,
    "Airport_Name" as airport_name,
    "Airport_Size" as airport_size,
    "Airport_Employees" as airport_employees
FROM 
    {{source('aircraft_db', 'AIRPORTS')}}