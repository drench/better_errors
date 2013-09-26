initTags = (callback) ->
  styleTag = makeStyleTag()
  jQueryTag = makeJqueryTag()
  clippyTag = makeClippyTag()

  styleTag.onload = () ->
    jQueryTag.onload = () ->
      clippyTag.onload = callback
      document.body.appendChild clippyTag
    document.body.appendChild jQueryTag
  document.head.appendChild styleTag

makeStyleTag = () ->
  tag = document.createElement "link"
  tag.setAttribute "rel", "stylesheet"
  tag.setAttribute "type", "text/css"
  tag.setAttribute "href", "http://clippy.tmetic.com/clippy.css"
  tag.setAttribute "media", "all"
  tag

makeJqueryTag = () ->
  tag = document.createElement "script"
  tag.src = "//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"
  tag

makeClippyTag = () ->
  tag = document.createElement "script"
  tag.src = "http://clippy.tmetic.com/clippy.min.js"
  tag

quotes = [
  'When you say "I write enterprise software", all I hear is "I write bad software".'
  "I've got Postgres on vinyl."
  "They say the dream of the 90's is alive in Portland, but I haven't met a single Java developer here."
  "I can't believe your Caps Lock key hasn't been remapped yet."
  "Let me save everyone some time: No matter WHAT database question you ask me, I'm just going to tell you that you should be using Postgres."
  "I was just offered $90/hour to do Java/Android dev. I turned it down because someone else offered me $60/hour to gouge out my own eyeballs."
  "No, I'm not going to #SXSW. In related news, it's not 2004."
  "No, I don't want to be your technical cofounder."
  "If I discover even ONE tab character in your codebase, my contract rate just doubled."
  "Wow... Seriously? You're not using vagrant yet?"
]

getQuote = () ->
  quotes.splice(Math.floor(Math.random() * quotes.length), 1)[0]

initTags () ->
  clippy.load "Clippy", (agent) ->
    agent.show()
    agent.play "Greeting"
    agent.play "LookUpRight"
    err = "#{jQuery("header.exception h2").text()}: #{jQuery("header.exception p").text()}"
    agent.speak("Looks like your Rails app broke! #{err}!")
    agent.play "Searching"
    agent.speak("Click me, and I'll see if StackOverflow has any clues.")
    jQuery("div.clippy").css(cursor: "pointer").click () ->
      jQuery(this).unbind("click").css(cursor: "")
      window.open "https://duckduckgo.com/?q=!stackoverflow%20#{escape err}"
      annoy = window.setInterval(
        (
          () ->
            quote = getQuote()
            if quote
              agent.speak quote
              agent.play "IdleSnooze"
            else
              window.clearInterval annoy
              agent.hide()
        ), 30000
      )
      false
    agent.play "IdleSnooze"
