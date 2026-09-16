SELECT english_title AS "Print Name", entropy
FROM views
WHERE artist = 'Hokusai' AND entropy > 7
ORDER BY entropy DESC;
