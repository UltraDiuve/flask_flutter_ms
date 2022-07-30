import flask
from flask import request, jsonify
from flask_cors import CORS

app = flask.Flask(__name__)
app.config["DEBUG"] = True
CORS(app)

first_names = ['Henriette', 'Jose', 'Amandine', 'Jonathan', 'Herve', 'Antoine', 'Elisabeth']
json_first_names = [{'name': name} for name in first_names]

@app.route('/hello', methods=['GET'])
def hello_world():
   return jsonify(['Hello World!'])

@app.route('/', methods=['GET'])
def home():
   return "<h1>home page</h1><p>Zobi ta race.</p>"

@app.route('/profiles', methods=['GET'])
def profiles():
    if 'id' in request.args:
        id = int(request.args['id'])
        profiles = json_first_names[id % len(first_names)]
    else:
        profiles = json_first_names
    
    return(jsonify(profiles))

@app.route('/person', methods=['GET', 'PUT', 'POST', 'DELETE'])
def person():
    pass

if __name__ == '__main__':
    app.run()
    # print(jsonify(['Hello World!']))  