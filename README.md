# https-api-app-server
Building https-server to handle https requests using GoLang

# Project structure

## Overview
REF : https://medium.com/@smart_byte_labs/organize-like-a-pro-a-simple-guide-to-go-project-folder-structures-e85e9c1769c2

Refers to how we organize our files and directories within a project. 
This organization acts like a roadmap, helping developers maintain, navigate, and scale their projects by clearly 
separating different parts, like concerns, modules, and functionalities.

A smart folder structure makes your development process smoother and helps your project thrive!

Having a well-organized folder structure is really important for a few key reasons:
1. Separation of Layers: 
   - It keeps different parts of your project — like business logic, data access, and API handling — in their own folders. 
   - This way, developers can focus on specific areas without feeling overwhelmed or confused.

2. Better Organization: 
   - By neatly sorting your code and its dependencies, larger projects become a lot easier to navigate. 
   - You’ll always know where to find what you need!

3. Reusability: 
   - A good structure lets you create components or packages that you can use in different parts of the project, saving you time and effort.

4. Easier Maintenance: 
   - When everyone follows a consistent folder setup, it’s much simpler to find and update code. 
   - This leads to better long-term management of the project.

5. Modularity: 
   - An effective folder structure encourages modular design, making it easier to add new features as your project grows.

## modular structure
- I have adopted a modular structure for this project.
- This allows :

1) Microservices: Ideal for applications built on microservices architecture, where different teams can work independently on separate modules.
2) Decoupling and Scalability: Encourages a clear separation of concerns, allowing each module to be developed, tested, and deployed independently.
3) Independent Dependency Management: Each module can have its own go.mod file, facilitating separate management of dependencies and reducing conflicts between modules. 
4) Adapters: Adapters (e.g., for databases, APIs, and messaging) can be easily swapped out without impacting the core logic. 
   This facilitates testing and refactoring, as the core can be tested in isolation from external dependencies.
5) Testability: Since the core logic is decoupled from the infrastructure, it is easier to write unit tests for the domain and application layers.

Example:
project/
├── user_module/                  # User module
│   ├── handler/                    # Handlers for user-related requests
│   ├── service/                    # Business logic for user operations
│   ├── repository/                 # Data access layer for user data
│   ├── user.go                     # User model definition
│   ├── go.mod                      # User module Go module definition
│   └── go.sum                      # User module Go module checksum file
├── product_module/               # Product module
│   ├── handler/                    # Handlers for product-related requests
│   ├── service/                    # Business logic for product operations
│   ├── repository/                 # Data access layer for product data
│   ├── product.go                  # Product model definition
│   ├── go.mod                      # Product module Go module definition
│   └── go.sum                      # Product module Go module checksum file
├── api_gateway/                  # API gateway to manage different services
│   ├── main.go                     # Main entry point for API gateway
│   ├── go.mod                      # API gateway Go module definition
│   └── go.sum                      # API gateway Go module checksum file
└── configs/                      # Shared configuration files


# db
- REF db/mysql/README.md

# modules installation and use
> Go modules for this project are :
  a) db querry
  b) client https requests

> Modules are within /server/modules

1. Initialize Go Modules : 
   $ cd server
   $ go mod init server

   go: creating new go.mod: module server
   go: to add module requirements and sums:
	go mod tidy

   - A file, go.mod ( Go module definition) is created.
   
   $ cat go.mod 
     module server

     go 1.18


2. Install the required package
   - In this case it is the github.com/go-sql-driver/mysql package
   
   $ go get -u github.com/go-sql-driver/mysql
   go: added filippo.io/edwards25519 v1.1.0
   go: added github.com/go-sql-driver/mysql v1.8.1

   - Your go.mod will be updated.

   $ cat go.mod 
   module server

   go 1.18

   require (
	   filippo.io/edwards25519 v1.1.0 // indirect
	   github.com/go-sql-driver/mysql v1.8.1 // indirect
   )
