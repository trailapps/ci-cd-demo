package com.trailapps.cicddemo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WelcomeController {

    @GetMapping
    public String hello() {
        return "<h1> CI CD demo</h1>";
    }
    
}
