\c topmodelsql

-- DIMENSIONS
--  model_name
CREATE TABLE dim_model
    AS (SELECT model_id, model_name FROM models);

--  area
CREATE TABLE dim_area(
    area_id SERIAL PRIMARY KEY,
    area VARCHAR(30)
);

INSERT INTO dim_area (area)
SELECT DISTINCT(area) as area FROM models
RETURNING *;
        
--  category_agent [DONE]
CREATE TABLE dim_category_agent(
    category_agent_id SERIAL PRIMARY KEY,
    category VARCHAR(30),
    agent VARCHAR(30)
);

INSERT INTO dim_category_agent 
(category, agent) SELECT DISTINCT(category) as category, agent FROM models
RETURNING *;

--  brand [DONE]
CREATE TABLE dim_brands(
    brand_id SERIAL PRIMARY KEY,
    brand TEXT
);

INSERT INTO dim_brands 
(brand) SELECT DISTINCT(brand) as brand FROM models_1
RETURNING *;

-- brand model
CREATE TABLE dim_brand_combination(
    brand_combination_id SERIAL PRIMARY KEY,
    brands TEXT ARRAY,
    model_id INT
);

INSERT INTO dim_brand_combination
(brands, model_id)
SELECT (STRING_TO_ARRAY(brand, ', ')) AS brands, model_id
FROM models
RETURNING *;

--  trait
CREATE TABLE dim_traits(
    trait_id SERIAL PRIMARY KEY,
    trait VARCHAR(30)
);

INSERT INTO dim_traits (trait)
SELECT trait FROM models
RETURNING *;

-- date
CREATE TABLE dim_next_event_dates(
    next_event_date_id DATE,
    next_event_day_of_month INT,
    next_event_week_day VARCHAR,
    next_event_month INT,
    next_event_year INT
);

INSERT INTO dim_next_event_dates 
(next_event_date_id, next_event_day_of_month, next_event_week_day, next_event_month,  next_event_year) 
SELECT DISTINCT(next_event_date), DATE_PART('DAY', next_event_date), TO_CHAR(next_event_date, 'Day'), DATE_PART('MONTH',next_event_date), DATE_PART('YEAR',next_event_date) FROM models
RETURNING *;

SELECT model_id, model_name, (STRING_TO_ARRAY(brand, ', ')) AS brand, trait, rating, next_event_date, revenue
      FROM models;

-- FACTS
CREATE TABLE fact_models
  AS (
    SELECT models.model_id, area_id, price_per_event, category_agent_id, brand_combination_id, trait_id, rating, next_event_date_id, revenue FROM models
    JOIN dim_area ON models.area = dim_area.area
    JOIN dim_category_agent ON models.agent = dim_category_agent.agent
    JOIN dim_brand_combination ON models.model_id = dim_brand_combination.model_id
    JOIN dim_traits ON models.trait = dim_traits.trait 
    JOIN dim_next_event_dates ON models.next_event_date = dim_next_event_dates.next_event_date_id 
    );

SELECT * FROM fact_models;
