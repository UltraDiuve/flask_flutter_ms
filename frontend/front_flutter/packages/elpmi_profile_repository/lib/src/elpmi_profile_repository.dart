import 'package:elpmi_profile_repository/elpmi_profile_repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLClient clientToQuery(String token) {
  final HttpLink httpLink = HttpLink(
    "https://dnqb8qz780.execute-api.eu-west-3.amazonaws.com/Prod/graphql",
  );

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer $token',
  );

  final Link link = authLink.concat(httpLink);

  return GraphQLClient(
    cache: GraphQLCache(),
    link: link,
  );
}

const String elpmiProfileQuery = r'''
  query {elpmiProfile {
    uid
    name
    helperBio
    streetNum
    street
    zipCode
    city
    country
    helpees {
      name
      helpeeBio
    }
  }
  }
''';

class ElpmiProfileRepository {
  Future<ElpmiProfile> fetchProfile(String jwt) async {
    GraphQLClient _client = clientToQuery(jwt);
    QueryResult result = await _client.query(QueryOptions(
        document: gql(elpmiProfileQuery))); // , operationName: 'POST'

    print('result: $result.toString()');

    Map<String, dynamic> data = result.data?["elpmiProfile"];
    return (ElpmiProfile.fromMap(data));
  }
}
