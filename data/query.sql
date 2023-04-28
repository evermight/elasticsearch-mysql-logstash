SELECT project.project_id, project.project_name,
JSON_ARRAYAGG(
  JSON_OBJECT(
    'project_id', epic.project_id, 'epic_id', epic.epic_id, 'epic_name', epic.epic_name,
    'stories', (
      SELECT JSON_ARRAYAGG(
        JSON_OBJECT(
          'epic_id', story.epic_id, 'story_id', story.story_id, 'story_name', story.story_name,
          'tasks', (
             SELECT JSON_ARRAYAGG(
                 JSON_OBJECT('story_id', task.story_id, 'task_id', task.task_id, 'task_name', task.task_name,
                 'hours', (
                 SELECT JSON_ARRAYAGG(JSON_OBJECT('task_id', time.task_id, 'user_id', time.user_id, 'hours', time.hours))
                 FROM time
                 WHERE time.task_id = task.task_id
                )
              )
            )
            FROM task
            WHERE task.story_id = story.story_id
          )
        )
      ) FROM story
    WHERE story.epic_id = epic.epic_id
    )
  )
) AS epics
FROM project
INNER JOIN epic ON epic.project_id = project.project_id
GROUP BY project.project_id;
