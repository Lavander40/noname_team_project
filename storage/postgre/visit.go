package postgre

import (
	"noname_team_project/model"
	"time"

	"github.com/lib/pq"
)

func (p *Postgre) GetVisitRate(studentArray, lessonsArray []int, date time.Time) ([]model.Rate, error) {
	var rates []model.Rate

	lessonsArray, err := p.FilterLessonByDate(lessonsArray, date)
	if err != nil {
		return nil, err
	}
	
	rows, err := p.conn.Query("SELECT students.id, (SELECT count(id) FROM attendances WHERE stud_id = students.id AND sched_id IN (SELECT id FROM schedules WHERE lesson_id = ANY($1)))/(SELECT count(id) FROM lessons WHERE id = ANY($1))::float AS score FROM students WHERE id = ANY($2) ORDER BY score ASC LIMIT 10;", pq.Array(lessonsArray), pq.Array(studentArray))
	if err != nil {
		return rates, err
	}
	defer rows.Close()

	for rows.Next(){
        rate := model.Rate{}
        err := rows.Scan(&rate.Id, &rate.Score)
        if err != nil{
            return rates, err
        }
        rates = append(rates, rate)
    }
	return rates, nil
}

func (p *Postgre) FilterLessonByDate(lessonsArray []int, date time.Time) ([]int, error) {
	var filteredArray []int

	rows, err := p.conn.Query("SELECT id FROM lessons WHERE id = ANY($1) AND date >= $2;", pq.Array(lessonsArray), pq.FormatTimestamp(date))
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	for rows.Next(){
		var id int
        err := rows.Scan(&id)
        if err != nil{
            return nil, err
        }
        filteredArray = append(filteredArray, id)
    }

	return filteredArray, nil
}
