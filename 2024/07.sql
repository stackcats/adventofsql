SELECT
    t1.elf_id,
    t2.elf_id,
    t1.primary_skill
FROM (SELECT
          primary_skill,
          elf_id
      FROM (SELECT
                primary_skill,
                elf_id,
                years_experience,
                RANK() OVER (PARTITION BY primary_skill ORDER BY years_experience DESC, elf_id) r
            FROM workshop_elves) t
      WHERE r = 1) t1
         LEFT JOIN
     (SELECT
          primary_skill,
          elf_id
      FROM (SELECT
                primary_skill,
                elf_id,
                RANK() OVER (PARTITION BY primary_skill ORDER BY years_experience, elf_id) r
            FROM workshop_elves) t
      WHERE r = 1) t2
     ON t1.primary_skill = t2.primary_skill
ORDER BY t1.primary_skill
LIMIT 3;
