const os = require('os')
const ejs = require('ejs');
const express = require('express')
const fileUpload = require('express-fileupload');
const path = require('path')
const fs = require('fs')

const { listFiles, uploadFile } = require('./files')

const VERSION = 'v3.0'

const app = express()

// Setup template engine
app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'ejs')

// Make app version available to middlewares
app.use((req, _, next) => {
  req.version = VERSION
  next()
})

// Access logs to console
app.use((req, res, next) => {
  next()
  console.log(`${req.method} ${req.path} ${res.statusCode}`)
})

const storagePath = process.env.FILE_STORAGE_PATH || __dirname + '/public'
const uploadsPath = storagePath + '/uploads'

if (!fs.existsSync(uploadsPath)){
  console.log('Creating uploads directory ' + uploadsPath)
  fs.mkdirSync(uploadsPath, { recursive: true });
}

// Serve public files
app.use(express.static(storagePath));

// Handle file uploads
app.use(fileUpload());


// Controllers

app.get('/', (_, res) => {
  res.render('pages/home', {
    host: os.hostname(),
    version: VERSION,
  })
})

app.get('/files', listFiles)
app.post('/files/upload', uploadFile);

app.get('/terminate', (_, res) => {
  res.send(ejs.renderFile('pages/home', {
    version: VERSION,
  }))

  process.exit(123)
})

app.listen(3000, '0.0.0.0', () => {
  console.log('App listening on port 3000')
})
