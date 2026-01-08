GET_RENCONTRES_QUERY = """
SELECT 
    r.id_rencontre,                         -- ID unique de la rencontre
    e1.nom_equipe AS equipe_domicile,       -- Nom de l'équipe à domicile
    e2.nom_equipe AS equipe_exterieur,      -- Nom de l'équipe à l'extérieur
    r.score_equipe_1 AS score_domicile,     -- Score de l'équipe à domicile
    r.score_equipe_2 AS score_exterieur     -- Score de l'équipe à l'extérieur
FROM RENCONTRE r
JOIN EQUIPE e1 ON r.id_equipe = e1.id_equipe       -- Récupère les infos de l'équipe à domicile
JOIN EQUIPE e2 ON r.id_equipe_1 = e2.id_equipe    -- Récupère les infos de l'équipe extérieure
ORDER BY r.id_rencontre;                           -- Trie les résultats par ID de rencontre
"""