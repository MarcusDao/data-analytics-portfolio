select *
From goals;
With ranked_goal as(
SELECT
    Dense_RANK() OVER (ORDER BY goals DESC) AS goal_rank,
    player_name,
    club,
    goals,
    match_played
FROM key_stats
ORDER BY goals DESC, player_name ASC
)
Select *
From ranked_goal
Where goal_rank <= 6;

SELECT *
FROM key_stats
WHERE club = 'Real Madrid';

USE ucl_2022;

CREATE TABLE real_madrid_master AS
SELECT
    -- Thông tin và thống kê tổng quan
    k.player_name,
    k.club,
    k.position,
    k.minutes_played,
    k.match_played,
    k.goals,
    k.assists,
    k.distance_covered,

    -- Tấn công
    a.corner_taken,
    a.offsides,
    a.dribbles,

    -- Dứt điểm
    att.total_attempts,
    att.on_target,
    att.off_target,
    att.blocked,

    -- Chi tiết bàn thắng
    g.right_foot,
    g.left_foot,
    g.headers,
    g.others AS other_goals,
    g.inside_area,
    g.outside_areas,
    g.penalties,
    g.match_played AS goals_source_match_played,

    -- Chuyền bóng
    dist.pass_accuracy,
    dist.pass_attempted,
    dist.pass_completed,
    dist.cross_accuracy,
    dist.cross_attempted,
    dist.cross_complted AS cross_completed,
    dist.freekicks_taken,

    -- Phòng ngự
    def.balls_recoverd AS balls_recovered,
    def.tackles,
    def.t_won AS tackles_won,
    def.t_lost AS tackles_lost,
    def.clearance_attempted,

    -- Kỷ luật
    disc.fouls_committed,
    disc.fouls_suffered,
    disc.red AS red_cards,
    disc.yellow AS yellow_cards,

    -- Thủ môn
    goalkeep.saved,
    goalkeep.conceded,
    goalkeep.saved_penalties,
    goalkeep.cleansheets,
    goalkeep.`punches made` AS punches_made

FROM key_stats AS k

LEFT JOIN attacking AS a
    ON k.player_name = a.player_name
    AND k.club = a.club

LEFT JOIN attempts AS att
    ON k.player_name = att.player_name
    AND k.club = att.club

LEFT JOIN goals AS g
    ON k.player_name = g.player_name
    AND k.club = g.club

LEFT JOIN distribution AS dist
    ON k.player_name = dist.player_name
    AND k.club = dist.club

LEFT JOIN defending AS def
    ON k.player_name = def.player_name
    AND k.club = def.club

LEFT JOIN disciplinary AS disc
    ON k.player_name = disc.player_name
    AND k.club = disc.club

LEFT JOIN goalkeeping AS goalkeep
    ON k.player_name = goalkeep.player_name
    AND k.club = goalkeep.club

WHERE k.club = 'Real Madrid';

Select * 
From real_madrid_master;

WITH ranked_players AS (
    SELECT
        player_name,
        goals,
        assists,
        goals + assists AS goal_contributions,
        RANK() OVER (
            ORDER BY goals + assists DESC
        ) AS contribution_rank
    FROM real_madrid_master
)
SELECT *
FROM ranked_players
WHERE contribution_rank = 1;

WITH ranked_defenders AS (
    SELECT
        player_name,
        position,
        minutes_played,
        balls_recovered,
        tackles_won,
        clearance_attempted,
        ROUND(
            balls_recovered * 90.0 / NULLIF(minutes_played, 0),
            2
        ) AS recoveries_per_90,
        RANK() OVER (
            ORDER BY
                balls_recovered * 90.0
                / NULLIF(minutes_played, 0) DESC
        ) AS recovery_rank
    FROM real_madrid_master
    WHERE minutes_played >= 450
      AND position <> 'Goalkeeper'
      AND balls_recovered IS NOT NULL
)
SELECT *
FROM ranked_defenders
WHERE recovery_rank = 1;

WITH midfield_playmakers AS (
    SELECT
        player_name,
        minutes_played,
        pass_completed,
        ROUND(
            pass_completed * 90.0 / NULLIF(minutes_played, 0),
            2
        ) AS completed_passes_per_90,
        ROUND(
            pass_completed * 100.0 / NULLIF(pass_attempted, 0),
            2
        ) AS pass_completion_pct,
        assists,
        RANK() OVER (
            ORDER BY
                pass_completed * 90.0
                / NULLIF(minutes_played, 0) DESC
        ) AS playmaker_rank
    FROM real_madrid_master
    WHERE position = 'Midfielder'
      AND minutes_played >= 450
      AND pass_completed IS NOT NULL
      AND pass_attempted > 0
)
SELECT *
FROM midfield_playmakers
WHERE playmaker_rank = 1;

WITH ranked_dribblers AS (
    SELECT
        player_name,
        position,
        minutes_played,
        dribbles,
        goals,
        assists,
        ROUND(
            dribbles * 90.0 / NULLIF(minutes_played, 0),
            2
        ) AS dribbles_per_90,
        RANK() OVER (
            ORDER BY
                dribbles * 90.0
                / NULLIF(minutes_played, 0) DESC
        ) AS dribble_rank
    FROM real_madrid_master
    WHERE minutes_played >= 450
      AND position <> 'Goalkeeper'
      AND dribbles IS NOT NULL
)
SELECT *
FROM ranked_dribblers
WHERE dribble_rank = 1;

WITH player_contributions AS (
    SELECT
        player_name,
        position,
        minutes_played,
        goals,
        assists,
        goals + assists AS goal_contributions,
        (goals + assists) * 90.0
            / NULLIF(minutes_played, 0) AS contributions_per_90
    FROM real_madrid_master
    WHERE minutes_played >= 450
      AND goals IS NOT NULL
      AND assists IS NOT NULL
),
ranked_players AS (
    SELECT
        *,
        RANK() OVER (
            ORDER BY
                goal_contributions DESC,
                contributions_per_90 DESC
        ) AS player_rank
    FROM player_contributions
)
SELECT
    player_rank,
    player_name,
    position,
    goals,
    assists,
    goal_contributions,
    ROUND(contributions_per_90, 2) AS contributions_per_90
FROM ranked_players
WHERE player_rank = 1;

WITH ranked_active_players AS (
    SELECT
        player_name,
        position,
        minutes_played,
        distance_covered,
        ROUND(
            distance_covered * 90.0 / NULLIF(minutes_played, 0),
            2
        ) AS distance_per_90,
        RANK() OVER (
            ORDER BY
                distance_covered * 90.0
                / NULLIF(minutes_played, 0) DESC
        ) AS activity_rank
    FROM real_madrid_master
    WHERE minutes_played >= 450
      AND position <> 'Goalkeeper'
      AND distance_covered IS NOT NULL
)
SELECT *
FROM ranked_active_players
WHERE activity_rank = 1;

