#Page: background.html
window.message = "hey"

#onload
require [
  "jquery",
  "underscore",
  "ext",

  #Load framework plugins
  "extPlugin/storage",
  "extPlugin/clipboard",
  "extPlugin/extension",
  "extPlugin/notification",
  "extPlugin/tabs",
], ($, _, ext) ->
  ext.ini({
    silent : false
  })

  #your code here

  #set icon badge on extension load
  ext.menu.icon.setBadge parseInt ext.storage.get "google"

  #set icon click function
  ext.menu.icon.click () ->
    ext.tabs.indexOf "*.google.com", (data) ->
      if data.length is 0
        ext.storage.set("google", parseInt(ext.storage.get("google")) + 1)
        ext.menu.icon.setBadge ext.storage.get("google")
        ext.tabs.create "https://www.google.com",true