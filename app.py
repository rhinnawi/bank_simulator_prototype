from flask import Flask
#from flask_bootstrap import Bootstrap
from flask_mysqldb import MySQL
import yaml

app = Flask(__name__)

# Configure db using settings in db.yaml file
db = yaml.load(open('db.yaml'))
app.config['MYSQL_HOST'] = db['mysql_host']
app.config['MYSQL_USER'] = db['mysql_user']
app.config['MYSQL_PASSWORD'] = db['mysql_password']
app.config['MYSQL_DB'] = db['mysql_db']

# Instantiate MySQL module
mysql = MySQL(app) 


@app.route('/')
def index():
    # Set up MySQL cursor
    crs = mysql.connection.cursor()
    crs.execute("SHOW TABLES;")
    mysql.connection.commit()
    return 'Hallo, Welt!'

if __name__ == "__main__":
    app.run(debug=True, port=5000)