package server

import (
	"encoding/json"
	"fmt"
	"net/http"
	"time"
)

type EsRequest struct {
	Phrase string `json:"phrase"`
	Date   time.Time `json:"date"`
}

func (s *Server) handleLab1() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var esReq EsRequest

		err := json.NewDecoder(r.Body).Decode(&esReq)
		if err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			return
		}

		fmt.Println("json pass")

		lectureList, err := s.storage.Elastic.GetByPhrase(esReq.Phrase)
		if err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			return
		}

		fmt.Println("elastic pass")

		studentArray, lessonsArray, err := s.storage.Neo4j.GetVisited(lectureList)
		if err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			return
		}

		fmt.Println("neo pass")

		visitRate, err := s.storage.Postgre.GetVisitRate(studentArray, lessonsArray, esReq.Date)
		if err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			return
		}

		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(visitRate)
	}
}
