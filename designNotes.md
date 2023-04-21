# Design Notes and Ideas

## Profiles

For the most up to date data, we'd have to query the chess.com API for this view.

We'd probably have to make a table in the DB to store which profiles we'd like on this view.

## Year View

If it's the current year, make a call to the chess.com API in order to fetch the data. This is so we get the most up to date data.

We should also validate that the username field is not empty.

If it's a past year, we should check our DB if we already have the games for the given username for that year. If the result set is greater than 0, then we'd give the user that heatmap data instead of sending a request to chess.com:

```sql
SELECT *
FROM players p
JOIN game_player gp ON gp.player_id = p.id
JOIN games g ON g.uuid = gp.game_id
WHERE p.username = ? AND strftime('%Y', g.end_time) = ?
```

If it's a past year, and the result set from the DB is of size 0, we don't have data for that given username. We will then query the chess.com API and then store the results in the DB and display the heatmap data.

After, we could probably display a list of stored users and years as a list. We can also allow the user to delete the stored data. It will get re-added if they query again.

## Compare Stats

We'll use the maximum number between both players as a basis for the shading of the squares across both heatmap views. Then, we just display both normally. Each square should be able to be tapped with a popup of the stats for that day.

We'll use the same logic for storing data as the "Year View."

## Theme

This will set a global variable for the color of the squares in the "Profiles", "Year View", and "Compare Stats" views.
