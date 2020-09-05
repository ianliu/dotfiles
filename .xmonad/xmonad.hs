--import XMonad.Hooks.EwmhDesktops
import System.IO
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Paste
import XMonad.Util.Run (spawnPipe)

modKey :: KeyMask
modKey = mod4Mask

myManageHook :: ManageHook
myManageHook = composeAll
    [ title     =? "Microsoft Teams Notification" --> doFloat
    , className =? "Zenity"                       --> doFloat
    , className =? "Microsoft Teams - Preview"    --> doShift "9"
    , className =? "Steam"                        --> doShift "8"
    , wmRole    =? "gimp-message-dialog"          --> doFloat
    , wmRole    =? "gimp-toolbox-color-dialog"    --> doFloat
    ]
        where
            wmRole = stringProperty "WM_WINDOW_ROLE"

gaps size = spacingRaw False (Border size 0 size 0) True (Border 0 size 0 size) True
myLayouts = (gaps 10 $ Tall 1 (3/100) (1/2)) ||| (noBorders Full)

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad . docks $ def
        { modMask            = modKey
        , borderWidth        = 2
        , focusedBorderColor = "#22D05F"
        , terminal           = "termite"
        , focusFollowsMouse  = False
        , clickJustFocuses   = False
        , layoutHook         = avoidStruts $ myLayouts
        , manageHook         = myManageHook <+> manageHook def
        , logHook            = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 50
            }
        } `additionalKeys`
        [ ((modKey, xK_minus),  spawn "hide")
        , ((modKey, xK_equal),  spawn "hide pop")
        , ((modKey, xK_space),  spawn "dmenu_run")
        , ((modKey, xK_f),      sendMessage NextLayout)
        , ((modKey, xK_b),      sendMessage ToggleStruts)
        , ((modKey, xK_grave),  toggleWS)
        , ((0,      xK_Insert), pasteSelection)
        ]

-- vim: set sw=4 et sta:
