require 'webrick'
require 'erb'
require 'mysql2'

# Configuration pour la connexion à la base de données
client = Mysql2::Client.new(
  host: 'localhost', username: 'root', password: '', database: 'ma_base_de_donnees'
)

# Route pour la page de connexion
server = WEBrick::HTTPServer.new(Port: 3003)

server.mount_proc '/login' do |req, res|
  if req.request_method == 'POST'
    login = req.query['login']
    password = req.query['password']

    # Utilisation de requêtes préparées pour éviter l'injection SQL
    stmt = client.prepare('SELECT * FROM users WHERE login = ? AND password = ?')
    result = stmt.execute(login, password)

    if result.count == 1
      # Enregistrer l'utilisateur connecté dans la session
      req.query['login'] = login
      res.set_redirect(WEBrick::HTTPStatus::TemporaryRedirect, '/information')
    else
      @error = "Login ou mot de passe incorrect"
      res.body = ERB.new(File.read('login.erb')).result(binding)
    end
  else
    res.body = ERB.new(File.read('login.erb')).result(binding)
  end
end

# Route pour la page d'entrée des informations personnelles
server.mount_proc '/information' do |req, res|
  if req.request_method == 'POST'
    firstname = req.query['firstname']
    lastname = req.query['lastname']
    email = req.query['email']
    profession = req.query['profession']

    # Vérification si le login est bien présent (session simulée)
    login = req.query['login']
    if login
      user = client.query("SELECT id FROM users WHERE login='#{login}'").first
      if user
        # Enregistrer les informations personnelles dans la base de données
        stmt = client.prepare('INSERT INTO informations_personnelles (user_id, firstname, lastname, email, profession) VALUES (?, ?, ?, ?, ?)')
        stmt.execute(user['id'], firstname, lastname, email, profession)

        # Rediriger vers la page de liste des personnes
        res.set_redirect(WEBrick::HTTPStatus::TemporaryRedirect, '/liste')
      else
        res.body = "Utilisateur introuvable."
      end
    else
      res.body = "Session invalide. Veuillez vous reconnecter."
    end
  else
    res.body = ERB.new(File.read('information.erb')).result(binding)
  end
end

# Route pour la page de liste des personnes
server.mount_proc '/liste' do |req, res|
  # Récupérer la liste des personnes avec leurs informations professionnelles depuis la base de données
  result = client.query('SELECT * FROM informations_personnelles')
  @people = result.to_a

  res.body = ERB.new(File.read('liste.erb')).result(binding)
end

trap 'INT' do
  server.shutdown
end

server.start
