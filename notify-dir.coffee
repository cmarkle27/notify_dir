# NotifyDir
# A directory monitor that detects new and modified files and sends email notifications
watch = require "watch"
nodemailer = require "nodemailer"
_ = require "underscore"

module.exports = class NotifyDir

  constructor: (@directory, @mail_settings, @defaults, @debounce_timeout) ->
    message_obj = {}
    message_obj = _.clone @defaults, message_obj
    message_obj = _.extend message_obj, @directory
    smtp_transport = nodemailer.createTransport @mail_settings.transport, @mail_settings.options
    last_notified = new Date

    # filename and stat are from the last file touched - so we check the whole list
    notice = _.debounce((filename, stat) =>
      valid_files = []
      _.each @files, (file, key) =>
        if Date.parse(file.atime) > Date.parse(last_notified) && key != @directory.path
          if not file.isDirectory()
            valid_files.push key
      if valid_files.length > 0
        message_obj.html += valid_files.join "<br>"
        message_obj.text += valid_files.join "\n"
        smtp_transport.sendMail message_obj, (error, response) =>
          if error
            console.log error
          else
            console.log "Message sent to: ", message_obj.to
            console.log response

      message_obj.text = message_obj.html = ""
      last_notified = new Date
    , @debounce_timeout)

    watch.createMonitor @directory.path, {'ignoreDotFiles' : true}, (monitor) =>
      @files = monitor.files
      monitor.on "created", notice
      monitor.on "changed", notice
