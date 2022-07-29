import flask
from flask import jsonify

app = flask.Flask(__name__)
app.config["DEBUG"] = True


@app.route('/hello', methods=['GET'])
def hello_world():
   return jsonify(['Hello World!'])

@app.route('/', methods=['GET'])
def home():
   return "<h1>home page</h1><p>Zobi ta race.</p>"

if __name__ == '__main__':
    app.run()
    # print(jsonify(['Hello World!']))  