\c topmodelsql

CREATE TABLE models_1
  AS (SELECT model_id, model_name, area, price_per_event, category, agent, UNNEST(STRING_TO_ARRAY(brand, ', ')) AS brand, trait, rating, next_event_date, revenue
      FROM models);

SELECT * FROM models_1;