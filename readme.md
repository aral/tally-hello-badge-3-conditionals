<img src='http://aralbalkan.com/images/tally-label-conditionals.png'>

Tally Hello Badge Example: Conditionals (part 3 of 4)
===

[In part 2](https://github.com/aral/tally-hello-badge-2-repetition), we used the [Tally template engine](http://tally.jit.su) ([fork Tally on GitHub](https://github.com/aral/tally)) to create multiple name badges from the single one we made [in part 1](https://github.com/aral/tally-hello-badge-1-text-and-attribute).

In this example, we’re going to customise some of the labels to include an additional note depending on whether the person is a speaker or not.

Usage
---

1. Clone the repository.
2. Run server.coffee (I use ```nodemon server.coffee``` while developing. Or you can just run ```coffee server.coffee```). Once the server is running, go to ```http://localhost:3000``` to see the example and ```http://localhost:3000/hello-badge.html``` to see the template source.
3. Read the notes below and take a peek at the source code.

How it works
---

Templates in Tally are pure HTML 5. Tally uses ```data-``` attributes to populate templates either on the server or on the client (or both).

One of those attributes, ```data-tally-if``` allows you to conditionally decide whether an element is shown or not. You can decide either false elements are simply hidden (```display:none```, the only option for client‐side templates) or whether they are removed altogether from the DOM (server‐side only). You would chose the latter if you are not going to update your template on the client‐side (e.g., via AJAX calls or WebSocket events).

The template
---

We’re going to modify our template to add a conditional element that gets shown only if the person is a speaker.

```html
<ul>
	<li data-tally-repeat='person people'>
		<a data-tally-attribute='href person.homepage'>
			<p>
				Hello, my name is <span data-tally-text='person.name'>Inigo Montoya</span>
				<span data-tally-if='person.isSpeaker'>Speaker</span>
			</p>
		</a>
	</li>
</ul>
```

The text in the newly added span&#8202;—&#8202;‘Speaker’&#8202;—&#8202;will only get shown if ```person.isSpeaker``` is truthy.

The server
---

On the server, the only change we need to make is to add a truthy ```isSpeaker``` property to the data object.

```javascript
express = require 'express'
tally = require 'tally'

app = express()
app.engine 'html', tally.__express
app.set 'view engine', 'html'
app.use express.static('views')

data = {
	people: [
			{ name: 'Aral', homepage: 'http://aralbalkan.com', isSpeaker: yes }
		,	{ name: 'Laura', homepage: 'http://laurakalbag.com' , isSpeaker: yes }
		, 	{ name: 'Natalie', homepage: 'http://ndkane.com' }
		, 	{ name: 'Seb', homepage: 'http://seb.ly', isSpeaker: yes }
		,	{ name: 'Osky', homepage: 'http://twitter.com/gigapup' }
	]
}

app.get '/', (request, response) ->
	response.render 'hello-badge', data

app.listen 3000
```

That’s it!

When you run the example, the badges of the speakers will have a note on them to that effect.

Table of Contents
---

* Part 1: [Text and Attribute](https://github.com/aral/tally-hello-badge-1-text-and-attribute)
* Part 2: [Repetition](https://github.com/aral/tally-hello-badge-2-repetition)
* Part 3: [Conditionals](https://github.com/aral/tally-hello-badge-3-conditionals)
* Part 4: [Dummy Data](https://github.com/aral/tally-hello-badge-4-dummy-data)

This is just a very simple example. [Check out the Tally web site](http://tally.jit.su) for more complicated ones.