WITH airports as (
    SELECT * FROM {{ ref('stg_airports') }}
),

-- Pour question 2 on calcule dans ce modèle directement le traffic
traffic_calculation as (
    SELECT 
        f.origin_airport_code,
        f.destination_airport_code,
        a.capacity
    FROM {{ ref('stg_individual_flights') }} f
    JOIN {{ ref('stg_aircraft') }} a on f.aircraft_id = a.aircraft_id
),

total_capacity_per_airport as (
    -- Il faut additionner les départs et les arrivées avec un UNION ALL pour avoir le total de passagers (total_pax)
    SELECT origin_airport_code as airport_code, sum(capacity) as total_pax
    FROM traffic_calculation GROUP BY 1
    
    UNION ALL
    
    SELECT destination_airport_code as airport_code, sum(capacity) as total_pax
    FROM traffic_calculation GROUP BY 1
),

final_aggregated_traffic as (
    SELECT 
        airport_code, 
        sum(total_pax) as total_passengers_transported
    FROM total_capacity_per_airport
    GROUP BY 1
)

SELECT 
    a.airport_code,
    a.airport_name,
    a.airport_size,
    coalesce(t.total_passengers_transported, 0) as total_passengers_transported
FROM airports a
LEFT JOIN final_aggregated_traffic t on a.airport_code = t.airport_code