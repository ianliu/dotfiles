--import XMonad.Hooks.EwmhDesktops
import System.IO
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Layout.LimitWindows
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Util.EZConfig (additionalKeys, removeKeys)
import XMonad.Util.Paste
import XMonad.Util.Run (spawnPipe)

modKey :: KeyMask
modKey = mod4Mask

myManageHook :: ManageHook
myManageHook = composeAll
    [ title     =? "Microsoft Teams Notification" --> doIgnore <+> doFloat
    , className =? "Zenity"                       --> doFloat
--  , className =? "Microsoft Teams - Preview"    --> doShift "9"
    , className =? "Steam"                        --> doShift "8"
    , className =? "csgo_linux64"                 --> doShift "8"
    , wmRole    =? "gimp-message-dialog"          --> doFloat
    , wmRole    =? "gimp-toolbox-color-dialog"    --> doFloat
    ]
        where
            wmRole = stringProperty "WM_WINDOW_ROLE"

gaps size = spacingRaw False (Border size 0 size 0) True (Border 0 size 0 size) True
myLayouts = (gaps 10 . limitWindows 3 $ Tall 1 (3/100) (1/2)) ||| (noBorders Full)

xK_AudioLower = 0x1008FF11
xK_AudioMute  = 0x1008FF12
xK_AudioRaise = 0x1008FF13

myRemoveKeys config =
    removeKeys config [(modKey, xK_space)]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad . ewmh . docks . myRemoveKeys $ def
        { modMask            = modKey
        , borderWidth        = 2
        , focusedBorderColor = "#22D05F"
        , terminal           = "kitty"
        , focusFollowsMouse  = False
        , clickJustFocuses   = False
        , layoutHook         = avoidStruts $ myLayouts
        , manageHook         = myManageHook <+> manageHook def
        , logHook            = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 50
            }
        } `additionalKeys`
        [ ((modKey, xK_minus),      spawn "hide")
        , ((modKey, xK_equal),      spawn "hide pop")
--      , ((modKey, xK_space),      spawn "dmenu_run")
        , ((modKey, xK_f),          sendMessage NextLayout >> sendMessage ToggleStruts)
        , ((modKey, xK_p),          spawn "dmenu_run")
        , ((modKey, xK_grave),      toggleWS)
        , ((0,      xK_Insert),     pasteSelection)
        , ((0,      xK_AudioLower), spawn "vol dec")
        , ((0,      xK_AudioMute),  spawn "vol toggle")
        , ((0,      xK_AudioRaise), spawn "vol inc")
        ]

-- vim: set sw=4 et sta:
