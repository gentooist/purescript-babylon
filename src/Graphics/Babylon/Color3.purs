module Graphics.Babylon.Color3 where

import Control.Monad.Eff (Eff)

import Graphics.Babylon (BABYLON)

foreign import data Color3 :: *

foreign import createColor3 :: forall eff. Number -> Number -> Number -> Eff (babylon :: BABYLON | eff) Color3
