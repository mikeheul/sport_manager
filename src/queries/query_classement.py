GET_CLASSEMENT_QUERY = """
SELECT 
    e.nom_equipe,  -- Nom de l'équipe
    COUNT(r.id_rencontre) AS matchs,  -- Nombre de matchs joués

    -- Calcul des victoires : 1 point si l'équipe gagne à domicile ou à l'extérieur
    SUM(
        CASE
            WHEN r.id_equipe = e.id_equipe AND r.score_equipe_1 > r.score_equipe_2 THEN 1
            WHEN r.id_equipe_1 = e.id_equipe AND r.score_equipe_2 > r.score_equipe_1 THEN 1
            ELSE 0
        END
    ) AS victoires,

    -- Calcul des matchs nuls
    SUM(
        CASE WHEN r.score_equipe_1 = r.score_equipe_2 THEN 1 ELSE 0 END
    ) AS nuls,

    -- Calcul des défaites
    SUM(
        CASE
            WHEN r.id_equipe = e.id_equipe AND r.score_equipe_1 < r.score_equipe_2 THEN 1
            WHEN r.id_equipe_1 = e.id_equipe AND r.score_equipe_2 < r.score_equipe_1 THEN 1
            ELSE 0
        END
    ) AS defaites,

    -- Calcul des buts marqués
    SUM(
        CASE WHEN r.id_equipe = e.id_equipe THEN r.score_equipe_1 ELSE r.score_equipe_2 END
    ) AS buts_pour,

    -- Calcul des buts encaissés
    SUM(
        CASE WHEN r.id_equipe = e.id_equipe THEN r.score_equipe_2 ELSE r.score_equipe_1 END
    ) AS buts_contre,

    -- Calcul du goal average (différence de buts)
    SUM(
        CASE
            WHEN r.id_equipe = e.id_equipe THEN r.score_equipe_1 - r.score_equipe_2
            ELSE r.score_equipe_2 - r.score_equipe_1
        END
    ) AS goal_average,

    -- Calcul des points : 3 points pour une victoire, 1 pour un match nul, 0 pour une défaite
    SUM(
        CASE
            WHEN r.id_equipe = e.id_equipe AND r.score_equipe_1 > r.score_equipe_2 THEN 3
            WHEN r.id_equipe_1 = e.id_equipe AND r.score_equipe_2 > r.score_equipe_1 THEN 3
            WHEN r.score_equipe_1 = r.score_equipe_2 THEN 1
            ELSE 0
        END
    ) AS points

FROM EQUIPE e
JOIN RENCONTRE r ON e.id_equipe = r.id_equipe OR e.id_equipe = r.id_equipe_1  -- Lier chaque équipe à ses matchs
JOIN _composer comp ON comp.id_journee = r.id_journee                        -- Lier les rencontres à la saison et compétition
JOIN SAISON s ON comp.id_saison = s.id_saison
JOIN COMPETITION c ON comp.id_competition = c.id_competition
WHERE s.libelle_saison = '2025-2026'             -- Filtrer sur la saison 2025-2026
  AND c.libelle_competition = 'Ligue 1'          -- Filtrer sur la compétition Ligue 1
GROUP BY e.nom_equipe                              -- Regrouper les résultats par équipe
ORDER BY points DESC, goal_average DESC;          -- Trier : points décroissants, puis goal average
"""