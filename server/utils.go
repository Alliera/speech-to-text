package server

import (
	"math/rand"
	"time"
)

func RandomString(n int) string {
	r := rand.New(rand.NewSource(time.Now().UnixNano()))
	var letters = []rune("abcdghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

	b := make([]rune, n)
	for i := range b {
		b[i] = letters[r.Intn(len(letters))]
	}
	return string(b)
}
