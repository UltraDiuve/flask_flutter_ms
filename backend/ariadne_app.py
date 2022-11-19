from ariadne import QueryType, graphql_sync, make_executable_schema, gql
from ariadne.constants import PLAYGROUND_HTML
from flask import Flask, request, jsonify
import pandas as pd
import json

type_defs = gql("""
    type Query {
        hello: String!
        helpers: [Helper]
    }

    type Helper {
        # Those should be shared with Helpee (Person)
        id: ID!
        name: String!
        photoUrl: String
        birthDate: String!
        gender: Gender!
        occupation: Occupation
        address: Address
        # End of Helpee sharing (Person)
        user_id: ID!
        experience: Experience!
        mentalLoad: MentalLoad!
        helperBio: String!
    }

    enum Gender {
        M
        F
        O
    }

    enum Occupation {
        active
        inactive
        retired
        student
    }

    enum Experience {
        new
        medium
        experienced
    }

    enum MentalLoad {
        low
        medium
        high
    }

    type Address {
        longitude: String
        latitude: String
        number: String
        street: String
        zipCode: String
        city: String
    }
""")

query = QueryType()


@query.field("hello")
def resolve_hello(_, info):
    request = info.context
    user_agent = request.headers.get("User-Agent", "Guest")
    return "Hello, %s!" % user_agent


@query.field("helpers")
def resolve_helpers(_, info):
    # request = info.context
    # user_agent = request.headers.get("User-Agent", "Guest")
    person_df = pd.read_csv('./data/person.csv')
    helper_df = pd.read_csv('./data/helper.csv')
    response = json.loads(
        person_df.merge(
            helper_df,
            left_on="id",
            right_on="person_id",
            how="right"
        ).to_json(
            orient="records"
        )
    )
    print(response)
    print(type(response))
    return (response)


schema = make_executable_schema(type_defs, query)

app = Flask(__name__)


@app.route("/graphql", methods=["GET"])
def graphql_playground():
    # On GET request serve GraphQL Playground
    # You don't need to provide Playground if you don't want to
    # but keep on mind this will not prohibit clients from
    # exploring your API using desktop GraphQL Playground app.
    return PLAYGROUND_HTML, 200


@app.route("/graphql", methods=["POST"])
def graphql_server():
    # GraphQL queries are always sent as POST
    data = request.get_json()

    # Note: Passing the request to the context is optional.
    # In Flask, the current request is always accessible as flask.request
    success, result = graphql_sync(
        schema,
        data,
        context_value=request,
        debug=app.debug
    )

    status_code = 200 if success else 400
    return jsonify(result), status_code


if __name__ == "__main__":
    app.run(debug=True)
