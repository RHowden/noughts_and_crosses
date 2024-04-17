# README

This repo implements a simple noughts and crosses game. It is implmented in a Rails app.

# Set up
Rails 7.1 includes a docker file when generating a new app. However, this is focused on deplyoing to production. I've added a basic docker file for development use. This has been done in an elementary fashion and there are issues detailed in the next steps section below.

# App structure
This app has been written as a Rails monolith. I've used turbo streams allow live updates of mutliple tabs.

The app features one model - the game. There is an index page which serves to allow the creation of a new game. This is a placeholder for a more elegant mechanism of creating new games. I've opted to supply a separate controller for the REST-ful action of creating a move. The logic of managing game state is encapsulated within the game model.

# Next steps
Docker set up - I've not used docker much so this element of the app is too simplistic. I have not used docker compose as there is no need to supply separate images for postgres, redis etc. However, this means that each time a container is built it needs to have the migrations run. This can be done from the browser. I think a better way would be to use a volume. At this point I think it would probably be better to supplu a compose file to manage the volume. It would probably also suggest that postgres might be a better fit for the database.

Game set up - I have been simulating running the app with two users by creating a new game and the duplicating the tab. If the app supported a user model it would be possible to create a UI for creating games that allowed users to be selected. This would make the process of setting up a game much less clunky. In addition in the current setup moves for either player can be made from the same browser tab. This is obviously not ideal. If there was a user model it would then be possible to ensure that each user only makes their own moves.

UI - I've written a very rudimentary UI and have not supplied any CSS to style it. 
