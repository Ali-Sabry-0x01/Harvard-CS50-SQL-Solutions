import os
from cs50 import SQL
from flask import Flask, redirect, render_template, request, session, flash
from flask_session import Session
from werkzeug.security import check_password_hash, generate_password_hash
from functools import wraps

app = Flask(__name__)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

db = SQL("sqlite:///project.db")

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if session.get("user_id") is None:
            return redirect("/login")
        return f(*args, **kwargs)
    return decorated_function

@app.route("/")
@login_required
def index():
    user_id = session["user_id"]
    workouts = db.execute("SELECT split, exercises, duration, timestamp FROM workouts WHERE user_id = ? ORDER BY timestamp DESC", user_id)
    return render_template("index.html", workouts=workouts)

@app.route("/log", methods=["GET", "POST"])
@login_required
def log_workout():
    if request.method == "POST":
        split = request.form.get("split")
        exercises = request.form.get("exercises")
        duration = request.form.get("duration")

        if not split or not exercises or not duration:
            flash("All fields are required!")
            return redirect("/log")

        db.execute("INSERT INTO workouts (user_id, split, exercises, duration) VALUES (?, ?, ?, ?)",
                   session["user_id"], split, exercises, duration)
        flash("Workout Logged Successfully!")
        return redirect("/")
    else:
        return render_template("log.html")

@app.route("/login", methods=["GET", "POST"])
def login():
    session.clear()
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")

        if not username or not password:
            return render_template("login.html", error="Provide username and password")

        rows = db.execute("SELECT * FROM users WHERE username = ?", username)
        if len(rows) != 1 or not check_password_hash(rows[0]["hash"], password):
            return render_template("login.html", error="Invalid credentials")

        session["user_id"] = rows[0]["id"]
        return redirect("/")
    return render_template("login.html")

@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")
        confirmation = request.form.get("confirmation")

        if not username or not password or password != confirmation:
            return render_template("register.html", error="Invalid input or passwords don't match")

        try:
            hash_pass = generate_password_hash(password)
            db.execute("INSERT INTO users (username, hash) VALUES (?, ?)", username, hash_pass)
            return redirect("/login")
        except ValueError:
            return render_template("register.html", error="Username exists")

    return render_template("register.html")

@app.route("/logout")
def logout():
    session.clear()
    return redirect("/")
