from ariadne import QueryType, graphql_sync, make_executable_schema
from ariadne import gql, snake_case_fallback_resolvers
from ariadne.constants import PLAYGROUND_HTML
from flask import Flask, request, jsonify
import pandas as pd

type_defs = gql("""
    type Query {
        hello: String!
        caregivers: [Caregiver]
    }

    type Caregiver {
        # Those should be shared with Helpee (Person)
        id: ID!
        name: String!
        photoUrl: String
        birthDate: String!
        gender: Gender!
        occupation: Occupation
        longitude: String
        latitude: String
        number: String
        street: String
        zipCode: String
        city: String
        # End of Helpee sharing (Person)
        userId: ID!
        experience: Experience!
        mentalLoad: MentalLoad!
        helperBio: String!
        helpees: [Helpee]
    }

    type Helpee {
        id: ID!
        name: String!
        photoUrl: String
        birthDate: String!
        gender: Gender!
        occupation: Occupation
        longitude: String
        latitude: String
        number: String
        street: String
        zipCode: String
        city: String
        relationship: String
        since: String
        helpeeBio: String
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


@query.field("caregivers")
def resolve_helpers(_, info):
    return(
        caregiver_address_df.merge(
            relationship_df,
            on="caregiver_id",
            how="left",
            suffixes=["_caregiver", "_relationship"],
        ).merge(
            helpee_address_df,
            on="helpee_id",
            how="left",
            suffixes=["_merged", "_helpee"],
        ).groupby(list(caregiver_columns.keys()), dropna=False)
        .apply(
            lambda x: (
                x.loc[~pd.isna(x["helpee_id"]), list(helpee_columns.keys())]
                .rename(helpee_columns, axis=1)
                .to_dict(orient="records")
            )
        )
        .reset_index()
        .rename(caregiver_columns, axis=1)
        .rename({0: 'helpees'}, axis=1)
        .to_dict(orient="records")
    )


schema = make_executable_schema(
    type_defs,
    query,
    snake_case_fallback_resolvers,
)

app = Flask(__name__)


@app.route("/", methods=["GET"])
def up_message():
    return("Flask/ariadne server up and running!")


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

    caregiver_df = pd.read_csv('./data/caregiver.csv', dtype=str).fillna('')
    helpee_df = pd.read_csv('./data/helpee.csv', dtype=str).fillna('')
    address_df = pd.read_csv('./data/address.csv', dtype=str).fillna('')
    relationship_df = (
        pd.read_csv('./data/relationship.csv', dtype=str)
        .fillna('')
    )

    caregiver_address_df = (
        caregiver_df.merge(
            address_df.rename(
                {
                    "id": "address_id"
                },
                axis=1,
            ),
            on="address_id",
            suffixes=["_caregiver", "_address"],
        )
    )

    helpee_address_df = helpee_df.merge(
        address_df,
        on="address_id",
        suffixes=["_caregiver", "_address"],
    )

    helpee_columns = {
        'helpee_id': 'id',
        'relationship': 'relationship',
        'since': 'since',
        'name_helpee': 'name',
        'gender_helpee': 'gender',
        'birth_date_helpee': 'birth_date',
        'helpee_bio': 'helpee_bio',
        'occupation_helpee': 'occupation',
        'disease': 'disease',
        'photo_url_helpee': 'photo_url',
        'number_helpee': 'number',
        'street_helpee': 'street',
        'zip_code_helpee': 'zip_code',
        'city_helpee': 'city',
        'latitude_helpee': 'latitude',
        'longitude_helpee': 'longitude',
    }

    caregiver_columns = {
        'caregiver_id': 'id',
        'name_merged': 'name',
        'photo_url_merged': 'photo_url',
        'birth_date_merged': 'birth_date',
        'gender_merged': 'gender',
        'occupation_merged': 'occupation',
        'user_id': 'user_id',
        'experience': 'experience',
        'mental_load': 'mental_load',
        'helper_bio': 'helper_bio',
        'number_merged': 'number',
        'street_merged': 'street',
        'zip_code_merged': 'zip_code',
        'city_merged': 'city',
        'longitude_merged': 'longitude',
        'latitude_merged': 'latitude',
    }

    app.run(debug=True)
