// запрос 1 (создаем все узлы)
CREATE (:Lecture {id_lecture: 1})
CREATE (:Lecture {id_lecture: 2})
CREATE (:Lecture {id_lecture: 3})
CREATE (:Lecture {id_lecture: 4})
CREATE (:Lecture {id_lecture: 5})
CREATE (:Lecture {id_lecture: 6})
CREATE (:Lecture {id_lecture: 7})
CREATE (:Lecture {id_lecture: 8})

CREATE (:Lesson {id_lesson: 1, id_lecture: 1})
CREATE (:Lesson {id_lesson: 2, id_lecture: 2})
CREATE (:Lesson {id_lesson: 3, id_lecture: 3})
CREATE (:Lesson {id_lesson: 4, id_lecture: 4})
CREATE (:Lesson {id_lesson: 5, id_lecture: 5})
CREATE (:Lesson {id_lesson: 6, id_lecture: 6})
CREATE (:Lesson {id_lesson: 7, id_lecture: 7})
CREATE (:Lesson {id_lesson: 8, id_lecture: 8})

CREATE (:Schedule {id_schedule: 1, id_lesson: 1, id_group: 1})
CREATE (:Schedule {id_schedule: 2, id_lesson: 2, id_group: 1})
CREATE (:Schedule {id_schedule: 3, id_lesson: 3, id_group: 1})
CREATE (:Schedule {id_schedule: 4, id_lesson: 4, id_group: 1})
CREATE (:Schedule {id_schedule: 5, id_lesson: 5, id_group: 1})
CREATE (:Schedule {id_schedule: 6, id_lesson: 6, id_group: 1})
CREATE (:Schedule {id_schedule: 7, id_lesson: 7, id_group: 1})
CREATE (:Schedule {id_schedule: 8, id_lesson: 8, id_group: 1})

CREATE (:Schedule {id_schedule: 9, id_lesson: 1, id_group: 2})
CREATE (:Schedule {id_schedule: 10, id_lesson: 2, id_group: 2})
CREATE (:Schedule {id_schedule: 11, id_lesson: 3, id_group: 2})
CREATE (:Schedule {id_schedule: 12, id_lesson: 4, id_group: 2})
CREATE (:Schedule {id_schedule: 13, id_lesson: 5, id_group: 2})
CREATE (:Schedule {id_schedule: 14, id_lesson: 6, id_group: 2})
CREATE (:Schedule {id_schedule: 15, id_lesson: 7, id_group: 2})
CREATE (:Schedule {id_schedule: 16, id_lesson: 8, id_group: 2})

CREATE (:Schedule {id_schedule: 17, id_lesson: 1, id_group: 3})
CREATE (:Schedule {id_schedule: 18, id_lesson: 2, id_group: 3})
CREATE (:Schedule {id_schedule: 19, id_lesson: 3, id_group: 3})
CREATE (:Schedule {id_schedule: 20, id_lesson: 4, id_group: 3})
CREATE (:Schedule {id_schedule: 21, id_lesson: 5, id_group: 3})
CREATE (:Schedule {id_schedule: 22, id_lesson: 6, id_group: 3})
CREATE (:Schedule {id_schedule: 23, id_lesson: 7, id_group: 3})
CREATE (:Schedule {id_schedule: 24, id_lesson: 8, id_group: 3})

CREATE (:Group {id_group: 1})
CREATE (:Group {id_group: 2})
CREATE (:Group {id_group: 3})

CREATE (:Student {id_student: 1, group_id: 1})
CREATE (:Student {id_student: 2, group_id: 1})
CREATE (:Student {id_student: 3, group_id: 1})
CREATE (:Student {id_student: 4, group_id: 1})
CREATE (:Student {id_student: 5, group_id: 1})
CREATE (:Student {id_student: 6, group_id: 1})

CREATE (:Student {id_student: 7, group_id: 2})
CREATE (:Student {id_student: 8, group_id: 2})
CREATE (:Student {id_student: 9, group_id: 2})
CREATE (:Student {id_student: 10, group_id: 2})
CREATE (:Student {id_student: 11, group_id: 2})
CREATE (:Student {id_student: 12, group_id: 2})

CREATE (:Student {id_student: 13, group_id: 3})
CREATE (:Student {id_student: 14, group_id: 3})
CREATE (:Student {id_student: 15, group_id: 3})
CREATE (:Student {id_student: 16, group_id: 3})
CREATE (:Student {id_student: 17, group_id: 3})
CREATE (:Student {id_student: 18, group_id: 3})

/ запрос 2 (создаем связи между лекциями и занятиями)
MATCH (lec:Lecture), (l:Lesson) 
WHERE lec.id_lecture = l.id_lecture
CREATE (lec)-[:A]->(l)

//запрос 3 (создаем узлы между занятиями и расписанием)
MATCH (l:Lesson), (s:Schedule)
WHERE l.id_lesson = s.id_lesson
CREATE (s)-[:B]->(l)

//запрос 4 (создаем узлы между расписанием и группами)
MATCH (s:Schedule), (g:Group)
WHERE s.id_group = g.id_group
CREATE (s)-[:C]->(g)

//запрос 5 (создаем узлы между группами и студентами)
MATCH (s:Student), (g:Group)
WHERE s.id_student <= 6
AND g.id_group = 1
CREATE (g)-[:D]->(s)

//запрос 6 (создаем узлы между группами и студентами)
MATCH (s:Student), (g:Group)
WHERE s.id_student > 6 AND s.id_student <= 12
AND g.id_group = 2
CREATE (g)-[:D]->(s)

//запрос 7 (создаем узлы между группами и студентами)
MATCH (s:Student), (g:Group)
WHERE s.id_student > 12
AND g.id_group = 3
CREATE (g)-[:D]->(s)
