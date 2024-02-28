package elastic

import (
	"encoding/json"
	"io"
	"strconv"
	"strings"
)

type EsResponse struct{
	Hits struct {
		Hits     []struct {
			ID     string  `json:"_id"`
		} `json:"hits"`
	} `json:"hits"`
}

func (e *Elastic) Init() error {
	return nil
}

func (e *Elastic) GetByPhrase(phrase string) ([]int, error) {
	var lectures EsResponse
	var lectureIds []int

	res, err := e.conn.Search(
		e.conn.Search.WithBody(strings.NewReader(`{
		  "query": {
			"query_string": {
				"query": "title:\"` + phrase + `\""
			}
		  }
		}`)),
		e.conn.Search.WithPretty(),
	)
	if err != nil {
		return nil, err
	}

	temp, err := io.ReadAll(res.Body)
	if err != nil {
		return nil, err
	}

	if err = json.Unmarshal(temp, &lectures); err != nil {
		return nil, err
	}

	for _, v := range lectures.Hits.Hits {
		id, err := strconv.Atoi(v.ID)
		if err != nil{
			return nil, err
		}

		lectureIds = append(lectureIds, id)
	}

	return lectureIds, nil
}
