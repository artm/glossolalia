# Glossolalia

My Nth experiment in building a parallel texts repository and editor. The key
difference today is using google drive for storage and its realtime API for
collaborative editing.

# Summa Technologiae

## NPM

Node package manager and its repository of useful javascript.

## Gulp

Development tasks / authomation runner.

## Webpack

Module system for the browser using CommonJS style modules from NPM.

## BrowserSync

Serve the project in development and reload assets when they change.

# Workflow

    gulp serve

Starts a BrowserSync server and opens a browser pointing to it. Also watchers are setup
that rebuild and update the assets on source changes.

    gulp

Rebuilds the `dist`.
