exports.createMesh = function(id){
    return function(scene){
        return function(){
            return new BABYLON.Mesh(id, scene);
        }
    }
}


exports.createSphere = function(id){
    return function(segments){
        return function(diameter){
            return function(scene){
                return function(){
                    return BABYLON.Mesh.CreateSphere(id, segments, diameter, scene);
                }
            }
        }
    }
}

exports.createBox = function(id){
    return function(size){
        return function(scene){
            return function(){
                return BABYLON.Mesh.CreateBox(id, size, scene);
            }
        }
    }
}


exports.createGround = function(id){
    return function(width){
        return function(height){
            return function(subdivisions){
                return function(scene){
                    return function(){
                        return BABYLON.Mesh.CreateGround(id, width, height, subdivisions, scene)
                    }
                }
            }
        }
    }
}

exports.setPosition = function(position){
    return function(mesh){
        return function(){
            mesh.position = position;
        }
    }
}

exports.setReceiveShadows = function(receiveShadows){
    return function(mesh){
        return function(){
            mesh.receiveShadows = receiveShadows;
        }
    }
}


exports.mergeMeshes = function(meshes){
    return function(disposeSource){
        return function(allow32BitsIndices){
            return function(){
                return BABYLON.Mesh.MergeMeshes(meshes, disposeSource, allow32BitsIndices)
            }
        }
    }
}


exports.setMaterial = function(mat){
    return function(mesh){
        return function(){
            mesh.material = mat;
        }
    }
}


exports.setInfiniteDistance = function(value){
    return function(mesh){
        return function(){
            mesh.infiniteDistance = value;
        }
    }
}


exports.setRenderingGroupId = function(value){
    return function(mesh){
        return function(){
            mesh.renderingGroupId = value;
        }
    }
}