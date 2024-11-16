# mysql db
- Build mysql instance in k8s cluster.
- Deploy sample db and table.
- expose service to external world.

# query db from application server
- golang code to do mysql query
- A function with input of query string.
- Query string formed at main() function
- query code a package that can be imported and tested independently

# http handler function
- Define routes and associate them with handler functions.
- Example:
    - Route "/" → Function to serve "Hello, HTTPS!"
    - Route "/secure" → Function for secure content.
- Serves client with web page showing query results

# client side
- Simple code/script run from client end to do http querry.
- Use containers to simulate different remote http querry