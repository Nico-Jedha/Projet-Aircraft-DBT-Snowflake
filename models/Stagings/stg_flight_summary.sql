SELECT
    "Airline_Code" as airline_code,
    "Airport_Code" as airport_code,
    -- Extraction de l'année depuis la donnée "Date".
    -- Par sécurité, on demande un try_to_date pour forcer la reconnaissance du format date 
    year(try_to_date("Date")) as year,
    
    -- Gestion des NULLs (précaution si actualisation des tables avec des nulls) => On remplace par 0
    coalesce("RPM_Domestic", 0) as rpm_domestic,
    coalesce("RPM_International", 0) as rpm_international,
    coalesce("ASM_Domestic", 0) as asm_domestic,
    coalesce("ASM_International", 0) as asm_international,
    coalesce("Flights_Domestic", 0) as flights_domestic,
    coalesce("Flights_International", 0) as flights_international,
    coalesce("Passengers_Domestic", 0) as pax_domestic,
    coalesce("Passengers_International", 0) as pax_international
FROM
    {{ source('aircraft_db', 'FLIGHT_SUMMARY_DATA') }}