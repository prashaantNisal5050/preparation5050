-- type: 
-- category: complex
-- resource :ankit bansal



# If you write a query using NOT IN and the subquery returns a NULL, the whole NOT IN expression fails to match any row due to the way SQL handles NULL (as “unknown”).

SELECT * FROM runners WHERE id NOT IN(SELECT winner_id FROM races)
vs
SELECT * FROM runners WHERE id NOT IN(SELECT winner_id FROM races where winner_id is not null)
-----



