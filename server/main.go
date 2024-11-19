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
	// use sql.Open to connect to our database.
	// This will return either db or an err that we can handle.
	db, err := sql.Open("mysql", dsn)
	
    // if there is an error opening the connection, handle it
    if err != nil {
        panic(err.Error())
    }

	// defer the close till after the main function has finished executing
    defer db.Close()

	// Verify the connection
	err = db.Ping()
	if err != nil {
		log.Fatalf("Error connecting to database: %v", err)
	}

	fmt.Println("Connected to the database successfully!")

	// Execute an SQL query
	// db.Query(sql) allows us to perform any SQL command we so desire. 
	// We can simply construct the query string and pass it in as a parameter
	query := "select * from countries"

    // perform a db.Query
	// This will return either the data or an err that we can handle.
	rows, err := db.Query(query) // Replace 18 with the desired age filter

	if err != nil {
		log.Fatalf("Error executing query: %v", err)
	}
	defer rows.Close()

	fmt.Println(rows)

	// // Iterate through the rows
	// for rows.Next() {
	// 	var id int
	// 	var name string

	// 	// Scan the columns into variables
	// 	err := rows.Scan(&id, &name)
	// 	if err != nil {
	// 		log.Fatalf("Error scanning row: %v", err)
	// 	}

	// 	// Print the results
	// 	fmt.Printf("ID: %d, Name: %s\n", id, name)
	// }

	// // Check for errors encountered during iteration
	// if err = rows.Err(); err != nil {
	// 	log.Fatalf("Error iterating over rows: %v", err)
	// }
}
