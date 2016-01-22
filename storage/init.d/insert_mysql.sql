INSERT INTO `personal` (`id`, `name`)
SELECT * FROM (SELECT 1, 'root@local') AS tmp
WHERE NOT EXISTS (
    SELECT `id` FROM `personal` WHERE `id` = 1
) LIMIT 1;
