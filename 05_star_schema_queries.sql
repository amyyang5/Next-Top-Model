\c topmodelsql

-- agent with the lowest rated models
SELECT agent AS agent_with_lowest_rating FROM fact_models
JOIN dim_category_agent ON fact_models.category_agent_id = dim_category_agent.category_agent_id
ORDER BY rating ASC
LIMIT 1;

-- model who has worked on most events based on price per events and revenue 
SELECT model_name AS model_with_most_events FROM fact_models
JOIN dim_model ON fact_models.model_id = dim_model.model_id 
ORDER BY ROUND(revenue/price_per_event) DESC
LIMIT 1;





