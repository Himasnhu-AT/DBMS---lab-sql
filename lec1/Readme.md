# make dB

Create docker instance: 

```yml
version: '3.8'
services:
  db:
    image: mysql:latest
    container_name: floe
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: lab
      MYSQL_USER: user
      MYSQL_PASSWORD: password
    ports:
      - 3306:3306
    volumes:
      - ./data:/var/lib/mysql
```

Create SQL command:

```SQL
CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);
```


