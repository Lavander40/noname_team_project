// Создание узлов для студентов
CREATE (:Student {id_student: 1})
CREATE (:Student {id_student: 2})
CREATE (:Student {id_student: 3})
CREATE (:Student {id_student: 4})
CREATE (:Student {id_student: 5})
CREATE (:Student {id_student: 6})
CREATE (:Student {id_student: 7})
CREATE (:Student {id_student: 8})
CREATE (:Student {id_student: 9})
CREATE (:Student {id_student: 10})
CREATE (:Student {id_student: 11})
CREATE (:Student {id_student: 12})
CREATE (:Student {id_student: 13})
CREATE (:Student {id_student: 14})
CREATE (:Student {id_student: 15})
CREATE (:Student {id_student: 16})
CREATE (:Student {id_student: 17})
CREATE (:Student {id_student: 18})

// Создание узлов для групп
CREATE (:Group {id_group: 1})
CREATE (:Group {id_group: 2})
CREATE (:Group {id_group: 3})

// Создание узлов для занятий
CREATE (:Lesson {id_lesson: 1})
CREATE (:Lesson {id_lesson: 2})
CREATE (:Lesson {id_lesson: 3})

// Создание узлов для расписаний
CREATE (:Schedule {id_schedule: 1})
CREATE (:Schedule {id_schedule: 2})
CREATE (:Schedule {id_schedule: 3})
CREATE (:Schedule {id_schedule: 4})
CREATE (:Schedule {id_schedule: 5})
CREATE (:Schedule {id_schedule: 6})
CREATE (:Schedule {id_schedule: 7})
CREATE (:Schedule {id_schedule: 8})

//Создание узлов для лекций
CREATE (:Lecture {id_lecture: 1})
CREATE (:Lecture {id_lecture: 2})
CREATE (:Lecture {id_lecture: 3})
CREATE (:Lecture {id_lecture: 4})
CREATE (:Lecture {id_lecture: 5})
CREATE (:Lecture {id_lecture: 6})
CREATE (:Lecture {id_lecture: 7})
CREATE (:Lecture {id_lecture: 8})

// Создание отношений между узлами
MATCH (s:Student), (g:Group)
WHERE s.id_student <= 6
AND g.id_group = 1
CREATE (s)-[:BELONGS_TO]->(g)

MATCH (s:Student), (g:Group)
WHERE s.id_student > 6 AND s.id_student <= 12
AND g.id_group = 2
CREATE (s)-[:BELONGS_TO]->(g)

MATCH (s:Student), (g:Group)
WHERE s.id_student > 12
AND g.id_group = 3
CREATE (s)-[:BELONGS_TO]->(g)

MATCH (l:Lesson), (s:Schedule)
WHERE l.id_lesson = s.id_schedule
CREATE (s)-[:INCLUDES]->(l)

MATCH (lec:Lecture), (l:Lesson)
WHERE lec.id_lecture = l.id_lesson
CREATE (lec)-[:INCLUDES]->(l)

MATCH (s:Schedule), (g:Group)
WHERE s.id_schedule = g.id_group
CREATE (s)-[:ASSIGNED_TO]->(g)