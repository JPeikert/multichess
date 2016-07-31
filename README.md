# Multichess

Multichess is a chess server, written in Ruby with ActionCable.
It allows multiple users to create and join rooms, in which they can chat and play chess.

### Compatibility
Multichess is created and tested on:

* Ruby 2.3.1
* Rails 5.0.0.rc1
* Puma 3.0

## Usage
### Database initialization
```shell
rails db:migrate
```

### Running server
```shell
rails server
```

### Using locally
* Open localhost:3000 in the browser
* Create an account (no pre-existing available) or log in
* Create/join a room
* Join a game  - 2 players needed to start it
* To chat you need to be playing a game