#Page: options.html

#onload
require [
  "jquery",
  "underscore",
  "bootstrap",

  "ext",
  "extPlugin/extension",
], ($,_,bootstrap,ext) ->
  ext.ini()

  option =
    create:(json) ->
      elm = '<div class="row"><label class="col-sm-4 control-label right 400">'+json.title+'</label><div class="col-sm-8">'+this.types[json.type](json)+'</div></div>'
      elm = $(elm).appendTo("#settings");
      elm.find("input, select").change () ->
        ext.options.set(json.key,$(this).val())

    types:
      text : (json) ->
        elm = '<input type="text" class="form-control" value="'+ext.options.get(json.key)+'">'

      textArea : (json) ->
        elm = '<textarea class="form-control" rows="4">'+ext.options.get(json.key)+'</textarea>'

      checkbox : (json) ->
        if(String(ext.options.get(json.key)) is "true")
          elm = '<input type="checkbox" checked>'
        else
          elm = '<input type="checkbox">'
        return elm

      list : (json) ->
        elm = '<select id="disabledSelect" class="form-control" value="'+ext.options.get(json.key)+'"></select>'
        for title in json.titles
          value = json.values[_i]
          storage = ext.options.get(json.key)
          if storage is value
            elm = $(elm).append('<option value="'+value+'" selected>'+title+'</option>')
          else
            elm = $(elm).append('<option value="'+value+'">'+title+'</option>')
        return elm.prop('outerHTML')

  $.getJSON "../../configure.json", (data) ->
    for item in data.options
      option.create({
        title : item.title,
        key : item.key,
        type : item.type,
        titles : item.titles,
        values : item.values
      })


#  option.create("Text","test","text")
#  option.create("Checkbox","true","checkbox")
#  option.create("Select",["one","two"],"select")
#  option.create("Text","this is some text","textArea")