from flask import Flask, render_template
#from flask_bootstrap import Bootstrap
from flask_mysqldb import MySQL
import yaml

app = Flask(__name__)
#Bootstrap(app)

# Configure db using settings in db.yaml file
db = yaml.load(open('db.yaml'))
app.config['MYSQL_HOST'] = db['mysql_host']
app.config['MYSQL_USER'] = db['mysql_user']
app.config['MYSQL_PASSWORD'] = db['mysql_password']
app.config['MYSQL_DB'] = db['mysql_db']

# Instantiate MySQL module
mysql = MySQL(app) 

# Home page
@app.route('/')
def home():
    # Set up MySQL cursor
    crs = mysql.connection.cursor()

    # Output tables to console. Will convert this to html later
    crs.execute("SHOW TABLES;")
    print([column[0] for column in crs.fetchall()])
    #mysql.connection.commit() # Commit changes to db
    return render_template('home.html')

if __name__ == "__main__":
    app.run(debug=True, port=5000)