/*
Q1. Passenger Travel Profile Analysis

Business requirement:
The airline wants to understand its passenger profile across different customer segments and travel categories.
Prepare an analysis grouped by Customer Type, Type of Travel, and Class.

Calculate the following metrics:
1. Total number of passengers.
2. Average passenger age.
3. Average flight distance.
4. Average departure delay.
5. Average arrival delay.
Expected output columns:
Column	Description
Customer Type	Loyal or Disloyal
Type of Travel	Business or Personal
Class	Business, Eco or Eco Plus
Total Passengers	Number of passenger records
Average Age	Average passenger age
Average Flight Distance	Average distance
Average Departure Delay	Average departure delay in minutes
Average Arrival Delay	Average arrival delay in minutes

SQL concepts covered:
- GROUP BY
- COUNT, AVG
- Aggregate functions
- Handling NULL values
Important: AVG() automatically ignores NULL values. Therefore, the 83 missing arrival-delay values will not be included in the average arrival delay calculation.
*/

SELECT
    t.customer_type, 
    t.type_of_travel, 
    t.class,
    COUNT(t.id) AS Total_passengers,
    AVG(t.age) AS Average_age,
    AVG(t.flight_distance) AS Average_Flight_Distance,
    AVG(departure_delay_in_minutes) AS Average_departure_delay_in_minutes,
    AVG(arrival_delay_in_minutes) AS Average_arrival_delay_in_minutes
FROM project_2_Airline_Passenger_Satisfaction AS t
GROUP BY t.customer_type, t.type_of_travel, t.class
ORDER BY t.customer_type, t.type_of_travel, t.class;

/*
Q2. Service Quality Analysis by Travel Class
Compare the average ratings of all 11 service-related columns across Business, Eco, and Eco Plus classes.
Identify which class has the highest and lowest average ratings for each service.
For this question, let's first work with the original dataset alone. We don't need a supporting table for this analysis, 
so we'll keep the implementation straightforward.Share your SQL query when ready.
*/

SELECT
    t.class,
    AVG(t.inflight_wifi_service) AS avg_rating_inflight_wifi_service,
    AVG(t.departure_arrival_time_convenient) AS avg_rating_departure_arrival_time_convenient,
    AVG(t.ease_of_online_booking) AS avg_rating_ease_of_online_booking,
    AVG(t."Food_and_drink") AS avg_rating_food_and_drink,
    AVG(t.seat_comfort) AS avg_of_seat_comfort,
    AVG(t.inflight_entertainment) AS avg_of_inflight_entertainment,
    AVG(t.on_board_service) AS avg_of_on_board_service,
    AVG(t.leg_room_service) AS avg_of_leg_room_service,
    AVG(t.baggage_handling) AS avg_of_baggage_handling,
    AVG(t.cleanliness) AS avg_of_cleanliness
FROM project_2_Airline_Passenger_Satisfaction AS t
GROUP BY t.class

/*
Q3. Identifying Passengers with Above-Average Departure Delays
Business scenario:
The airline's operations team wants to identify passengers who experienced departure delays higher than the average departure delay for 
their respective travel classes.

Requirement:
Identify passengers whose departure delay is greater than the average departure delay of all passengers belonging to the same Class.

Your output should contain:
1. Passenger ID
2. Customer Type
3. Type of Travel
4. Class
5. Passenger's Departure Delay
6. Average Departure Delay for that Class
SQL concepts to practice:
- Correlated subqueries
- Aggregate functions
- Filtering using subqueries
Important clarification: Calculate the average separately for Business, Eco, and Eco Plus classes. Include only passengers whose departure delay is greater than their respective class average.
*/

SELECT
    t1.id AS "Passenger_id",
    t1.customer_type AS "Type of customer",
    t1.type_of_travel AS "Type of Travel",
    t1.class AS "Type of Class",
    t1.departure_delay_in_minutes AS "Passenger's Departure Delay"
FROM project_2_airline_passenger_satisfaction AS t1
WHERE t1.departure_delay_in_minutes > (
    SELECT AVG(t2.departure_delay_in_minutes) AS avg_of_departure_delay_in_minutes
    FROM project_2_airline_passenger_satisfaction AS t2
    WHERE t2.class = t1.class 
)
ORDER BY "Passenger_id" ASC;

/*
Q4. Service Performance Analysis by Travel Class
Business scenario:
The airline's service quality team wants to compare passenger ratings across travel classes and identify the best-performing class for each service.

Business requirement:
For each travel class, calculate the average rating for all 10 service-related columns. Then rank the three classes separately for each service, from highest average rating to lowest.

Your final output should contain:
1. Service name
2. Travel class
3. Average service rating
4. Rank of the travel class for that service
SQL concepts to practice:
- CTEs
- JOIN operations
- Window functions (DENSE_RANK)
- Aggregation

Important: Each service must be ranked independently. For example, the ranking for Wi-Fi should not affect the ranking for Seat Comfort.
You may need to transform the service-rating columns into rows before ranking them. Think about how to structure the data.
Try solving this yourself. I'll review your approach and provide hints only if needed.
*/

WITH avg_rating_calc AS (
    SELECT
        t.class,
        AVG(t.inflight_wifi_service) AS avg_rating_inflight_wifi_service,
        AVG(t.departure_arrival_time_convenient) AS avg_rating_departure_arrival_time_convenient,
        AVG(t.ease_of_online_booking) AS avg_rating_ease_of_online_booking,
        AVG(t."Food_and_drink") AS avg_rating_food_and_drink,
        AVG(t.seat_comfort) AS avg_of_seat_comfort,
        AVG(t.inflight_entertainment) AS avg_of_inflight_entertainment,
        AVG(t.on_board_service) AS avg_of_on_board_service,
        AVG(t.leg_room_service) AS avg_of_leg_room_service,
        AVG(t.baggage_handling) AS avg_of_baggage_handling,
        AVG(t.cleanliness) AS avg_of_cleanliness
    FROM project_2_airline_passenger_satisfaction AS t
    GROUP BY t.class
),

customize_dataframe AS (
    SELECT
        cte_1.class AS "class_type",
        'inflight_wifi_service' AS "services",
        cte_1.avg_rating_inflight_wifi_service AS Service_rating
    FROM avg_rating_calc AS cte_1

    UNION

    SELECT
        cte_1.class AS "class_type",
        'departure_arrival_time_convenient' AS "services",
        cte_1.avg_rating_departure_arrival_time_convenient AS Service_rating
    FROM avg_rating_calc AS cte_1

    UNION

    SELECT
        cte_1.class AS "class_type",
        'ease_of_online_booking' AS "services",
        cte_1.avg_rating_ease_of_online_booking AS Service_rating
    FROM avg_rating_calc AS cte_1

    UNION

    SELECT
        cte_1.class AS "class_type",
        'Food_and_drink' AS "services",
        cte_1.avg_rating_food_and_drink AS Service_rating
    FROM avg_rating_calc AS cte_1

    UNION

    SELECT
        cte_1.class AS "class_type",
        'seat_comfort' AS "services",
        cte_1.avg_of_seat_comfort AS Service_rating
    FROM avg_rating_calc AS cte_1

    UNION

    SELECT
        cte_1.class AS "class_type",
        'inflight_entertainment' AS "services",
        cte_1.avg_of_inflight_entertainment AS Service_rating
    FROM avg_rating_calc AS cte_1

    UNION

    SELECT
        cte_1.class AS "class_type",
        'on_board_service' AS "services",
        cte_1.avg_of_on_board_service AS Service_rating
    FROM avg_rating_calc AS cte_1

    UNION

    SELECT
        cte_1.class AS "class_type",
        'leg_room_service' AS "services",
        cte_1.avg_of_leg_room_service AS Service_rating
    FROM avg_rating_calc AS cte_1

    UNION

    SELECT
        cte_1.class AS "class_type",
        'baggage_handling' AS "services",
        cte_1.avg_of_baggage_handling AS Service_rating
    FROM avg_rating_calc AS cte_1

    UNION

    SELECT
        cte_1.class AS "class_type",
        'cleanliness' AS "services",
        cte_1.avg_of_cleanliness AS Service_rating
    FROM avg_rating_calc AS cte_1
),

service_ranking_calc AS (
    SELECT
        cte_2.class_type AS "class_type",
        services,
        Service_rating,
        DENSE_RANK() OVER (
            PARTITION BY services
            ORDER BY Service_rating DESC
        ) AS service_ranking
    FROM customize_dataframe AS cte_2
    ORDER BY "class_type", Services ASC
)

SELECT
    services,
    class_type,
    Service_rating,
    service_ranking
FROM service_ranking_calc
-- WHERE service_ranking <= 3
ORDER BY services ASC, service_ranking ASC;

/*
Q5. Analysis of Flight Delay Patterns

Business scenario:
The airline's operations team wants to understand how departure delays and arrival delays are related.

Business requirement:
Classify passengers into the following three groups:
1. Delayed at Both: Passengers who experienced both departure and arrival delays.
2. Departure Delay Only: Passengers who experienced a departure delay but no arrival delay.
3. Arrival Delay Only: Passengers who experienced an arrival delay but no departure delay.
Calculate the total number of passengers in each group.

SQL concepts to practice:
- CTEs
- Set operations: INTERSECT and EXCEPT
- Aggregation
- UNION ALL
Conditions:
- A delay greater than zero minutes is considered a delay.
- A delay of zero minutes means no delay.
- Records with NULL arrival delay should be excluded from these three groups because their arrival-delay status is unknown.
Expected output:
Delay Category	Total Passengers
Delayed at Both	Count
Departure Delay Only	Count
Arrival Delay Only	Count

This is our final business requirement. Try solving it independently. I'll review your query and approach.
*/

WITH delayed_at_both AS (
    SELECT
        id AS "Passenger_id"
    FROM project_2_airline_passenger_satisfaction AS t
    WHERE t.arrival_delay_in_minutes <> 0

    INTERSECT 

    SELECT
        id AS "Passenger_id"
    FROM project_2_airline_passenger_satisfaction AS t
    WHERE t.departure_delay_in_minutes <> 0
),

departure_delay_only AS (
    SELECT 
        id AS "Passenger_id"
    FROM project_2_airline_passenger_satisfaction AS t
    WHERE t.departure_delay_in_minutes <> 0 AND t.arrival_delay_in_minutes = 0
),

arrival_delay_only AS (
    SELECT 
        id AS "Passenger_id"
    FROM project_2_airline_passenger_satisfaction AS t
    WHERE t.arrival_delay_in_minutes <> 0 AND t.departure_delay_in_minutes = 0
),

merge_results AS (
    SELECT
        'delayed at both' AS "Delay Category",
        COUNT(*) AS "Total Passengers"
    FROM delayed_at_both

    UNION 

    SELECT 
        'departure delay only' AS "Delay Category",
        COUNT(*) AS "Total Passengers"
    FROM departure_delay_only

    UNION

    SELECT 
        'arrival delay only' AS "Delay Category",
        COUNT(*) AS "Total Passengers"
    FROM arrival_delay_only
)

SELECT
    "Delay Category",
    "Total Passengers"
FROM merge_results
ORDER BY "Delay Category" ASC;

/*
Q6. Class-wise Wi-Fi Service Target Achievement
Business scenario:

The airline's service quality team has established minimum average Wi-Fi rating targets for each travel class. They want to evaluate whether each class meets its target.

Business requirement:

Calculate the average Inflight wifi service rating for each travel class and compare it against the predefined target rating.

Classify each travel class as:
- Target Achieved: Actual average rating is greater than or equal to the target.
- Target Not Achieved: Actual average rating is below the target.
Supporting table
Create the following table in PostgreSQL:

Table name: class_wifi_targets_temp
Class	Target Average Rating
Business	4.0
Eco	3.0
Eco Plus	3.2

These are illustrative business targets created for this analysis, not values from the original dataset.
Expected output
Class	Total Passengers	Actual Average Rating	Target Rating	Target Status
Business	Count	Average	4.0	Achieved/Not Achieved
Eco	Count	Average	3.0	Achieved/Not Achieved
Eco Plus	Count	Average	3.2	Achieved/Not Achieved

SQL concepts to practice
- JOIN operations
- GROUP BY
- Aggregate functions
- CASE WHEN
Your task: First create the supporting table and insert the three records. Then write the query to satisfy the business requirement.
*/

CREATE TABLE class_wifi_targets_temp (
    class_type VARCHAR(50) NOT NULL,
    target_average_rating FLOAT NOT NULL
);

INSERT INTO class_wifi_targets_temp (class_type, target_average_rating)
VALUES
    ('Business', 4),
    ('Eco', 3),
    ('Eco Plus', 3.2)


WITH avg_rating_achieved_calc AS (
    SELECT
        p2.class,
        COUNT(id) AS "Total Passengers",
        AVG(p2.inflight_wifi_service) AS "Actual Average Rating"
    FROM project_2_airline_passenger_satisfaction AS p2
    GROUP BY p2.class
)

SELECT
    cte_1.class,
    cte_1."Total Passengers",
    cte_1."Actual Average Rating",
    wifi_table.target_average_rating AS "Target Rating",
    CASE 
        WHEN cte_1."Actual Average Rating" >= wifi_table.target_average_rating THEN 'Achieved'
        ELSE 'Not Achieved'
    END AS "Target Status"
FROM avg_rating_achieved_calc AS cte_1
INNER JOIN class_wifi_targets_temp AS wifi_table
    ON wifi_table.class_type = cte_1.class
ORDER BY cte_1.class ASC;

/*
Q7. Identifying and Ranking High-Delay Travel Categories
Business scenario:

The airline's operations team wants to identify travel categories experiencing higher-than-average arrival delays and prioritize them for operational improvement.

Business requirement:

Analyze passengers grouped by Type of Travel and Class.

Calculate:
1. Total number of passengers.
2. Average departure delay.
3. Average arrival delay.
Then:
- Identify combinations whose average arrival delay is greater than the overall average arrival delay across all passengers.
- Rank the qualifying combinations by average arrival delay, separately within each Type of Travel.
Expected output
Type of Travel	Class	Total Passengers	Avg Departure Delay	Avg Arrival Delay	Rank
Business Travel	Business	...	...	...	...
Business Travel	Eco	...	...	...	...
Personal Travel	Eco Plus	...	...	...	...

SQL concepts to practice
- GROUP BY
- Aggregate functions
- Subquery (overall average comparison)
- Window function (DENSE_RANK)
- Filtering
*/

WITH act_avg_rating_calc_filt AS (
    SELECT
        tab.type_of_travel AS "Type of travel",
        tab.class AS "Class",
        COUNT(id) AS "Total Passengers",
        AVG(tab.departure_delay_in_minutes) AS "Avg Depature Delay",
        AVG(tab.arrival_delay_in_minutes) AS "Avg Arrival Delay"
    FROM project_2_airline_passenger_satisfaction AS tab
    GROUP BY tab.type_of_travel, tab.class
    HAVING AVG(tab.arrival_delay_in_minutes) > (
        SELECT 
            AVG(sub_tab.arrival_delay_in_minutes) 
        FROM project_2_airline_passenger_satisfaction AS sub_tab
    )
)

SELECT
    cte."Type of travel" AS "Type of travel",
    cte."Class" AS "Class",
    cte."Total Passengers" AS "Total Passengers",
    cte."Avg Depature Delay" AS "Avg Depature Delay",
    cte."Avg Arrival Delay" AS "Avg Arrival Delay",
    DENSE_RANK() OVER (
        PARTITION BY "Type of travel"
        ORDER BY "Avg Arrival Delay" DESC
    ) AS "Rank"
FROM act_avg_rating_calc_filt AS cte;














