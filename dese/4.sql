SELECT "city", COUNT(name) AS "number of public schools" FROM "schools" WHERE "type" LIKE 'public school'
GROUP BY "city"
ORDER BY "number of public schools" DESC, "city" LIMIT 10;
