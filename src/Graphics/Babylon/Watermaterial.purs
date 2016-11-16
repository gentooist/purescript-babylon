module Graphics.Babylon.WaterMaterial where

import Control.Monad.Eff (Eff)
import Data.Unit (Unit)
import Graphics.Babylon (BABYLON)
import Graphics.Babylon.Material (Material)
import Graphics.Babylon.Texture (Texture)
import Graphics.Babylon.Types (AbstractMesh, Scene)

foreign import data WaterMaterial :: *

foreign import createWaterMaterial :: forall eff. String -> Scene -> Eff (babylon :: BABYLON | eff) WaterMaterial

foreign import waterMaterialToMaterial :: WaterMaterial -> Material

foreign import setBumpTexture :: forall eff. Texture -> WaterMaterial -> Eff (babylon :: BABYLON | eff) Unit

foreign import addToRenderList :: forall eff. AbstractMesh -> WaterMaterial -> Eff (babylon :: BABYLON | eff) Unit

foreign import setWaveHeight :: forall eff. Number -> WaterMaterial -> Eff (babylon :: BABYLON | eff) Unit

foreign import setWindForce :: forall eff. Number -> WaterMaterial -> Eff (babylon :: BABYLON | eff) Unit