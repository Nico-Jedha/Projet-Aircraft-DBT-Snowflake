-- Selection des colonnes depuis la table INDIVIDUAL_FLIGHTS
SELECT "Flight_Id" AS flight_id, 
        "Airline_Code" AS airline_code, 
        "Aircraft_Id" AS aircraft_id, --notre foreign key pour les joins !
        "Departure_Airport_Code" AS origin_airport_code,
        "Destination_Airport_Code" AS destination_airport_code
FROM 
    {{source('aircraft_db', 'INDIVIDUAL_FLIGHTS')}}