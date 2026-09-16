# FitTrack - Gym Workout Logger
#### Video Demo:  <https://youtu.be/DmOy7hYQdZw>

#### Description:
FitTrack is a comprehensive, web-based application designed specifically for athletes, bodybuilders, and fitness enthusiasts to seamlessly track their daily workout routines, monitor their consistency, and log their training splits. Built entirely from scratch as my final project for Harvard's CS50x course, this application utilizes Python and the Flask framework for the backend logic, SQLite for robust database management, and a combination of HTML, CSS, and Bootstrap for a responsive, dark-themed user interface that is easy on the eyes.

As an engineering student who is deeply invested in strength training and follows structured programs like the Push-Pull-Legs and Arnold splits, I realized the need for a straightforward, distraction-free logging tool. Many existing applications are cluttered with unnecessary features or paywalls. FitTrack solves this problem by providing exactly what a lifter needs: a secure authentication system, a quick way to log the day's training split, specific exercises performed, and the duration of the session.

The project directory is structured meticulously to ensure clean architecture and scalability:
- **`app.py`**: This is the core controller of the application. It handles all routing, session management, and database interactions. I implemented user authentication mechanisms here, ensuring that routes like logging workouts or viewing history are strictly protected using a custom `@login_required` decorator. It processes GET and POST requests securely, hashes user passwords utilizing `werkzeug.security`, and communicates with the SQLite database via the CS50 SQL library.
- **`project.db`**: The SQLite database containing two primary tables: `users` and `workouts`. The `users` table safely stores usernames and hashed passwords. The `workouts` table acts as a relational schema, tied to the user via a foreign key (`user_id`), storing the exact split, the list of exercises, duration, and an auto-generated timestamp.
- **`templates/`**: This directory houses all the HTML views, leveraging Jinja syntax for dynamic rendering:
  - **`layout.html`**: The foundational template containing the HTML skeleton, Bootstrap CDN links, and a dynamic navigation bar that alters its state depending on whether the user is logged in or out.
  - **`register.html` & `login.html`**: The authentication interfaces that collect user credentials securely and return visual error messages if validation fails on the server side.
  - **`log.html`**: A user-friendly form featuring a dropdown menu for popular workout splits (e.g., Push, Pull, Legs, Arnold Chest/Back), alongside input fields for specific exercises (like Incline DB Press or Cable Flyes) and session duration.
  - **`index.html`**: The user dashboard. It dynamically iterates through the user's historical database records using Jinja loops, rendering a sleek, dark-themed table that chronologically displays all past gym sessions.

### Design Choices
When approaching the architecture of FitTrack, I deliberately chose Flask over heavier frameworks like Django. Because the scope of the project required a lightweight, agile approach, Flask provided the exact level of control needed over routing and session management without unnecessary boilerplate code. It allowed me to focus heavily on the backend logic and routing mechanisms taught throughout the course.

For the database, SQLite was selected due to its zero-configuration nature and seamless integration with Python via the CS50 SQL library. While a massive production environment might necessitate PostgreSQL or MySQL, SQLite is perfectly suited for a personal fitness tracking application where concurrent heavy write operations are minimal, and data structure remains relatively straightforward.

I decided against using a complex frontend JavaScript framework like React or Vue.js. Instead, I relied on server-side rendering using Jinja2 templates combined with Bootstrap 5. This decision was made to keep the project focused on robust backend data handling, secure session management, and relational database queries—core tenets of the CS50 curriculum. Using Bootstrap ensured the application is fully responsive, dark-themed, and accessible on mobile devices, which is critical for a gym environment where users typically log workouts directly on their smartphones.

Another major consideration was security. I utilized `werkzeug.security` to generate password hashes, ensuring that no plain-text credentials are ever stored in the database. Furthermore, the session is configured to use the local filesystem rather than signed cookies, preventing malicious users from tampering with their session data to spoof or access other accounts. Overall, these design choices resulted in a secure, efficient, and easily maintainable codebase that I can continue to expand in the future.
