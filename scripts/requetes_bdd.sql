-- Nombre total de buts par joueurs
SELECT 
    j.nom_joueur, j.prenom_joueur,
    COUNT(m.id_rencontre) AS nb_buts
FROM JOUEUR j
LEFT JOIN marquer m ON j.id_joueur = m.id_joueur
GROUP BY j.id_joueur
ORDER BY nb_buts DESC;

-- Nombre total de cartons par joueur (jaunes et rouges)
SELECT 
    j.nom_joueur, j.prenom_joueur,
    SUM(CASE WHEN a.id_couleur = 1 THEN 1 ELSE 0 END) AS jaunes,
    SUM(CASE WHEN a.id_couleur = 2 THEN 1 ELSE 0 END) AS rouges,
    COUNT(a.id_rencontre) AS total_cartons
FROM JOUEUR j
LEFT JOIN avertir a ON j.id_joueur = a.id_joueur
GROUP BY j.id_joueur
ORDER BY total_cartons DESC;

-- Joueurs les plus blessés
SELECT 
    j.nom_joueur, j.prenom_joueur,
    COUNT(b.id_blessure) AS nb_blessures
FROM JOUEUR j
LEFT JOIN BLESSURE b ON j.id_joueur = b.id_joueur
GROUP BY j.id_joueur
ORDER BY nb_blessures DESC;

-- Joueurs avec la meilleure endurance / vitesse / force
SELECT nom_joueur, prenom_joueur, vitesse_joueur, endurance_joueur, force_joueur
FROM JOUEUR
ORDER BY endurance_joueur DESC, vitesse_joueur DESC, force_joueur DESC
LIMIT 10;

-- Nombre total de buts marqués par équipe
SELECT 
    e.nom_equipe,
    COUNT(m.id_joueur) AS nb_buts
FROM EQUIPE e
JOIN PERIODE p ON e.id_equipe = p.id_equipe
JOIN marquer m ON p.id_joueur = m.id_joueur
GROUP BY e.id_equipe
ORDER BY nb_buts DESC;

-- Nombre total de cartons par équipe
SELECT 
    e.nom_equipe,
    SUM(CASE WHEN a.id_couleur = 1 THEN 1 ELSE 0 END) AS jaunes,
    SUM(CASE WHEN a.id_couleur = 2 THEN 1 ELSE 0 END) AS rouges,
    COUNT(a.id_joueur) AS total_cartons
FROM EQUIPE e
JOIN PERIODE p ON e.id_equipe = p.id_equipe
LEFT JOIN avertir a ON p.id_joueur = a.id_joueur
GROUP BY e.id_equipe
ORDER BY total_cartons DESC;

-- Nombre de blessures par équipe
SELECT 
    e.nom_equipe,
    COUNT(b.id_blessure) AS nb_blessures
FROM EQUIPE e
JOIN PERIODE p ON e.id_equipe = p.id_equipe
LEFT JOIN BLESSURE b ON p.id_joueur = b.id_joueur
GROUP BY e.id_equipe
ORDER BY nb_blessures DESC;

-- Score final de chaque rencontre avec noms des équipes
SELECT 
    r.id_rencontre,
    e1.nom_equipe AS equipe_1,
    e2.nom_equipe AS equipe_2,
    SUM(CASE WHEN m.id_joueur BETWEEN 1 AND 15 THEN 1 ELSE 0 END) AS score_equipe_1,
    SUM(CASE WHEN m.id_joueur BETWEEN 16 AND 30 THEN 1 ELSE 0 END) AS score_equipe_2
FROM RENCONTRE r
JOIN EQUIPE e1 ON r.id_equipe = e1.id_equipe
JOIN EQUIPE e2 ON r.id_equipe_1 = e2.id_equipe
LEFT JOIN marquer m ON r.id_rencontre = m.id_rencontre
GROUP BY r.id_rencontre, e1.nom_equipe, e2.nom_equipe
ORDER BY r.id_rencontre;

-- Top 5 meilleurs buteurs avec leurs équipes
SELECT j.id_joueur, j.nom_joueur, j.prenom_joueur, e.nom_equipe, COUNT(m.id_rencontre) AS nb_buts
FROM JOUEUR j
JOIN PERIODE p ON j.id_joueur = p.id_joueur
JOIN EQUIPE e ON p.id_equipe = e.id_equipe
LEFT JOIN marquer m ON j.id_joueur = m.id_joueur
GROUP BY j.id_joueur, j.nom_joueur, j.prenom_joueur, e.nom_equipe
ORDER BY nb_buts DESC
LIMIT 5;

-- Classement simplifié (points par équipe)
SELECT nom_equipe,
       SUM(CASE 
             WHEN score_equipe > score_equipe_1 THEN 3
             WHEN score_equipe = score_equipe_1 THEN 1
             ELSE 0
           END) AS points
FROM (
    SELECT 
        r.id_rencontre,
        e1.nom_equipe,
        SUM(CASE WHEN m.id_joueur BETWEEN 1 AND 15 THEN 1 ELSE 0 END) AS score_equipe,
        SUM(CASE WHEN m.id_joueur BETWEEN 16 AND 30 THEN 1 ELSE 0 END) AS score_equipe_1
    FROM RENCONTRE r
    JOIN EQUIPE e1 ON r.id_equipe = e1.id_equipe
    LEFT JOIN marquer m ON r.id_rencontre = m.id_rencontre
    GROUP BY r.id_rencontre, e1.nom_equipe
) AS scores
GROUP BY nom_equipe
ORDER BY points DESC;

-- Classement complet pour un championnat et une saison
SELECT 
    s.libelle_saison,
    c.libelle_competition,
    e.nom_equipe,

    COUNT(r.id_rencontre) AS matchs_joues,

    -- Victoires
    SUM(
        CASE 
            WHEN r.id_equipe = e.id_equipe AND r.score_equipe_1 > r.score_equipe_2 THEN 1
            WHEN r.id_equipe_1 = e.id_equipe AND r.score_equipe_2 > r.score_equipe_1 THEN 1
            ELSE 0
        END
    ) AS victoires,

    -- Nuls
    SUM(
        CASE
            WHEN r.score_equipe_1 = r.score_equipe_2 THEN 1
            ELSE 0
        END
    ) AS nuls,

    -- Défaites
    SUM(
        CASE
            WHEN r.id_equipe = e.id_equipe AND r.score_equipe_1 < r.score_equipe_2 THEN 1
            WHEN r.id_equipe_1 = e.id_equipe AND r.score_equipe_2 < r.score_equipe_1 THEN 1
            ELSE 0
        END
    ) AS defaites,

    -- Buts pour
    SUM(
        CASE
            WHEN r.id_equipe = e.id_equipe THEN r.score_equipe_1
            ELSE r.score_equipe_2
        END
    ) AS buts_pour,

    -- Buts contre
    SUM(
        CASE
            WHEN r.id_equipe = e.id_equipe THEN r.score_equipe_2
            ELSE r.score_equipe_1
        END
    ) AS buts_contre,

    -- Goal average
    SUM(
        CASE
            WHEN r.id_equipe = e.id_equipe THEN r.score_equipe_1 - r.score_equipe_2
            ELSE r.score_equipe_2 - r.score_equipe_1
        END
    ) AS goal_average,

    -- Points
    SUM(
        CASE
            WHEN r.id_equipe = e.id_equipe AND r.score_equipe_1 > r.score_equipe_2 THEN 3
            WHEN r.id_equipe_1 = e.id_equipe AND r.score_equipe_2 > r.score_equipe_1 THEN 3
            WHEN r.score_equipe_1 = r.score_equipe_2 THEN 1
            ELSE 0
        END
    ) AS points

FROM EQUIPE e
JOIN RENCONTRE r 
    ON e.id_equipe = r.id_equipe 
    OR e.id_equipe = r.id_equipe_1
JOIN _composer comp 
    ON comp.id_journee = r.id_journee
JOIN SAISON s 
    ON comp.id_saison = s.id_saison
JOIN COMPETITION c 
    ON comp.id_competition = c.id_competition

WHERE s.libelle_saison = '2025-2026'
  AND c.libelle_competition = 'Ligue 1'

GROUP BY 
    s.libelle_saison,
    c.libelle_competition,
    e.nom_equipe

ORDER BY 
    points DESC,
    goal_average DESC,
    buts_pour DESC;


