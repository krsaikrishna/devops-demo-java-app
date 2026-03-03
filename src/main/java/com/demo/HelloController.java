package com.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {
    
    @GetMapping("/")
    public String hello() {
        return "Hello from DevOps Demo App! Version 1.0";
    }
    
    @GetMapping("/health")
    public String health() {
        return "App is running...";
    }
}
