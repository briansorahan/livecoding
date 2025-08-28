:set -fno-warn-orphans -Wno-type-defaults -XMultiParamTypeClasses -XOverloadedStrings
:set prompt ""

-- Import all the boot functions and aliases.
import Sound.Tidal.Boot
import Sound.Tidal.Chords
import Sound.Tidal.Context

-- Trying and failing to setup didactic pattern visualizer
let targetdpv = Target {oName = "didacticpatternvisualizer", oAddress = "127.0.0.1", oPort = 1818, oLatency = 0.2, oWindow = Nothing, oSchedule = Live, oBusPort = Nothing, oHandshake = False}
let formatsdpv = [OSC "/delivery"  Named {requiredArgs = []} ]
let oscmapdpv = [(targetdpv, formatsdpv), (superdirtTarget, [superdirtShape])]
let grid = pS "grid"
let connectionN = pI "connectionN"
let connectionMax = pI "connectionMax"
let speedSequenser = pF "speedSequenser"
let clear = pI "clear"
let sizeMin = pF "sizeMin"
let sizeMax = pF "sizeMax"
let figure = pS "figure"
let color = pS "color"

default (Rational, Integer, Double, Pattern String)

-- Create a Tidal Stream with the default settings.
-- To customize these settings, use 'mkTidalWith' instead
tidalInst <- mkTidalWith oscmapdpv defaultConfig

-- tidalInst <- mkTidalWith [(superdirtTarget { oLatency = 0.01 }, [superdirtShape])] (defaultConfig {cFrameTimespan = 1/50, cProcessAhead = 1/20})

-- This orphan instance makes the boot aliases work!
-- It has to go after you define 'tidalInst'.
instance Tidally where tidal = tidalInst

let getState = streamGet tidal
    setI = streamSetI tidal
    setF = streamSetF tidal
    setS = streamSetS tidal
    setR = streamSetR tidal
    setB = streamSetB tidal

-- `enableLink` and `disableLink` can be used to toggle synchronisation using the Link protocol.
-- Uncomment the next line to enable Link on startup.
-- enableLink

-- You can also add your own aliases in this file. For example:
-- fastsquizzed pat = fast 2 $ pat # squiz 1.5

:set prompt "tidal> "
:set prompt-cont ""
