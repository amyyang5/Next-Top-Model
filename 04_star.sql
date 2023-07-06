\c topmodelsql





-- FACTS
--  model id
--  price per event
--  rating
--  next event date
--  revenue



-- DIMENSIONS
--  model_name

CREATE TABLE model
    AS (SELECT model_id, model_name FROM models);

--  area
CREATE TABLE area(
    area_id SERIAL PRIMARY KEY,
    area VARCHAR(30)
);

INSERT INTO area (area)
SELECT area FROM models
RETURNING *;
        
--  category_agent [DONE]
--  brand [DONE]

--  trait
CREATE TABLE trait(
    trait_id SERIAL PRIMARY KEY,
    trait VARCHAR(30)
);

INSERT INTO trait (trait)
SELECT trait FROM models
RETURNING *;
      