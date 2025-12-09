%sql
SELECT
  Disease,
  COUNT(*) AS patient_count
FROM final_exam_cluster.default.clean_healthcare
GROUP BY Disease
ORDER BY patient_count DESC

%sql
SELECT
  age_group,
  AVG(Symptom_count) AS avg_symptom_count
FROM final_exam_cluster.default.clean_healthcare
GROUP BY age_group
ORDER BY avg_symptom_count DESC
