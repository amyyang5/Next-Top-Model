\c topmodelsql

\echo '\n 3.1. Agent with the lowest rated models'

SELECT agent AS agent_with_lowest_rating FROM fact_models
JOIN dim_category_agent ON fact_models.category_agent_id = dim_category_agent.category_agent_id
ORDER BY rating ASC
LIMIT 1;

\echo '\n 3.2. model who has worked on most events based on price per events and revenue'

SELECT model_name AS model_with_most_events FROM fact_models
JOIN dim_model ON fact_models.model_id = dim_model.model_id 
ORDER BY ROUND(revenue/price_per_event) DESC
LIMIT 1;

\echo '\n 3.3. which quarter is the busiest for our models?'
CREATE TABLE busiest_quarter AS (
SELECT next_event_quarter AS quarter FROM fact_models
JOIN dim_next_event_dates ON fact_models.next_event_date_id = dim_next_event_dates.next_event_date_id
GROUP BY next_event_quarter
ORDER BY COUNT(next_event_quarter) DESC
LIMIT 1
);

SELECT * FROM busiest_quarter;

\echo '\n 3.4. what is the total revenue for that quarter?'
SELECT ROUND(SUM(revenue)) AS total_revenue FROM fact_models
JOIN dim_next_event_dates ON fact_models.next_event_date_id = dim_next_event_dates.next_event_date_id
WHERE next_event_quarter = (SELECT quarter FROM busiest_quarter);


\echo '\n 3.5. which category brings in the most revenue?'
SELECT category, ROUND(SUM(revenue)) AS total_revenue FROM fact_models
JOIN dim_category_agent ON fact_models.category_agent_id = dim_category_agent.category_agent_id
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 1;

\echo '\n 3.6. How many brands are represented by models from London'
SELECT SUM(array_length(brands, 1)) AS number_of_brands FROM fact_models
JOIN dim_area ON fact_models.area_id = dim_area.area_id
JOIN dim_brand_combination ON fact_models.brand_combination_id = dim_brand_combination.brand_combination_id
WHERE area = 'London';



\echo '\n 3.7. How much does it cost to hire all models that are represented by Paul & Rose'
WITH paul_rose_models_cost AS (
    SELECT agent, ROUND(SUM(price_per_event)) cost_to_hire_all_models FROM fact_models
    JOIN dim_category_agent ON fact_models.category_agent_id = dim_category_agent.category_agent_id
    WHERE agent = 'Rose' OR agent = 'Paul'
    GROUP BY agent
)

SELECT SUM(cost_to_hire_all_models) AS total_cost FROM paul_rose_models_cost;

\echo '\n 3.8. Which agent works with the most number of brands'
SELECT agent, SUM(array_length(brands, 1)) AS no_of_brands FROM fact_models
JOIN dim_category_agent ON fact_models.category_agent_id = dim_category_agent.category_agent_id
JOIN dim_brand_combination ON fact_models.brand_combination_id = dim_brand_combination.brand_combination_id
GROUP BY agent
ORDER BY no_of_brands DESC
LIMIT 2;