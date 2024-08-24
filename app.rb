require 'webrick'
require 'erb'
require 'mysql2'

# Configuration for the database connection
client = Mysql2::Client.new(
  host: 'localhost', username: 'root', password: '', database: 'my_database'
)

# Route for the login page
server = WEBrick::HTTPServer.new(Port: 3003)

server.mount_proc '/login' do |req, res|
  if req.request_method == 'POST'
    login = req.query['login']
    password = req.query['password']

    # Using prepared statements to prevent SQL injection
    stmt = client.prepare('SELECT * FROM users WHERE login = ? AND password = ?')
    result = stmt.execute(login, password)

    if result.count == 1
      # Redirect to the personal information entry page
      req.query['login'] = login
      res.set_redirect(WEBrick::HTTPStatus::TemporaryRedirect, '/information')
    else
      @error = "Incorrect login or password"
      res.body = ERB.new(File.read('login.erb')).result(binding)
    end
  else
    res.body = ERB.new(File.read('login.erb')).result(binding)
  end
end

# Route for the personal information entry page
server.mount_proc '/information' do |req, res|
  if req.request_method == 'POST'
    firstname = req.query['firstname']
    lastname = req.query['lastname']
    email = req.query['email']
    profession = req.query['profession']

    # Check if the login is present (simulated session)
    login = req.query['login']
    if login
      user = client.query("SELECT id FROM users WHERE login='#{login}'").first
      if user
        # Save personal information in the database
        stmt = client.prepare('INSERT INTO personal_information (user_id, firstname, lastname, email, 
