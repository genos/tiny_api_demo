#!/usr/bin/env python

from flask import Flask, escape, jsonify, render_template
from data import NAMES, SELECT

app = Flask(__name__)


@app.route("/")
def home():
    return render_template("index.html", names=NAMES)


@app.route("/person/<string:name>")
def person(name):
    clean = escape(name)
    try:
        return render_template("person.html", name=clean, data=SELECT[clean], error=False)
    except KeyError:
        return render_template("person.html", name=clean, error=True), 400


@app.route("/api/<string:name>")
def api(name):
    clean = escape(name)
    try:
        return jsonify(SELECT[clean])
    except KeyError:
        return {"error": f"Unknown person {clean}"}, 400
