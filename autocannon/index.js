const autocannon = require('autocannon')

async function foo () {
  const result = await autocannon({
    url: 'http://aks-app.testing/',
    connections: 6000, //default
    pipelining: 1, // default
    duration: 10 // default
  })
  console.log(result)
}

foo()