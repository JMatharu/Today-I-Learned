<p align="center">
    <img src="https://user-images.githubusercontent.com/1342803/36623515-7293b4ec-18d3-11e8-85ab-4e2f8fb38fbd.png" width="320" alt="API Template">
    <br>
    <br>
    <a href="http://docs.vapor.codes/3.0/">
        <img src="http://img.shields.io/badge/read_the-docs-2196f3.svg" alt="Documentation">
    </a>
    <a href="https://discord.gg/vapor">
        <img src="https://img.shields.io/discord/431917998102675485.svg" alt="Team Chat">
    </a>
    <a href="LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://circleci.com/gh/vapor/api-template">
        <img src="https://circleci.com/gh/vapor/api-template.svg?style=shield" alt="Continuous Integration">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/swift-5.1-brightgreen.svg" alt="Swift 5.1">
    </a>
</p>

# Welcome to Today I learned!

A simple server side swift app for **Acronyms**.

# Controllers

- Acronums
- Users
- Categories

## Hosting Enviornment

### Prerequisite
- Docker - Run container with MySQL for the app to run on.
eg. `docker run --name mysql -e MYSQL_USER=til -e MYSQL_PASSWORD=password -e MYSQL_DATABASE=vapor  -p 3306:3306 -d mysql/mysql-server:5.7`

`mysql` - Container name

## API Documentation

- Acronyms
	- Get all Acronums (Get) - `/api/acronyms`
	- Create Acronym (Post) - `/api/acronyms`
	- Get Acronym (Get) - `/api/acronyms/{acronymID}`
	- Delete Acronym (Delete) - `/api/acronyms/{acronymID}`
	- Update Acronym (Put) - `/api/acronyms/{acronymID}`
	- Get Creator for Acronym (Get) - `/api/acronyms/{acronymID}/creator`
	- Get Categories for Acronym (Get) - `/api/acronyms/{acronymID}/categories`
	- Add Category to Acronym (Post) - `/api/acronyms/{acronymID}/categories/{categoryID}`
	- Search Acronym -  `/api/acronyms/search`
