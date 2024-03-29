--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import Data.Monoid
import System.Exit

import XMonad.Util.Cursor
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Spacing
import XMonad.Actions.WorkspaceNames

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 3

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["web","mail","sys/dev","chat","audio","o","th","e","r"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#0000ff"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.

--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch rofi
    , ((modm,               xK_space ), spawn "rofi -show run -terminal alacritty") -- was dmenu_run

    -- launch browser (qutebrowser)
    , ((modm              , xK_b     ), spawn "chromium")

    -- launch file manager
    , ((modm,               xK_v     ), spawn "pcmanfm")
    
    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm, xK_q                   ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_p ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Lock screen
    , ((modm .|. shiftMask, xK_l     ), spawn "dm-tool lock"    )

    -- Rotate keyboard layouts (this is now done using a setxkbmap at launch)
    -- , ((mod1Mask          , xK_space ), spawn "python ~/.xmonad/rotate_keyboard_layout.py")

    -- Brightness control
    , ((modm              , xK_F5     ), spawn "brightnessctl s 5%-")
    , ((modm              , xK_F6     ), spawn "brightnessctl s 5%+")

    -- volume control
    , ((modm              , xK_F1     ), spawn "pulsemixer --toggle-mute && notify-send 'Mute' $(pulsemixer --get-mute)")
    , ((modm              , xK_F2     ), spawn "pulsemixer --change-volume -10")
    , ((modm              , xK_F3     ), spawn "pulsemixer --change-volume +10")

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_m     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm .|. shiftMask, xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = spacingWithEdge 1 $ avoidStruts (tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , className =? "confirm"         --> doFloat
    , className =? "file_progress"   --> doFloat
    , className =? "dialog"          --> doFloat
    , className =? "download"        --> doFloat
    , className =? "error"           --> doFloat
    , className =? "Gimp"            --> doFloat
    , className =? "notification"    --> doFloat
    , className =? "pinentry-gtk-2"  --> doFloat
    , className =? "splash"          --> doFloat
    , className =? "toolbar"         --> doFloat
    , className =? "copyq"           --> doFloat --doRectFloat (W.RationalRect 0.66 0.03 0.33 0.4)
    , resource  =? "kdesktop"       --> doIgnore
    , title =? "qutebrowser"        --> doShift ( myWorkspaces !! 0 )
    , title =? "Chromium"           --> doShift ( myWorkspaces !! 0 )
    , title =? "Discord"            --> doShift ( myWorkspaces !! 3 ) 
    , title =? "Telegram"           --> doShift ( myWorkspaces !! 3 ) 
    , title =? "Zoom"               --> doShift ( myWorkspaces !! 3 )
    , title =? "Spotify"            --> doShift ( myWorkspaces !! 4 )
    , title =? "Thunderbird"        --> doShift ( myWorkspaces !! 1 )
    , className =? "fiji-Main"      --> doFloat
    , manageDocks  -- If you're using docks like xmobar
    -- Append new windows to the bottom of the current stack
    , doF W.swapDown
    ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
    -- enable Russian keyboard
    spawnOnce "setxkbmap -model logicordless -layout \"us,ru\" -variant \",mac\" -option \"grp:alt_space_toggle\" &"
    -- set cursor
    setDefaultCursor xC_left_ptr
    -- draw wallpaper
    spawnOnce "nitrogen --restore &"
    -- launch compositor (transparency, shadows, etc)
    spawnOnce "compton -f -r 12 &"
    -- enable natural scrolling on touchpad
    spawnOnce "natural-scrolling &"
    -- launch trayer
    spawnOnce "trayer --edge top --align right --widthtype pixels --width 100 --height 24 --tint 0x00000000 --margin 465 --transparent true --alpha 0 &"
    -- launch clipboard manager
    spawnOnce "copyq &"
    -- launch notifications daemon
    spawnOnce "dunst &"
    -- connect to wifi
    spawnOnce "iwctl station wlan0 connect \"Treat Yo Self 2011\" &"
    -- launch apps
    spawnOnce "telegram-desktop -startintray &"
    -- spawnOnce "discord --start-minimized &" -- not using that one for now
    spawnOnce "slack -u &"
    -- faster browser launching
    spawnOnce "qutebrowser --nowindow &"
    spawnOnce "nextcloud &"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    -- xmobar -x 0 specifies which monitor this runs
    xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc"
    xmonad $ docks $ defaults
        {
        logHook = dynamicLogWithPP $ def
                {   ppOutput = hPutStrLn xmproc
                ,   ppCurrent = xmobarColor "#ffffff" "" . wrap "[" "]"
                ,   ppHidden = xmobarColor "#bbbbbb" ""
                ,   ppHiddenNoWindows = xmobarColor "#aaaaaa" ""
                ,   ppTitle = xmobarColor "#dddddd" "" . shorten 30
                ,   ppSep = " | "
                ,   ppOrder = \(ws:_:t:_) -> [ws,t]
                }
        }

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines [ "The default mod key is 'super'. Keybindings:",
      "",
      "-- launching and killing programs",
      "mod-Shift-Enter  Launch alacritty",
      "mod-Space        Launch rofi",
      "mod-b            Launch chromium",
      "mod-v            Launch pcmanfm",
      "mod-Shift-p      Launch gmrun",
      "mod-q            Close/kill the focused window",
      "",
      "-- layouts",
      "mod-p            Rotate through the available layout algorithms",
      "mod-Shift-Space  Reset the layouts on the current workspace to default",
      "mod-n            Resize/refresh viewed windows to the correct size",
      "",
      "-- window focus",
      "mod-Tab          Move focus to the next window",
      "mod-j            Move focus to the next window",
      "mod-k            Move focus to the previous window",
      "mod-m            Move focus to the master window",
      "",
      "-- window management",
      "mod-Return       Swap the focused window and the master window",
      "mod-Shift-j      Swap the focused window with the next window",
      "mod-Shift-k      Swap the focused window with the previous window",
      "mod-h            Shrink the master area",
      "mod-l            Expand the master area",
      "mod-t            Push window back into tiling",
      "mod-comma        Increase the number of windows in the master area",
      "mod-period       Decrease the number of windows in the master area",
      "",
      "-- screen and workspace control",
      "mod-Shift-[1..9] Move client to workspace N",
      "mod-{w,e,r}      Switch to physical/Xinerama screens 1, 2, or 3",
      "mod-Shift-{w,e,r} Move client to screen 1, 2, or 3",
      "",
      "-- system controls",
      "mod-Shift-l      Lock screen",
      "mod-F5           Decrease brightness",
      "mod-F6           Increase brightness",
      "mod-F1           Mute volume",
      "mod-F2           Decrease volume",
      "mod-F3           Increase volume",
      "",
      "-- quit or restart",
      "mod-Shift-q      Restart xmonad",
      "mod-Shift-m      Quit xmonad",
      "",
      "-- Mouse bindings: default actions bound to mouse events",
      "mod-button1      Set the window to floating mode and move by dragging",
      "mod-button2      Raise the window to the top of the stack",
      "mod-button3      Set the window to floating mode and resize by dragging",
      "",
      "Note: 'mod' refers to the 'super' (Windows) key."
    ]
