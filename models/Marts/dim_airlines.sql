-- Ici réponse à la question sur les meilleures années directement dans le dim_

WITH airlines as (
    SELECT * FROM {{ ref('stg_airlines') }}
),

summary_stats as (
    SELECT 
        airline_code,
        year,
        (rpm_domestic + rpm_international) as total_rpm,
        asm_domestic as asm_growth_metric
    FROM {{ ref('stg_flight_summary') }}
    WHERE year is not null
),

best_years as (
    SELECT 
        airline_code,
        -- Astuce Snowflake (proposée par IA...)pour éviter des fonctions de fenêtre complexes si on veut faire simple :
        -- => On prend l'année qui correspond au max de la valeur
        max_by(year, total_rpm) as best_year_rpm,
        max_by(year, asm_growth_metric) as best_year_growth
    FROM summary_stats
    GROUP BY 1
)

SELECT 
    a.airline_code,
    a.airline_name,
    b.best_year_rpm,
    b.best_year_growth
FROM airlines a
LEFT JOIN best_years b on a.airline_code = b.airline_code