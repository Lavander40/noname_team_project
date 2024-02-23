// Создание узлов для студентов
CREATE (:Student {id_student: 1, full_name: 'Vladimir'})
CREATE (:Student {id_student: 2, full_name: 'Vladislav'})
CREATE (:Student {id_student: 3, full_name: 'Victor'})
CREATE (:Student {id_student: 4, full_name: 'Vyacheslav'})
CREATE (:Student {id_student: 5, full_name: 'Valeriy'})
CREATE (:Student {id_student: 6, full_name: 'Viniamin'})
CREATE (:Student {id_student: 7, full_name: 'Dmitriy'})
CREATE (:Student {id_student: 8, full_name: 'Denis'})
CREATE (:Student {id_student: 9, full_name: 'David'})
CREATE (:Student {id_student: 10, full_name: 'Dementiy'})
CREATE (:Student {id_student: 11, full_name: 'Sergey'})
CREATE (:Student {id_student: 12, full_name: 'Nikolay'})

// Создание узлов для групп
CREATE (:Group {id_group: 1})
CREATE (:Group {id_group: 2})

// Создание узлов для занятий
CREATE (:Lesson {id_lesson: 1, typing: 'лекция', date: datetime()})
CREATE (:Lesson {id_lesson: 2, typing: 'лекция', date: datetime()})
CREATE (:Lesson {id_lesson: 3, typing: 'лекция', date: datetime()})

// Создание узлов для расписаний
CREATE (:Schedule {id_schedule: 1})
CREATE (:Schedule {id_schedule: 2})
CREATE (:Schedule {id_schedule: 3})

// Создание отношений между узлами
MATCH (s:Student), (g:Group)
WHERE s.id_student <= 6
AND g.id_group = 1
CREATE (s)-[:BELONGS_TO]->(g)

MATCH (s:Student), (g:Group)
WHERE s.id_student > 6
AND g.id_group = 2
CREATE (s)-[:BELONGS_TO]->(g)

MATCH (l:Lesson), (s:Schedule)
WHERE l.id_lesson = s.id_schedule
CREATE (s)-[:INCLUDES]->(l)

MATCH (s:Schedule), (g:Group)
WHERE s.id_schedule = g.id_group
CREATE (s)-[:ASSIGNED_TO]->(g)

// Создание узлов для студентов
CREATE (:Student {id_student: 1, full_name: 'Vladimir'})
CREATE (:Student {id_student: 2, full_name: 'Vladislav'})
CREATE (:Student {id_student: 3, full_name: 'Victor'})
CREATE (:Student {id_student: 4, full_name: 'Vyacheslav'})
CREATE (:Student {id_student: 5, full_name: 'Valeriy'})
CREATE (:Student {id_student: 6, full_name: 'Viniamin'})
CREATE (:Student {id_student: 7, full_name: 'Dmitriy'})
CREATE (:Student {id_student: 8, full_name: 'Denis'})
CREATE (:Student {id_student: 9, full_name: 'David'})
CREATE (:Student {id_student: 10, full_name: 'Dementiy'})
CREATE (:Student {id_student: 11, full_name: 'Sergey'})
CREATE (:Student {id_student: 12, full_name: 'Nikolay'})

// Создание узлов для групп
CREATE (:Group {id_group: 1})
CREATE (:Group {id_group: 2})

// Создание узлов для занятий
CREATE (:Lesson {id_lesson: 1, typing: 'лекция', date: datetime()})
CREATE (:Lesson {id_lesson: 2, typing: 'лекция', date: datetime()})
CREATE (:Lesson {id_lesson: 3, typing: 'лекция', date: datetime()})

// Создание узлов для расписаний
CREATE (:Schedule {id_schedule: 1})
CREATE (:Schedule {id_schedule: 2})
CREATE (:Schedule {id_schedule: 3})

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
WHERE s.id_student > 6
AND g.id_group = 2
CREATE (s)-[:BELONGS_TO]->(g)

MATCH (l:Lesson), (s:Schedule)
WHERE l.id_lesson = s.id_schedule
CREATE (s)-[:INCLUDES]->(l)

MATCH (lec:Lecture), (l:Lesson)
WHERE lec.id_lecture = l.id_Lesson
CREATE (lec)-[:INCLUDES]->(l)

MATCH (s:Schedule), (g:Group)
WHERE s.id_schedule = g.id_group
CREATE (s)-[:ASSIGNED_TO]->(g)