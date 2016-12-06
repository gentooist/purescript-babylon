/* global BABYLON */

"use strict";

exports.createSound = function(name){
    return function(url){
        return function(scene){
            return function(onLoad){
                return function(options){
                    return function(){
                        return new BABYLON.Sound(name, url, scene, onLoad, options);
                    };
                };
            };
        };
    };
};

exports.play = function(sound){
    return function(){
        sound.play();
    };
};