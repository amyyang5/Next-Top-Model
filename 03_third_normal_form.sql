\c topmodelsql

CREATE TABLE category_agent(
    category_agent_id SERIAL PRIMARY KEY,
    category VARCHAR(30),
    agent VARCHAR(30)
);

INSERT INTO category_agent 
(category, agent) SELECT category, agent FROM models;



CREATE TABLE models_3
  AS (SELECT distinct(model_id), model_name, area, price_per_event, agent, trait, rating, next_event_date, revenue
      FROM models_2
      ORDER BY model_id ASC);

SELECT * FROM category_agent;
SELECT * FROM models_3;