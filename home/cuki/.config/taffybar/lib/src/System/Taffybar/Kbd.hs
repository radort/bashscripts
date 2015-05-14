module System.Taffybar.Kbd (kbdLayoutNew) where

import Foreign
import Foreign.C.Types (CUChar,CUShort,CUInt(..),CInt(..))

import Graphics.X11.Xlib
import System.Taffybar.Widgets.PollingLabel
import Graphics.UI.Gtk (Widget, widgetShowAll)

data XkbStateRec = XkbStateRec {
    group :: CUChar,
    locked_group :: CUChar,
    base_group :: CUShort,
    latched_group :: CUShort,
    mods :: CUChar,
    base_mods :: CUChar,
    latched_mods :: CUChar,
    locked_mods :: CUChar,
    compat_state :: CUChar,
    grab_mods :: CUChar,
    compat_grab_mods :: CUChar,
    lookup_mods :: CUChar,
    compat_lookup_mods :: CUChar,
    ptr_buttons :: CUShort
}

instance Storable XkbStateRec where
    sizeOf _ = ((18))
    alignment _ = alignment (undefined :: CUShort)
    peek ptr = do
        r_group <- ((\hsc_ptr -> peekByteOff hsc_ptr 0)) ptr
        r_locked_group <- ((\hsc_ptr -> peekByteOff hsc_ptr 1)) ptr
        r_base_group <- ((\hsc_ptr -> peekByteOff hsc_ptr 2)) ptr
        r_latched_group <- ((\hsc_ptr -> peekByteOff hsc_ptr 4)) ptr
        r_mods <- ((\hsc_ptr -> peekByteOff hsc_ptr 6)) ptr
        r_base_mods <- ((\hsc_ptr -> peekByteOff hsc_ptr 7)) ptr
        r_latched_mods <- ((\hsc_ptr -> peekByteOff hsc_ptr 8)) ptr
        r_locked_mods <- ((\hsc_ptr -> peekByteOff hsc_ptr 9)) ptr
        r_compat_state <- ((\hsc_ptr -> peekByteOff hsc_ptr 10)) ptr
        r_grab_mods <- ((\hsc_ptr -> peekByteOff hsc_ptr 11)) ptr
        r_compat_grab_mods <- ((\hsc_ptr -> peekByteOff hsc_ptr 12)) ptr
        r_lookup_mods <- ((\hsc_ptr -> peekByteOff hsc_ptr 13)) ptr
        r_compat_lookup_mods <- ((\hsc_ptr -> peekByteOff hsc_ptr 14)) ptr
        r_ptr_buttons <- ((\hsc_ptr -> peekByteOff hsc_ptr 16)) ptr
        return XkbStateRec {
            group = r_group,
            locked_group = r_locked_group,
            base_group = r_base_group,
            latched_group = r_latched_group,
            mods = r_mods,
            base_mods = r_base_mods,
            latched_mods = r_latched_mods,
            locked_mods = r_locked_mods,
            compat_state = r_compat_state,
            grab_mods = r_grab_mods,
            compat_grab_mods = r_compat_grab_mods,
            lookup_mods = r_lookup_mods,
            compat_lookup_mods = r_compat_lookup_mods,
            ptr_buttons = r_ptr_buttons
        }

foreign import ccall unsafe "X11/XKBlib.h XkbGetState"
    xkbGetState :: Display -> CUInt -> Ptr XkbStateRec -> IO CInt

getKbdLayout :: Display -> IO Int
getKbdLayout d = alloca $ \stRecPtr -> do
    xkbGetState d (256) stRecPtr
    st <- peek stRecPtr
    return $ fromIntegral (group st)

kbdLayoutNew :: [String] -> Double -> IO Widget
kbdLayoutNew layouts pollSeconds = do
    l <- pollingLabelNew "" pollSeconds getLayoutName
    widgetShowAll l
    return l
        where
          getLayoutName = do
            d <- openDisplay ""
            kbdlay <- getKbdLayout d
            closeDisplay d
            return (layouts !! kbdlay)
