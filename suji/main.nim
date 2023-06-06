import owlkettle, owlkettle/adw, mathexpr

viewable App:
  equation: string = "Calculator"
  keys: seq[seq[string]] = @[
    @["AC", "Del", "%", "/"],
    @["7", "8", "9", "*"], 
    @["4", "5", "6", "-"], 
    @["1", "2", "3", "+"]
  ]
  e: Evaluator = newEvaluator()

method view(app: AppState): Widget =
  result = gui:
    Window:
      title = $app.equation
      defaultSize = (315, 440)
      HeaderBar {.addTitlebar.}:
        Label {.addTitle.}:
          text = $app.equation
      Box(orient = OrientX, spacing = 6, margin = 12):
        Grid:
          spacing = 6
          margin = 6
          for y in 1..4:
            for x in 1..4:
              Button {.x: x, y: y, hExpand: true, vExpand: true.}:
                text = app.keys[y-1][x-1] 
                style = [ButtonCircular]
                proc clicked() =
                  var ch = app.keys[y-1][x-1] 
                  if app.equation == "Calculator":
                    app.equation = ""
                  if ch == "AC":
                    app.equation = ""
                  elif ch == "Del":
                    app.equation = app.equation[0..^2]
                  elif ch == "%":
                    app.equation = app.equation & " / 100"
                  elif ch in @["+", "-", "*", "/"]:
                    app.equation = app.equation & " " & ch & " "
                  else:
                    app.equation = app.equation & ch
          Button {.x: 1, y: 5, hExpand: false, vExpand: true, width: 2, height: 1.}:
            text = "0"
            style = [ButtonPill]
            proc clicked() =
              if app.equation == "Calculator":
                app.equation = ""
              app.equation = app.equation & "0"
          Button {.x: 3, y: 5, hExpand: true, vExpand: true, height: 1.}:
            text = "."
            style = [ButtonCircular]
            proc clicked() =
              if app.equation == "Calculator":
                app.equation = ""
              app.equation = app.equation & "."
          Button {.x: 4, y: 5, hExpand: true, vExpand: true, height: 1.}:
            text = "="
            style = [ButtonCircular]
            proc clicked() =
              app.equation = $app.e.eval(app.equation)
        
adw.brew(gui(App()))