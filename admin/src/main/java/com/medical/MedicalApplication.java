package com.medical;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * 启动程序
 * 
 * @author medical
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class MedicalApplication
{
    public static void main(String[] args)
    {
        // System.setProperty("spring.devtools.restart.enabled", "false");
        SpringApplication.run(MedicalApplication.class, args);
        System.out.println("医疗平台启动成功");
    }
}
