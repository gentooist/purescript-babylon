module Graphics.Babylon.Example.Types where

import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Now (NOW)
import Control.Monad.Eff.Ref (REF)
import DOM (DOM)
import Graphics.Babylon (BABYLON)
import Graphics.Canvas (CANVAS)

import Graphics.Babylon.Example.Terrain (Terrain)
import Graphics.Babylon.StandardMaterial (StandardMaterial)
import WebWorker (OwnsWW)

type Effects eff = (canvas :: CANVAS, now :: NOW, console :: CONSOLE, dom :: DOM, babylon :: BABYLON, ownsww :: OwnsWW, ref :: REF | eff)

data Mode = Move | Put | Remove

newtype State = State {
    mode :: Mode,
    terrain :: Terrain,
    mousePosition :: { x :: Int, y :: Int },
    debugLayer :: Boolean,
    yaw :: Number,
    pitch :: Number
}

type Materials = {
    boxMat :: StandardMaterial,
    waterBoxMat :: StandardMaterial
}

