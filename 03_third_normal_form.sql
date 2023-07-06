\c topmodelsql

CREATE TABLE category_agent
    AS (SELECT category, agent FROM models_2);

CREATE TABLE models_3
  AS (SELECT distinct(model_id), model_name, area, price_per_event, agent, trait, rating, next_event_date, revenue
      FROM models_2
      ORDER BY model_id ASC);

SELECT * FROM category_agent;
SELECT * FROM models_3;