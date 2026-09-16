# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

Adopting this approach ensures that the data storage and write loads are evenly distributed across all boats, preventing any single boat from being overwhelmed. However, a major downside is that querying data for a specific time range is highly inefficient, as the researcher must broadcast the query to all boats to find the relevant observations.

## Partitioning by Hour

The main advantage of this approach is that time-range queries are extremely efficient; querying for observations between midnight and 1am only requires searching Boat A. The reason not to adopt this approach is that it creates severe "hot spots"; since most observations occur between midnight and 1am, Boat A will be heavily overloaded with data and write requests while Boats B and C remain mostly idle.

## Partitioning by Hash Value

This approach effectively distributes the storage and write load evenly across all boats while also allowing instant, efficient lookups for a specific, exact timestamp. The drawback is that time-range queries remain inefficient, as sequential timestamps are scattered pseudo-randomly across all boats, requiring the researcher to query the entire network to gather a range of data.
