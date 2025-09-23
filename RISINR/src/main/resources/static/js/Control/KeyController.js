/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */

async function init() {
  const keyManager = new KeyManager();
  await keyManager.generarLlaves(); // espera a que termine
  
}

init();
console.log("Terminó el init");


