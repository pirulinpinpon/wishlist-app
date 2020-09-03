# wishlist app

# About

wishlist app, users can:

- see their wishlist products and other details
- edit, add and remove products to their wishlist

## Specifications

- Deployment target: iOS 13
- Language: Swift
- Followed architecture: VIPER
- Unit tests to presentation.

## API setup using Docker

To run the APIs locally (REST, GraphQL, and the DB Service) - install Docker and Docker Compose
1. Follow the Docker Compose install guide (including the Docker install Pre-Eq) https://docs.docker.com/compose/install/
2. In the directory `wishlist-docker-container` of this project, run command `sudo docker-compose up` to pull and run the prepared Docker images
3. Once the containers are running the APIs will be available

### Third party libraries
- Quick & Nimble for tests.
- Nuke for handling image download and caching.

