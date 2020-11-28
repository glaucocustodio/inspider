require 'yt'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'pry'
module YoutubeUploader
  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'

  def self.go
    p '11'
    Yt.configure do |config|
      config.client_id = '374528072052-9gdvj5tdtaua0opjb6maa1v8taaugshl.apps.googleusercontent.com'
      config.client_secret = '7-WKi3TyTti7UUXpEk8wBZRK'
      config.api_key = 'AIzaSyCSfsGGTQFbk6fQXFQoWhCfjScMjgXvAaE'
      config.log_level = :debug
    end

    scope = 'https://www.googleapis.com/auth/youtube'
    client_id = Google::Auth::ClientId.from_file('./client_secrets.json')
    token_store = Google::Auth::Stores::FileTokenStore.new(
      :file => './tokens.yaml')
    authorizer = Google::Auth::UserAuthorizer.new(client_id, scope, token_store)

    user_id = 'bababa'
    credentials = authorizer.get_credentials(user_id)

    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: OOB_URI )
      puts "Open #{url} in your browser and enter the resulting code:"
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI)
    end

    if credentials.present?
      account = Yt::Account.new access_token: credentials.access_token

      account.upload_video "https://instagram.flis5-1.fna.fbcdn.net/v/t50.2886-16/10000000_895131517673585_995847173444113599_n.mp4?efg=eyJ2ZW5jb2RlX3RhZyI6InZ0c192b2RfdXJsZ2VuLjcyMC5pZ3R2LmRlZmF1bHQiLCJxZV9ncm91cHMiOiJbXCJpZ193ZWJfZGVsaXZlcnlfdnRzX290ZlwiXSJ9&_nc_ht=instagram.flis5-1.fna.fbcdn.net&_nc_cat=105&_nc_ohc=0D8TZUhAQJsAX-lHyMQ&vs=17870480305819188_2976825727&_nc_vs=HBksFQAYJEdJQ1dtQUJ4WUNNTUhpNERBTF9VdGxfNjlkRU5icUNCQUFBRhUAAsgBABUAGCRHSUNXbUFCY1FuQnJQd3dCQUJvSFZfQ2RMWVJsYnFDQkFBQUYVAgLIAQAoABgAGwGIB3VzZV9vaWwBMRUAABgAFuicpLDtxr4%2FFQIoAkMzLBdAlgUQYk3S8hgSZGFzaF9iYXNlbGluZV8xX3YxEQB17AcA&_nc_rid=be62c6ac0b&oe=5F085BBC&oh=2da9f494df5820eaceeedc029ad9c3e1", title: 'My video'
    else
      p 'no credentials'
    end
  end
end
YoutubeUploader.go
