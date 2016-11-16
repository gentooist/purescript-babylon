exports.createBlockMapJS = function(noise){
    return function(simplex2){
        return function(index){
            return function(terrainScale){
                return function(waterBlockHeight){
                    return function(maxHeight){
                        return function(blockTypes){

                            var grassBlock = blockTypes.grassBlock;
                            var waterBlock = blockTypes.waterBlock;
                            var woodBlock = blockTypes.woodBlock;

                            var runBlockIndex = PS["Graphics.Babylon.Example.Sandbox.BlockIndex"].runBlockIndex;
                            var runChunkIndex = PS["Graphics.Babylon.Example.Sandbox.ChunkIndex"].runChunkIndex;
                            var blockIndex = PS["Graphics.Babylon.Example.Sandbox.BlockIndex"].blockIndex;
                            var chunkSize = PS["Graphics.Babylon.Example.Sandbox.Constants"].chunkSize;

                            var rci = runChunkIndex(index);
                            var cx = rci.x
                            var cy = rci.y
                            var cz = rci.z

                            // var stmap = Object.create({});
                            var stmap = new Uint8Array(chunkSize * chunkSize * chunkSize);

                            function lookup(lx, ly, lz){
                                return stmap[chunkSize * chunkSize * lx + chunkSize * ly + lz];
                            }
                            function put(lx, ly, lz, value){
                                stmap[chunkSize * chunkSize * lx + chunkSize * ly + lz] = value;
                            }


                            // terrain
                            for(var lz = 0; lz <= chunkSize - 1; lz++){
                                for(var lx = 0; lx <= chunkSize - 1; lx++){
                                    var gx = chunkSize * cx + lx
                                    var gz = chunkSize * cz + lz
                                    var x = gx
                                    var z = gz
                                    var r = (simplex2(x * terrainScale)(z * terrainScale)(noise) + 1.0) * 0.5
                                    var h = Math.max(waterBlockHeight, Math.floor(r * maxHeight))
                                    var top = Math.min(h, chunkSize * (cy + 1) - 1)
                                    var bottom = chunkSize * cy
                                    if(top < bottom){

                                    }else{
                                        for(var gy = bottom; gy <= top; gy++){
                                            var ly = gy - chunkSize * cy;
                                            var blockType = gy <= waterBlockHeight ? waterBlock : grassBlock;
                                            put(lx, ly, lz, blockType);
                                        }
                                    }
                                }
                            }

                            // woods
                            for(var lz = 0; lz <= chunkSize - 1; lz++){
                                for(var lx = 0; lx <= chunkSize - 1; lx++){
                                    var gx = chunkSize * cx + lx
                                    var gz = chunkSize * cz + lz
                                    var r = Math.random();
                                    if(0.99 < r){
                                        // get height
                                        var top = null;
                                        for(var ly = chunkSize - 1; 0 <= ly; ly--){
                                            if(lookup(lx, ly, lz) === grassBlock){
                                                top = ly;
                                                break;
                                            }
                                        }
                                        if(top !== null){
                                            for(var i = 0; i < 5 && top + 1 + i < chunkSize; i++){
                                                put(lx, top + 1 + i, lz, woodBlock);
                                            }
                                        }
                                    }
                                }
                            }


                            return {
                                index: index,
                                blocks: stmap
                            }
                        }
                    }
                }
            }
        }
    }
}