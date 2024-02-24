package neo4j

import (
	"fmt"
	"strconv"

	"github.com/neo4j/neo4j-go-driver/v5/neo4j"
)

func (n *Neo4j) GetVisited(lectures []int) ([]int, []int, error) {
	var lessons, students []int

	var itemsInterface []interface{}
    for _, item := range lectures {
        itemsInterface = append(itemsInterface, item)
    }

	fmt.Println("interface pass")

	result, err := neo4j.ExecuteQuery(n.context, n.conn,
		`MATCH (l:Lesson) 
		WHERE l.id_lecture IN $lectures 
		WITH l.id_lesson AS lessonId 
		MATCH (s:Schedule) 
		WHERE lessonId = s.id_lesson 
		WITH lessonId, s.id_group AS groupsId
		MATCH (g:Group) 
		WHERE groupsId = g.id_group 
		WITH lessonId, g.id_group AS newGroupsId
		MATCH (s:Student)
		WHERE s.group_id = newGroupsId
		RETURN lessonId, s.id_student AS studentsID`,
		map[string]interface{}{
            "lectures": itemsInterface,
        }, neo4j.EagerResultTransformer,
		neo4j.ExecuteQueryWithDatabase("graph"))
		if err != nil {
			return nil, nil, err
		}
		
		fmt.Println("search pass")

		for _, record := range result.Records {
			l, _ := record.Get("l")
			lid, _ := strconv.Atoi(l.(string))
			lessons = append(lessons, lid)

			s, _ := record.Get("s")
			sid, _ := strconv.Atoi(s.(string))
			students = append(students, sid)
		}

	return lessons, students, nil
}