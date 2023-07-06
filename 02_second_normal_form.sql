\c topmodelsql

CREATE TABLE brands
    AS (SELECT distinct(brand) FROM models_1);

ALTER TABLE brands
ADD brand_id SERIAL PRIMARY KEY;

CREATE TABLE brand_model
    AS (SELECT model_id, brand_id FROM models_1 
    JOIN brands ON models_1.brand = brands.brand);

ALTER TABLE brand_model
ADD brand_model_id SERIAL PRIMARY KEY;


CREATE TABLE models_2
  AS (SELECT distinct(model_id), model_name, area, price_per_event, category, agent, trait, rating, next_event_date, revenue
      FROM models_1
      ORDER BY model_id ASC);

SELECT * FROM brands;
SELECT * FROM brand_model;
SELECT * FROM models_2;