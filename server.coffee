express = require 'express'
tally = require 'tally'

app = express()
app.engine 'html', tally.__express
app.set 'view engine', 'html'
app.use express.static('views')

data = {
	people: [
			{ name: 'Aral', homepage: 'http://aralbalkan.com', isSpeaker: yes }
		,	{ name: 'Laura', homepage: 'http://laurakalbag.com' , isSpeaker: yes}
		, 	{ name: 'Natalie', homepage: 'http://ndkane.com' }
		, 	{ name: 'Seb', homepage: 'http://seb.ly', isSpeaker: yes }
		,	{ name: 'Osky', homepage: 'http://twitter.com/gigapup' }
	]
}

app.get '/', (request, response) ->
	response.render 'hello-badge', data

app.listen 3000

console.log '\nServer running. Go to http://localhost:3000 to see the example and http://localhost:3000/hello-badge.html to see the template.\n'