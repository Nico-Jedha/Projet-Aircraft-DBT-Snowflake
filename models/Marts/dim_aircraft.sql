-- On calcule le nombre de vols directement dans ce modèle dim_aircraft
WITH aircraft as (
    select * from {{ ref('stg_aircraft') }}
),

flight_counts as (
    -- Nombre de vols calculés ici :
    SELECT 
        aircraft_id,
        count(*) as total_flights
    FROM {{ ref('stg_individual_flights') }}
    GROUP BY 1
)

SELECT 
    a.aircraft_id,
    a.aircraft_model,
    a.capacity,
    -- Et join avec le calcul fait au dessus du nb de vols
    coalesce(f.total_flights, 0) as number_of_flights
FROM aircraft a
LEFT JOIN flight_counts f on a.aircraft_id = f.aircraft_id