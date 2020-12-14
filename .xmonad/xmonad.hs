--import XMonad.Hooks.EwmhDesktops
import System.IO
import XMonad
import XMonad.StackSet as W
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
import XMonad.Util.NamedScratchpad
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
    , className =? "csgo_linux64"                 --> doShift "8" <+> nonFloating
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

myTerminal = "kitty"

scratchpads =
    [ NS
        "console"
        (myTerminal ++ " --class=drop-console")
        (className =? "drop-console")
        (customFloating $ W.RationalRect 0 0 1 (1/3))
    , NS
        "spotify"
        "com.spotify.Client"
        (className =? "Spotify")
        (customFloating $ W.RationalRect (9/10) (9/10) (9/10) (9/10))
    ]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad . ewmh . docks . myRemoveKeys $ def
        { modMask            = modKey
        , borderWidth        = 2
        , focusedBorderColor = "#22D05F"
        , terminal           = myTerminal
        , focusFollowsMouse  = False
        , clickJustFocuses   = False
        , layoutHook         = avoidStruts $ myLayouts
        , manageHook         = namedScratchpadManageHook scratchpads
                                <+> myManageHook
                                <+> manageHook def
        , logHook            = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 50
            }
        } `additionalKeys`
        [ ((modKey,               xK_minus),      spawn "hide")
        , ((modKey,               xK_equal),      spawn "hide pop")
--      , ((modKey,               xK_space),      spawn "dmenu_run")
        , ((modKey,               xK_f),          sendMessage NextLayout >> sendMessage ToggleStruts)
        , ((modKey,               xK_p),          spawn "rofi -show drun")
        , ((modKey .|. shiftMask, xK_p),          spawn "rofi -show run")
        , ((modKey,               xK_Tab),        spawn "rofi -show window")
        , ((modKey,               xK_grave),      toggleWS' ["NSP"])
        , ((0,                    xK_F11),        namedScratchpadAction scratchpads "console")
        , ((modKey,               xK_F11),        namedScratchpadAction scratchpads "spotify")
        , ((0,                    xK_Insert),     pasteSelection)
        , ((0,                    xK_AudioLower), spawn "vol dec")
        , ((0,                    xK_AudioMute),  spawn "vol toggle")
        , ((0,                    xK_AudioRaise), spawn "vol inc")
        ]

-- vim: set sw=4 et sta:
