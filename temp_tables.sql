--Practice Example in using temporary tables in SQL (Temp tables)
--Example 1: Get the  count of trips that lasted more than an hour
WITH trips_over_1_hr AS(
  SELECT
    *
  FROM `bigquery-public-data.new_york.citibike_trips`
  WHERE
    tripduration >=60
)

SELECT
  COUNT(*) AS cout
FROM
  trips_over_1_hr;

--Exercise 2: Using the Austin Bikeshare dataset, determine the station from which the bike that lasts the longest frequently comes from.
WITH longest_used_bike AS(
  SELECT
    bikeid,
    SUM(duration_minutes) AS trip_duration
  FROM
    bigquery-public-data.austin_bikeshare.bikeshare_trips
  GROUP BY
    bikeid
  ORDER BY
    trip_duration DESC
  LIMIT 1
)

## Find the station from which the longest used bike leaves the most.
SELECT
  trips.start_station_id,
  COUNT(*) AS trip_ct
FROM
  longest_used_bike AS longest
INNER JOIN bigquery-public-data.austin_bikeshare.bikeshare_trips AS trips
ON longest.bikeid = trips.bikeid
GROUP BY
  trips.start_station_id
ORDER BY
  trip_ct DESC
LIMIT 1