package com.weshopify.platform;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.commons.util.InetUtils;
import org.springframework.cloud.netflix.eureka.EurekaInstanceConfigBean;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
@EnableEurekaServer
public class WeshopifyPlatformServicesRegistryApplication {

	public static void main(String[] args) {
		SpringApplication.run(WeshopifyPlatformServicesRegistryApplication.class, args);
	}

	@Bean
    public EurekaInstanceConfigBean eurekaInstanceConfig(InetUtils inetUtils){

        EurekaInstanceConfigBean config = new EurekaInstanceConfigBean(inetUtils);
        String ip = null;
        try {
        ip = InetAddress.getLocalHost().getHostAddress();
        
        } catch (UnknownHostException e) {
        e.printStackTrace();
        }
       
        config.setIpAddress(ip);
        config.setPreferIpAddress(true);
          

        return config;
       }
}
