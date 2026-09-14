<div align="center">

# Repartout

### Maintenance Management Web Application

A Spring Boot web application designed to manage clients, machines  
and technical intervention requests within a structured maintenance workflow.

<br/>

<img src="https://img.shields.io/badge/Java-B77C95?style=for-the-badge&logo=openjdk&logoColor=white"/>
<img src="https://img.shields.io/badge/Spring%20Boot-B7CEB7?style=for-the-badge&logo=springboot&logoColor=white"/>
<img src="https://img.shields.io/badge/Spring%20Security-C5A8D8?style=for-the-badge&logo=springsecurity&logoColor=white"/>
<img src="https://img.shields.io/badge/JPA%20%2F%20Hibernate-A9C6E3?style=for-the-badge&logo=hibernate&logoColor=white"/>

</div>

<br/>

---

## About the Project

**Repartout** is a web application developed with **Spring Boot** as part of a Computer Engineering academic project.

The application provides a structured solution for managing clients, machines and technical intervention requests while applying the main concepts of enterprise Java web development.

The project was designed to put into practice layered application architecture, the MVC pattern, data persistence and application security.

---

## Features

### Client Management

The application provides functionality for managing client information and maintaining the data required for technical service operations.

### Machine Management

Machines can be registered and managed within the system, allowing technical equipment to be associated with the corresponding information.

### Intervention Management

Technical intervention requests can be managed and tracked through the application.

The system centralizes information related to clients, machines and maintenance operations.

### Authentication & Security

Access to the application is secured using **Spring Security**, providing controlled access to application functionality.

---

## Tech Stack

<div align="center">

| Technology | Usage |
|:---:|---|
| **Java** | Backend development |
| **Spring Boot** | Application framework |
| **Spring MVC** | Web architecture |
| **Spring Security** | Authentication and security |
| **JPA / Hibernate** | Data persistence |
| **JSP** | Server-side user interface |
| **Maven** | Dependency and build management |

</div>

---

## Application Architecture

The application follows a layered architecture based on the MVC pattern.

```text
Application
│
├── Controllers
│       ↓
├── Services
│       ↓
├── Repositories
│       ↓
└── Entities / Database

Views
└── JSP
```

The main responsibilities are separated as follows:

**Controllers**  
Handle HTTP requests and communication between the user interface and application services.

**Services**  
Contain the business logic of the application.

**Repositories**  
Manage database access through JPA and Hibernate.

**Entities**  
Represent the main business objects and persistent data.

**JSP Views**  
Provide the web interface displayed to the user.

---

## Project Objectives

This project was developed to apply and strengthen concepts related to:

- Java enterprise application development
- Spring Boot application architecture
- MVC design pattern
- Business logic organization
- Data persistence with JPA / Hibernate
- Web application security with Spring Security
- Server-side web development with JSP

---

## Running the Project

The application can be started using Maven:

```bash
mvn spring-boot:run
```

> The complete source code is maintained in a private repository.  
> This public repository is intended to present the project's architecture, technologies and main features as part of my software engineering portfolio.

---

## Author

<div align="center">

**Najat ID Raho**

Computer Engineering Student — ENIAD

<br/>

<a href="https://www.linkedin.com/in/najat-id-raho-b05a25360/">
  <img src="https://img.shields.io/badge/LinkedIn-8FAFD1?style=for-the-badge&logo=linkedin&logoColor=white"/>
</a>

<a href="https://github.com/najatidraho12-oss">
  <img src="https://img.shields.io/badge/GitHub-C5A8D8?style=for-the-badge&logo=github&logoColor=white"/>
</a>

</div>
