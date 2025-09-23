/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */


console.log("Entró a la clase de KeyManager");



/*
 * Clase que define los métodos de creación y envío de las llaves 
 * 
 *
 */


class KeyManager{
    
    
    constructor(backendURL, privateKey, publicKey) {
    this.backendURL = null;
    this.privateKey = null;
    this.publicKey = null;
    }
    
    // Getters y setters 
    
    getPublicKey(){
        return this.publicKey;    
    }
    
    getPrivateKey(){
        return this.PrivateKey;  
    }
    
    async generarLlaves(){
    const keyPair = await window.crypto.subtle.generateKey(
      {
        name: "RSA-OAEP",
        modulusLength: 2048,
        publicExponent: new Uint8Array([1,0,1]),
        hash: "SHA-256"
      },
      true,
      ["encrypt","decrypt"]
    );
    
    this.publicKey = btoa(String.fromCharCode(...new Uint8Array(await window.crypto.subtle.exportKey("spki", keyPair.publicKey)))); 
    this.privateKey = btoa(String.fromCharCode(...new Uint8Array(await window.crypto.subtle.exportKey("pkcs8", keyPair.privateKey))));
    
    
    console.log("La llave pública: " + this.publicKey);
    console.log("La llave privada: " + this.privateKey);
    }
    
    sessionStorage.setItem("privateKey", this.privateKey);
    
}
 