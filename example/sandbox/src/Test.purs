module Graphics.Babylon.Test where

import Control.Bind (bind)
import Control.Monad (join)
import Control.Monad.Except (runExcept)
import Data.Array (length)
import Data.Either (Either(..))
import Data.Foldable (all)
import Data.Foreign.Class (read, write)
import Data.Int (toNumber, floor)
import Data.List ((..))
import Data.Map (Map, fromFoldable)
import Data.Tuple (Tuple(Tuple))
import Data.Unit (unit, Unit)
import Prelude (pure, div, (<), (<#>), (*), (+), (==), negate, ($))
import Test.StrongCheck (SC, assert, assertEq, quickCheck)

import PerlinNoise (createNoise, simplex2)
import Graphics.Babylon (BABYLON)
import Graphics.Babylon.VertexData (VertexDataProps(VertexDataProps))
import Graphics.Babylon.Example.ChunkIndex (ChunkIndex(..))
import Graphics.Babylon.Example.Generation (createTerrainGeometry, createBlockMap, chunkSize)
import Graphics.Babylon.Example.VertexDataPropsData (VertexDataPropsData(..))
import Graphics.Babylon.Example.Chunk (Chunk(..))
import Graphics.Babylon.Example.BlockType (BlockType(..))
import Graphics.Babylon.Example.BlockIndex (BlockIndex(..))
import Graphics.Babylon.Example.Terrain (globalPositionToChunkIndex, globalPositionToLocalIndex, globalPositionToGlobalIndex)

main :: SC (babylon :: BABYLON) Unit
main = do

    assert $ assertEq (globalPositionToChunkIndex 0.5 0.5 0.5) (ChunkIndex 0 0 0)
    assert $ assertEq (globalPositionToChunkIndex (-0.5) (-0.5) (-0.5)) (ChunkIndex (-1) (-1) (-1))
    assert $ assertEq (globalPositionToChunkIndex (35.0) (-0.5) (12.5)) (ChunkIndex (2) (-1) (0))
    assert $ assertEq (globalPositionToChunkIndex (-35.0) (0.5) (-12.5)) (ChunkIndex (-3) (0) (-1))

    assert $ assertEq (globalPositionToLocalIndex (-9.3) (6.5) (-4.9)) (BlockIndex (6) (6) (11))
    assert $ assertEq (globalPositionToLocalIndex (15.9) (16.0) (16.1)) (BlockIndex (15) (0) (0))
    assert $ assertEq (globalPositionToLocalIndex (-15.9) (-16.0) (-16.1)) (BlockIndex (0) (0) (15))
    assert $ assertEq (globalPositionToLocalIndex (-31.9) (-32.0) (-32.1)) (BlockIndex (0) (0) (15))

    assert $ assertEq (globalPositionToGlobalIndex (0.0) (1.0) (-1.0)) (BlockIndex (0) 1 (-1))
    assert $ assertEq (globalPositionToGlobalIndex (-0.9) (-1.0) (-1.1)) (BlockIndex (-1) (-1) (-2))
    assert $ assertEq (globalPositionToGlobalIndex (-15.9) (-16.0) (-16.1)) (BlockIndex (-16) (-16) (-17))

    quickCheck \seed ->
        let noise = createNoise seed
            blocks = (0 .. 15) <#> \iz ->
                (0 .. 15) <#> \ix ->
                    let x = toNumber ix
                        z = toNumber iz
                        r = (simplex2 (x * 0.03) (z * 0.03) noise + 1.0) * 0.5
                        h = floor (r * 2.0)
                        in
                            (0 .. h) <#> \iy -> let y = toNumber iy in Tuple (BlockIndex ix iy iz) GrassBlock
            map :: Map BlockIndex BlockType
            map = fromFoldable (join (join blocks))

            dat = createTerrainGeometry (Chunk { index: ChunkIndex 0 0 0,  map })
        in case dat of
            VertexDataPropsData props@{ grassBlocks: VertexDataProps grassBlocks } -> all (\index -> index < div (length grassBlocks.positions) 3) grassBlocks.indices


    pure unit

test :: SC (babylon :: BABYLON) Unit
test = do
    quickCheck \cx cy cz seed -> let map = createBlockMap (ChunkIndex cx cy cz) seed
                                     geometry = createTerrainGeometry map
                                     fn = write geometry
                                     in case runExcept (read fn) of
                                        Left err -> false
                                        Right geometry' -> geometry' == geometry