# Design Notes and Ideas

## Widgets

Different sizes

## Profiles

For the most up to date data, we'd have to query the chess.com API for this view.

Lazy load the profiles with scroll. Also, they should be allowed to hold and drag these into different orders, so we'd have a sequence column on the DB.

**Streaks**

(This can come later on)

For the current/longest streak, we need to query for the current year's data, then use that with a combination of the historical data.

Perhaps we'll store historical data for profiles to make this quicker.

## Year View

We should validate that the username field is not empty.

If it's the current year, make a call to the chess.com API in order to fetch the data. This is so we get the most up to date data.

If it's a past year, we should check our DB if we already have the games for the given username for that year. If the result set is greater than 0, then we'd give the user that heatmap data instead of sending a request to chess.com:

```swift
import SQLite

let db = try Connection("path/to/database.sqlite")

let username = "johndoe"
let year = "2023"

let query = """
    SELECT *
    FROM players p
    JOIN game_player gp ON gp.player_id = p.id
    JOIN games g ON g.uuid = gp.game_id
    WHERE p.username = ? AND strftime('%Y', g.end_time) = ?
"""

let rows = try db.prepare(query, username, year)
for row in rows {
    // Process the results
}
```

If it's a past year, and the result set from the DB is of size 0, we don't have data for that given username. We will then query the chess.com API and then store the results in the DB and display the heatmap data.

## Compare Stats

We'll use the maximum number between both players as a basis for the shading of the squares across both heatmap views. Then, we just display both normally. Each square should be able to be tapped with a popup of the stats for that day.

We'll use the same logic for storing data as the "Year View."

## Settings

This will set a global variable for the color of the squares in the "Profiles", "Year View", and "Compare Stats" views.

We will allow the user to delete previous records to clear storage in settings.
