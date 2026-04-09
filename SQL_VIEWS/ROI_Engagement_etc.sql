-- GAUMONT STRATEGIC VIEW
-- Goal: Automated Calculation of ROI and Audience Engagement

DROP VIEW IF EXISTS View_Gaumont_Business_Intelligence;

CREATE VIEW View_Gaumont_Business_Intelligence AS
SELECT 
    f.title,
    d.full_name AS director,
    d.popularity_score AS talent_notoriety,
    
    -- ROI calculation: (Revenue - Budget) / Budget
    ROUND(((f.total_revenue - f.production_budget) / f.production_budget), 2) AS ROI_Ratio,
    
    -- Engagement calculation: (Letterboxd Reviews / Tickets Sold) * 100
    ROUND((CAST(f.review_count AS REAL) / (SELECT SUM(tickets_sold) FROM Weekly_Entries WHERE film_id = f.film_id)) * 100, 2) AS Engagement_Rate,
    
    -- Financial Decision Label
    CASE 
        WHEN ((f.total_revenue - f.production_budget) / f.production_budget) > 3 THEN 'Blockbuster Hit'
        WHEN ((f.total_revenue - f.production_budget) / f.production_budget) > 0 THEN 'Profitable'
        ELSE 'Financial Risk'
    END AS financial_status

FROM Film f
JOIN Film_Direction fd ON f.film_id = fd.film_id
JOIN Director d ON fd.director_id = d.director_id;
