/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.UAM.RISINR.exceptions;

/**
 *
 * @author vsfs2
 */
public class ResourceFoundException extends RuntimeException{
    
    private final Integer idEvento;

    public ResourceFoundException(Integer idEvento){
        super("Error con id: " + idEvento);
        this.idEvento = idEvento;
    }

    public Integer getidEvento() {
        return idEvento;
    }
    
    
}
