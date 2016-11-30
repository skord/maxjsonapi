# Maxpanel-ember

This README outlines the details of collaborating on this Ember application.
A short introduction of this app could easily go here.

## Just want to try it out?

There's a Dockerfile here. You can build it yourself or pull from skord/maxpanel. The container image consists of this app and a nginx proxy that will serve the app and proxy the requests to your MaxInfo JSON listener. You're going to need to set that up, checkout the MariaDB knowledge base for that.

To give it a quick whirl, you'll need to run your container with an environmental variable set that is the IP:PORT of your MaxInfo listener like this:

```
docker run -it --rm -e MAXSCALE_MAXINFO_JSON_LISTENER_TCP_ADDR=10.190.0.5:8003 -p 9090:80 skord/maxpanel
```

The above command will run a the image, deleting it when it's done with the MaxInfo backend of 10.190.0.5:8003. The port the app will be available on is 9090. Feel free and map that wherever you like.


## Prerequisites

You will need the following things properly installed on your computer.

* [Git](http://git-scm.com/)
* [Node.js](http://nodejs.org/) (with NPM)
* [Bower](http://bower.io/)
* [Ember CLI](http://ember-cli.com/)
* [PhantomJS](http://phantomjs.org/)

## Installation

* `git clone <repository-url>` this repository
* change into the new directory
* `npm install`
* `bower install`

## Running / Development

* `ember server`
* Visit your app at [http://localhost:4200](http://localhost:4200).

### Code Generators

Make use of the many generators for code, try `ember help generate` for more details

### Running Tests

* `ember test`
* `ember test --server`

### Building

* `ember build` (development)
* `ember build --environment production` (production)

### Deploying

In production mode, Maxpanel expects a few things:

* Maxpanel runs at the site root.
* API Requests to MaxInfo are prefixed with /api on the same host as Maxpanel
* CORS headers are added to the API responses.  

[An example nginx config](https://github.com/skord/box/blob/master/maxpanel/default.conf) is provided in the Box repo. In that config, Maxpanel lives in /app and the /api/ location proxy passes to MaxInfo and adds the CORS headers.


## Further Reading / Useful Links

* [ember.js](http://emberjs.com/)
* [ember-cli](http://ember-cli.com/)
* Development Browser Extensions
  * [ember inspector for chrome](https://chrome.google.com/webstore/detail/ember-inspector/bmdblncegkenkacieihfhpjfppoconhi)
  * [ember inspector for firefox](https://addons.mozilla.org/en-US/firefox/addon/ember-inspector/)
