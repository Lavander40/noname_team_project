package elastic

import (
	"encoding/json"
	"fmt"
	"io"
	"noname_team_project/model"
	"strconv"
	"strings"

	"github.com/elastic/go-elasticsearch/v8/esutil"
)

type EsResponse struct{
	Hits struct {
		Hits     []struct {
			ID     string  `json:"_id"`
		} `json:"hits"`
	} `json:"hits"`
}

func (e *Elastic) Init() error {
	jlec, _ := json.Marshal(model.Lection{Title: "Основы квантовой механики"})
	res, err := e.conn.Index("lectures", esutil.NewJSONReader(jlec), e.conn.Index.WithDocumentID("1"))
	fmt.Print(res)
	if err != nil {
		return err
	}
	
	jlec, _ = json.Marshal(model.Lection{Title: "Основы проектирования распределённых систем"})
	res, err = e.conn.Index("lectures", esutil.NewJSONReader(jlec), e.conn.Index.WithDocumentID("2"))
	fmt.Print(res)
	if err != nil {
		return err
	}
	
	jlec, _ = json.Marshal(model.Lection{Title: "Эксплуатация распределённых систем"})
	res, err = e.conn.Index("lectures", esutil.NewJSONReader(jlec), e.conn.Index.WithDocumentID("3"))
	fmt.Print(res)
	if err != nil {
		return err
	}

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
