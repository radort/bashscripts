import System.Taffybar

import System.Taffybar.Pager
import System.Taffybar.TaffyPager
import System.Taffybar.Systray
import System.Taffybar.SimpleClock

import System.Taffybar.Widgets.PollingBar
import System.Taffybar.Widgets.PollingGraph

import System.Information.Memory
import System.Information.CPU2

import System.Taffybar.Battery
--import System.Taffybar.Kbd

memCallback = do
  mi <- parseMeminfo
  return [memoryUsedRatio mi]

-- cpuCallback = do
--   (userLoad, systemLoad, totalLoad) <- cpuLoad
--   return [totalLoad, systemLoad]

cpuCallback = getCPULoad "cpu"
cpuTemp = getCPUTemp ["cpu1"]

main = do
  let memCfg = defaultGraphConfig { graphDataColors = [(0, 1, 1, 1)]
                                  , graphLabel = Just "ram "
                                  }
      cpuCfg = defaultGraphConfig { graphDataColors = [ (0, 1, 1, 1)
                                                      , (1, 0, 0, 1)
                                                      ]
                                  , graphLabel = Just "cpu "
                                  }
  let clock = textClockNew Nothing "<span fgcolor='lime'>%A</span> <span fgcolor='orange'>%d.%m.%Y %H:%M:%S</span> " 1
      pager = taffyPagerNew defaultPagerConfig
         { activeWindow     = colorize "cyan"    ""    . shorten 120  . escape
         , activeLayout     = colorize "green"   ""                   . escape
         , activeWorkspace  = colorize "yellow"  ""    . wrap "[" "]" . escape
         , hiddenWorkspace  = colorize "red"     ""                   . escape
--         , emptyWorkspace   = colorize "gray"    ""                   . escape
         , emptyWorkspace   = (\_ -> "")
         , visibleWorkspace = colorize "orange"  ""    . wrap "(" ")" . escape
         , urgentWorkspace  = colorize "yellow"  "red" . wrap " " " " . escape
         , widgetSep        = colorize "lime"    ""      " | "
         }
      mem = pollingGraphNew memCfg 1 memCallback
      cpu = pollingGraphNew cpuCfg 1 cpuCallback
      tray = systrayNew
--      kbd = kbdLayoutNew
--      battery = batteryBarNew (defaultBarConfig colorFunc) "$percentage$% $charge$$time$" 5
      battery = textBatteryNew "$percentage$% $time$" 5
          where colorFunc pct | pct < 0.1 = (1, 0, 0)
                              | pct < 0.2 = (1, 0.5, 0)
                              | pct < 0.9 = (1, 1, 0)
                              | otherwise = (0, 1, 0)

  defaultTaffybar defaultTaffybarConfig { startWidgets = [ pager ]
                                        , endWidgets = reverse [ cpu, mem, battery, tray, clock ]
                                        , barHeight = 24
                                        }
