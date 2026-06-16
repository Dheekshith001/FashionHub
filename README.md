# FashionHub 🛍️

FashionHub is a full-stack e-commerce web application developed using Java Servlets, JSP, MySQL, and Apache Tomcat. The platform allows users to browse fashion products, search items, manage carts and wishlists, place orders, and manage their profiles.

## 📌 Project Overview

FashionHub is an e-commerce platform that allows users to explore fashion products, manage wishlists and carts, place orders, and track order history. The application follows the MVC architecture using Java Servlets, JSP, JDBC, and MySQL.

💼 Internship Experience

FashionHub was developed during my Full Stack Java Development internship as a real-world e-commerce application. Through this project, I gained practical experience in designing and developing web applications using Java Servlets, JSP, JDBC, MySQL, Apache Tomcat, and the MVC architecture.

The project involved implementing user authentication, product management, shopping cart functionality, wishlist management, order processing, database integration, and session management.

## ⭐ Key Highlights

- Built using MVC Architecture
- Java Servlets and JSP based web application
- MySQL database integration using JDBC
- Product images stored as BLOBs in MySQL
- Wishlist, Cart, Checkout, and Order Management modules
- Authentication and Session Management
- Maven-based project structure

## 🚀 Features

### User Features
- User Registration & Login
- Secure Authentication
- Browse Products by Category
- Product Search Functionality
- Product Details View
- Shopping Cart Management
- Wishlist Management
- Checkout System
- Order History Tracking
- User Profile Management
- Forgot Password Functionality

### Product Features
- Category-wise Product Display
- Subcategory Filtering
- Dynamic Product Loading
- Product Images Stored in MySQL Database (BLOB)

### Order Features
- Place Orders
- View Order Details
- Order History
- Order Status Tracking

---

## 🛠️ Tech Stack

### Frontend
- HTML5
- CSS3
- JavaScript
- JSP (Java Server Pages)

### Backend
- Java Servlets
- JDBC

### Database
- MySQL

### Server
- Apache Tomcat

### Build Tool
- Maven

---

## 📂 Project Structure

```text
FashionHub
│
├── src/main/java
│   ├── controller
│   ├── dao
│   ├── model
│   ├── filter
│   └── util
│
├── src/main/webapp
│   ├── customer
│   ├── css
│   ├── js
│   ├── images
│   ├── uploads
│   └── WEB-INF
│
├── pom.xml
├── fashionhub.sql
└── Dockerfile
```

---

## 🗄️ Database

Database Name:

```sql
fashionhub
```

Main Tables:

- users
- products
- categories
- subcategories
- cart
- wishlist
- orders
- order_items
- search_history
- forgot_password

Product images are stored directly in MySQL using the BLOB data type.

---

## ⚙️ Setup Instructions

### Prerequisites

- Java JDK 21
- Apache Tomcat
- MySQL Server
- Maven
- Eclipse IDE / VS Code

### Clone Repository

```bash
git clone https://github.com/Dheekshith001/FashionHub.git
```

### Database Setup

Create database:

```sql
CREATE DATABASE fashionhub;
```

Import:

```bash
mysql -u root -p fashionhub < fashionhub.sql
```

### Configure Database Connection

Update:

```java
src/main/java/com/fashionhub/util/DBConnection.java
```

Example:

```java
connection = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/fashionhub",
    "root",
    "root"
);
```

### Run Application

1. Import project into Eclipse or VS Code.
2. Configure Apache Tomcat.
3. Deploy project.
4. Start Tomcat Server.

Open:

```text
http://localhost:8080/FashionHub/home
```

---

## 📸 Screenshots

### Home Page
<img width="1896" height="1078" alt="Screenshot 2026-06-16 193103" src="https://github.com/user-attachments/assets/f3f9644d-079f-43b9-8558-4829c9998833" />


### Products Page
<img width="1918" height="1078" alt="Screenshot 2026-06-16 193138" src="https://github.com/user-attachments/assets/5d0d0530-2401-47d7-b835-fcabf6fcc7d9" />


### Product Details
<img width="1918" height="1078" alt="Screenshot 2026-06-16 193149" src="https://github.com/user-attachments/assets/78cd5d9e-1c08-40e5-90f4-3288f452d7cf" />


### Cart
<img width="1918" height="1078" alt="Screenshot 2026-06-16 193211" src="https://github.com/user-attachments/assets/c786ef6a-d1ca-4dc8-86c1-a6a4d7a002f8" />


### Wishlist
<img width="1918" height="1078" alt="Screenshot 2026-06-16 193235" src="https://github.com/user-attachments/assets/126d0545-6723-4ce4-a0c8-b9f53f0aca80" />


### Checkout
<img width="1918" height="1078" alt="Screenshot 2026-06-16 193245" src="https://github.com/user-attachments/assets/4742a558-f6ed-4a8e-b9d8-7ec9e9745229" />


### Orders
<img width="1918" height="1078" alt="Screenshot 2026-06-16 193253" src="https://github.com/user-attachments/assets/44d7447e-27b1-436b-a19a-a735d8dc5302" />


---
## 🎥 Demo Video

### Application Demo
🔗 [Watch FashionHub Demo](https://drive.google.com/file/d/1GKgX09T0P6zkcA790Z2hiiAvy7YjB4YA/view)

### Database Demo
🔗 [Watch Database Demo](https://drive.google.com/file/d/1lVGqiLRdDFN1thddudz6oXsgNoW8Zz_H/view)




## 🔮 Future Enhancements

- Online Payment Gateway Integration
- Admin Dashboard
- Product Reviews & Ratings
- Email Notifications
- Responsive Mobile UI
- Product Recommendation System
- Cloud Deployment

---

## 👨‍💻 Developer

Muthuluri Dheekshith

Aspiring Java Full Stack Developer

GitHub: [Dheekshith001](https://github.com/Dheekshith001)

LinkedIn: [dheekshithm](https://www.linkedin.com/in/dheekshithm)

---

📜 License

This project was developed as part of a Full Stack Java Development internship and serves as a demonstration of practical software development skills, including Java Servlets, JSP, JDBC, MySQL, MVC architecture, and e-commerce application development.

© 2025 Muthuluri Dheekshith. All rights reserved.
