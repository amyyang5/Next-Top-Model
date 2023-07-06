\c topmodelsql

CREATE TABLE brands(
    brand_id SERIAL PRIMARY KEY,
    brand TEXT
);

INSERT INTO brands 
(brand) SELECT DISTINCT(brand) FROM models_1;

CREATE TABLE brand_model(
    brand_model_id SERIAL PRIMARY KEY,
    model_id INT,
    brand_id INT
);

INSERT INTO brand_model
(model_id, brand_id) SELECT model_id, brand_id FROM models_1
JOIN brands ON models_1.brand = brands.brand;


CREATE TABLE models_2
  AS (SELECT distinct(model_id), model_name, area, price_per_event, category, agent, trait, rating, next_event_date, revenue
      FROM models_1
      ORDER BY model_id ASC);

SELECT * FROM brands;
SELECT * FROM brand_model;
SELECT * FROM models_2;