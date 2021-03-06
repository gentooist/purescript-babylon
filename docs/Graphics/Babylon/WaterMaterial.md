## Module Graphics.Babylon.WaterMaterial

#### `createWaterMaterial`

``` purescript
createWaterMaterial :: forall eff. String -> Scene -> Eff ("babylon" :: BABYLON | eff) WaterMaterial
```

#### `waterMaterialToMaterial`

``` purescript
waterMaterialToMaterial :: WaterMaterial -> Material
```

#### `setBumpTexture`

``` purescript
setBumpTexture :: forall eff. Texture -> WaterMaterial -> Eff ("babylon" :: BABYLON | eff) Unit
```

#### `addToRenderList`

``` purescript
addToRenderList :: forall eff. AbstractMesh -> WaterMaterial -> Eff ("babylon" :: BABYLON | eff) Unit
```

#### `setWaveHeight`

``` purescript
setWaveHeight :: forall eff. Number -> WaterMaterial -> Eff ("babylon" :: BABYLON | eff) Unit
```

#### `setWindForce`

``` purescript
setWindForce :: forall eff. Number -> WaterMaterial -> Eff ("babylon" :: BABYLON | eff) Unit
```

#### `setWaterColor`

``` purescript
setWaterColor :: forall eff. Color3 -> WaterMaterial -> Eff ("babylon" :: BABYLON | eff) Unit
```

#### `setColorBlendFactor`

``` purescript
setColorBlendFactor :: forall eff. Number -> WaterMaterial -> Eff ("babylon" :: BABYLON | eff) Unit
```

#### `clearRenderList`

``` purescript
clearRenderList :: forall eff. WaterMaterial -> Eff ("babylon" :: BABYLON | eff) Unit
```

#### `setBackFaceCulling`

``` purescript
setBackFaceCulling :: forall eff. Boolean -> WaterMaterial -> Eff ("babylon" :: BABYLON | eff) Unit
```

#### `enableRenderTargets`

``` purescript
enableRenderTargets :: forall eff. Boolean -> WaterMaterial -> Eff ("babylon" :: BABYLON | eff) Unit
```


