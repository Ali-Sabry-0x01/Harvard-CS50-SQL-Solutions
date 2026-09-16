SELECT year, SALARY
FROM salaries
WHERE player_id IN (
    SELECT id FROM players WHere
    first_name like 'Cal%' AND last_name LIKE 'Ripken%'
)
ORDER BY year DESC;
