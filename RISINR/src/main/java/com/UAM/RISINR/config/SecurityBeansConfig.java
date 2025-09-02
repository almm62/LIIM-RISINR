package com.UAM.RISINR.config;

import com.UAM.RISINR.security.Cybersecurity;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/*
 * Genera llaves al arrancar el proyecto, se quedan guardadas en ApplicationContext
 */

@Configuration
public class SecurityBeansConfig {

    @Bean
    public Cybersecurity cybersecurity() throws Exception {
        Cybersecurity c = new Cybersecurity();
        System.out.println("\n\n\n\nEjecutando Bean de Seguridad");
        c.generarLlaves(); 
        System.out.println("\n\n\n\nTermino de ejecucion de Bean de Seguridad\n\n\n\n");
        return c;
    }
}
