Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origin = Rails.env.production? ? 'https://todo-spa-angular.herokuapp.com' : 'http://localhost:4200'
    origins origin
    resource '*', headers: :any, methods: [:get, :post, :patch, :delete]
  end
end
