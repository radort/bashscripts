module CukiModules (textVolumeNew) where

import System.Taffybar.Pager
import System.Taffybar.Widgets.PollingLabel
import Graphics.UI.Gtk

import Sound.ALSA.Mixer

-- volume

textVolumeNew :: String -> String -> Double -> IO Widget
textVolumeNew defaultStr name interval = do
  label <- pollingLabelNew defaultStr interval $ getVolume name
  widgetShowAll label
  return $ toWidget label

getVolume :: String -> IO String
getVolume name = do
  Just control <- getControlByName "default" name
  let Just playbackVolume = playback $ volume control
  let Just playbackMute = playback $ switch control
  (_, max) <- getRange playbackVolume
  Just vol <- getChannel FrontLeft $ value $ playbackVolume
  Just mute <- getChannel FrontLeft playbackMute
  if mute == False then return $ colorize "red" "" "Mute"
  else return $ show (round $ (fromIntegral vol / fromIntegral max) * 100) ++ colorize "green" "" "%"
