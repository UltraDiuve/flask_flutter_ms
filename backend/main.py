import flask
from flask import request, jsonify

app = flask.Flask(__name__)
app.config["DEBUG"] = True

first_names = ['Henriette', 'Jose', 'Amandine', 'Jonathan', 'Herve', 'Antoine', 'Elisabeth']

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
        profiles = [first_names[id % len(first_names)]]
    else:
        profiles = first_names
    
    return(jsonify(profiles))

@app.route('/person', methods=['GET', 'PUT', 'POST', 'DELETE'])
def person():
    pass

if __name__ == '__main__':
    app.run()
    # print(jsonify(['Hello World!']))  