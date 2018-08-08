using Soup;

void main() {
  string username = "mduk";
  string url = "http://twitter.com/users/%s.xml".printf(username);

  stdout.printf("Getting status for %s\n", username);

  var session = new Soup.Session();
  var message = new Soup.Message("GET", url);

  session.send_message(message);

  stdout.write(message.response_body.data);
}
