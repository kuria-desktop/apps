import std/[strutils, sets]
import owlkettle, owlkettle/adw

viewable App:
  showFlap: bool = true
  folded: bool = false
  page: int
  categories: seq[string] = @["Appearance", "Window Manager"]
  sidebarIcon: string = "go-next-symbolic"

method view(app: AppState): Widget =
  result = gui:
    Window:
      title = "Settings"
      
      HeaderBar {.addTitlebar.}:
        ToggleButton {.addLeft.}:
          icon = app.sidebarIcon
          #text = "Sidebar"
          state = app.showFlap
          proc changed(state: bool) =
            app.showFlap = state
            if app.sidebarIcon == "go-next-symbolic":
              app.sidebarIcon = "go-previous-symbolic"
            else:
              app.sidebarIcon = "go-next-symbolic"
      
      Flap:
        revealed = app.showFlap
        transitionType = FlapTransitionOver
        
        proc changed(revealed: bool) =
          app.showFlap = revealed
        
        proc fold(folded: bool) =
          app.folded = folded
        
        ScrolledWindow {.addFlap, width: 200.}:
          ListBox:
            selectionMode = SelectionSingle
            selected = toHashSet([app.page])
            style = {ListBoxNavigationSidebar}
            
            proc select(pages: HashSet[int]) =
              for page in pages:
                app.page = page
                app.folded = true
                if app.folded:
                  app.showFlap = false
            
            for category in app.categories:
              Label:
                text = category
                xAlign = 0.0
        
        Separator() {.addSeparator.}
        
        Box:
          Label:
            text = repeat("Page " & $app.page & " ", 5)
            wrap = true

adw.brew(gui(App()))