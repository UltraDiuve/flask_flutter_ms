from time import sleep
import flask
from flask import request, jsonify
from flask_cors import CORS

import pandas as pd
import json

app = flask.Flask(__name__)
app.config["DEBUG"] = True
CORS(app)

# first_names = ['Henriette', 'Jose', 'Amandine', 'Jonathan', 'Herve', 'Antoine', 'Elisabeth']
# json_first_names = [{'name': name} for name in first_names]

# @app.route('/hello', methods=['GET'])
# def hello_world():
#    return jsonify(['Hello World!'])

# @app.route('/', methods=['GET'])
# def home():
#    return "<h1>home page</h1><p>Zobi ta race.</p>"

@app.route('/profiles', methods=['GET', 'POST'])
def profiles():

    if request.method == 'GET':
        prof_json = return_all_profiles()

        if 'id' in request.args:
            id = int(request.args['id'])
            profiles = prof_json[id % len(prof_json)]
            # profiles = json_first_names[id % len(json_first_names)]
        else:
            profiles = prof_json
            # profiles = json_first_names
        
        return(
            jsonify(profiles)
            # profiles
            )
    elif request.method == 'POST':
        print("in post")
        data = pd.read_csv('./data/profiles.csv')
        new_id = data['id'].max() + 1
        to_append = pd.DataFrame(
            {
                'id': [new_id],
                'name': [f"Prénom {new_id}"],
                'city': [f"Ville {new_id}"],
            },
        )
        data = pd.concat(
            [data, to_append],
            axis=0,
        )
        data.to_csv(
            './data/profiles.csv',
            index=False,
        )
        return(jsonify(return_all_profiles()))

def return_all_profiles():
    sleep(1)
    prof_json = json.loads(
        pd.read_csv(
            './data/profiles.csv',
        ).to_json(orient='records')
    )
    return(prof_json)

# @app.route('/person', methods=['GET', 'PUT', 'POST', 'DELETE'])
# def person():
#     pass

if __name__ == '__main__':
    app.run()