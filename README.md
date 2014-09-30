#Twitter -> Task management
Listen to the Twitter streaming API and create task in Redbooth, Trello and ... For people that have a shortage of items on their TODO list.

## Configuration
All configuration is done in a .env file. During development this is loaded using the Dotenv gem. Please check .env-example for an overview of configuration options.

###Twitter
The Twitter streaming API requires you to use an app and user credentials. Only *read* rights are required.

###Redbooth
Setup an app that has as callback url http://<yourhost>/users/auth/redbooth/callback

###Trello
Setup an app that has as callback url http://<yourhost>/users/auth/trello/callback

###Hashtag
Todo's are created based on a hashtag or search string for the Twitter streaming API. You can change it by setting the *LISTEN_TO* variable in the .env file.

## Start
You need to run two processes: web server and a rake task that connects to the Twitter streaming API. For ease of use a Procfile is provided.

`foreman s` should do the trick during development

##Deployment
The current version is running using the Digital Ocean Dokku image. Please see: https://www.digitalocean.com/community/tutorials/how-to-use-the-dokku-one-click-digitalocean-image-to-run-a-ruby-on-rails-app

##Testing
Since we are using the Devise and Omniauth gems and both these gem are well tested I took the liberty of not testing the oauth interactions. Also the controllers used are so simple I felt testing would defeat the purpose.

