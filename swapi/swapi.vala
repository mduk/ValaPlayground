void main(string[] args) {
  Gtk.init(ref args);

  Gtk.Window window = new Gtk.Window();
  window.title = "Star Wars API";
  window.window_position = Gtk.WindowPosition.CENTER;
  window.set_default_size(300, 70);
  window.destroy.connect(Gtk.main_quit);

  Gtk.Label lblName = new Gtk.Label("");

  Gtk.Button btnLoadData = new Gtk.Button.with_label("Load Star Wars data");
  btnLoadData.clicked.connect( () => {
    var session = new Soup.Session();
    var message = new Soup.Message("GET", "https://swapi.co/api/people/1/");
    session.send_message(message);
    //stdout.write(message.response_body.data);
    stdout.printf ("\n");
    Json.Parser parser = new Json.Parser();

    try {
      parser.load_from_data((string) message.response_body.flatten ().data, -1);
      Json.Object person = parser.get_root().get_object();
      string name = person.get_string_member("name");
      lblName.label = name;
      stdout.printf("Character's name is: %s", name);
      stdout.flush();
    } catch (Error e) {
      stdout.printf("Something went wrong\n");
      stdout.printf((string) e);
    }
  });

  var vbox = new Gtk.Box(Gtk.Orientation.VERTICAL, 5);
  vbox.homogeneous = true;
  vbox.add(lblName);
  vbox.add(btnLoadData);

  window.add(vbox);
  window.show_all();

  Gtk.main();
}

