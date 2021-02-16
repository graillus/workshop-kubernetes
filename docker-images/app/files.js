const storagePath = process.env.FILE_STORAGE_PATH || __dirname + '/public'
const uploadsDir = 'uploads'
const uploadsPath = storagePath + '/' + uploadsDir

const fs = require('fs')

const listFiles = (req, res) => {
  fs.readdir(uploadsPath, (err, files) => {
    const data = {
      uploadsPath: uploadsPath,
      files: [],
      version: req.version,
    }

    if (err) {
      console.log(err)

      return []
    }

    data.files = files.map(file => {
      return {
        name: file,
        url: `/${uploadsDir}/${file}`,
      }
    })

    res.render('pages/files', data)
  })
}

const uploadFile = (req, res) => {
  if (!req.files || Object.keys(req.files).length === 0) {
    return res.status(400).send('No files were uploaded.');
  }

  console.log(req.files); // the uploaded file object

  const uploadedFile = req.files.upload
  const uploadPath = uploadsPath + '/' + uploadedFile.name

  uploadedFile.mv(uploadPath, (err) => {
    if (err) {
      console.log(err)
    }

    return res.redirect('/files')
  })
}

module.exports = {
  listFiles,
  uploadFile,
}
