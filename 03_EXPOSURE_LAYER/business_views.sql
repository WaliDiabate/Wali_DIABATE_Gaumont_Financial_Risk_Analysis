-- ==========================================
-- 03 - EXPOSURE LAYER
-- Objectif : Transformer les données brutes en indicateurs décisionnels
-- ==========================================

CREATE VIEW View_Gaumont_Business_Intelligence AS
SELECT 
    f.title,
    d.full_name AS main_director,
    f.production_budget,
    f.total_revenue,
    
    -- 1. Calcul du ROI (Indicateur financier pur)
    ((f.total_revenue - f.production_budget) / f.production_budget) AS ROI_Ratio,
    
    -- 2. Calcul du Taux d'Engagement (Notoriété vs Entrées)
    (CAST(f.review_count AS REAL) / NULLIF((SELECT SUM(tickets_sold) FROM Weekly_Entries WHERE film_id = f.film_id), 0)) * 100 AS Engagement_Rate,
    
    -- 3. Statut Décisionnel (Logique métier)
    CASE 
        WHEN ((f.total_revenue - f.production_budget) / f.production_budget) > 3 THEN 'Blockbuster Hit'
        WHEN ((f.total_revenue - f.production_budget) / f.production_budget) > 0 THEN 'Profitable'
        ELSE 'Financial Risk'
    END AS financial_status

FROM Film f
-- On rejoint la table de liaison pour avoir les noms des réalisateurs
LEFT JOIN Film_Direction fd ON f.film_id = fd.film_id
LEFT JOIN Director d ON fd.director_id = d.director_id;
