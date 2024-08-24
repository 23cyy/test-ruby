# 🚀 Ruby WEBrick App

## 📝 Description

This project is a simple Ruby web application using **WEBrick** as the HTTP server, **MySQL** for the database, and **ERB** for rendering views. The application allows a user to log in, enter personal information, and view a list of users with their professional information.

## 📁 File structure

- **`app.rb`**: The heart of the application, defining the routes for authentication, entering personal information, and displaying the user list.
  
- **`login.erb`**: View for the login page, with a form for entering login and password.

- **`information.erb`**: View for the personal information entry page, where the user can enter first name, last name, email, and profession.

- **`list.erb`**: View that displays the list of users with their professional information in a simple format.

## 🚀 How to launch the project

1. Make sure you have Ruby, WEBrick, and the `mysql2` gem installed:
   ```bash
   gem install webrick mysql2
   ```

2. Start the server with the command :
   ```bash
   ruby app.rb
   ```

3. Access the application via your browser at: [http://localhost:3003/login](http://localhost:3003/login).

---
