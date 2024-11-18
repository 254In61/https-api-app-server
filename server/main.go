package main

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/go-sql-driver/mysql" // Import the MySQL driver
)

func main() {
	// Define the database connection string
	// Format: "user:password@tcp(host:port)/dbname"
	dsn := "panther:panther2024@tcp(10.152.183.178:3306)/mydb"

	// Open a connection to the database
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		log.Fatalf("Error opening database: %v", err)
	}
	defer db.Close()

	// Verify the connection
	err = db.Ping()
	if err != nil {
		log.Fatalf("Error connecting to database: %v", err)
	}

	fmt.Println("Connected to the database successfully!")

	// Execute an SQL query
	query := "select * from countries"
	rows, err := db.Query(query, 18) // Replace 18 with the desired age filter
	if err != nil {
		log.Fatalf("Error executing query: %v", err)
	}
	defer rows.Close()

	// Iterate through the rows
	for rows.Next() {
		var id int
		var name string

		// Scan the columns into variables
		err := rows.Scan(&id, &name)
		if err != nil {
			log.Fatalf("Error scanning row: %v", err)
		}

		// Print the results
		fmt.Printf("ID: %d, Name: %s\n", id, name)
	}

	// Check for errors encountered during iteration
	if err = rows.Err(); err != nil {
		log.Fatalf("Error iterating over rows: %v", err)
	}
}
