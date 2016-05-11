null: null
boolean: true
# include a string
string: 'test'
number: 5.6
date: '2016-05-10T19:06:36.909Z'
# and a list of numbers
list: [
  1
  2
  3
]
# add a sub object
person:
  name: 'Alexander Schilling'
  job: 'Developer'
# complex structure
complex: [
  {name: 'Egon'}
  {name: 'Janina'}
]
# Multi-Line Strings! Without Quote Escaping!
emissions: '''
  Livestock and their byproducts account for at least 32,000 million tons of carbon dioxide (CO2) per year, or 51% of all worldwide greenhouse gas emissions.
  Goodland, R Anhang, J. “Livestock and Climate Change: What if the key actors in climate change were pigs, chickens and cows?”
  WorldWatch, November/December 2009. Worldwatch Institute, Washington, DC, USA. Pp. 10–19.
  http://www.worldwatch.org/node/6294
  '''
# calculate session timeout in milliseconds
calc: 15*60*1000
math: Math.sqrt 16
