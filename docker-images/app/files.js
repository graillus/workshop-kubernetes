const uploadsFolder = 'public/uploads'
const publicFolder = 'uploads'
const fs = require('fs')

const listFiles = (req, res) => {
  fs.readdir(uploadsFolder, (err, files) => {
    const data = {
      files: [],
      version: req.version,
    }

    if (err) {
      console.log(err)
    }

    data.files = files.map(file => {
      return {
        name: file,
        url: `${publicFolder}/${file}`,
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
  const uploadPath = __dirname + '/' + uploadsFolder + '/' + uploadedFile.name

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
