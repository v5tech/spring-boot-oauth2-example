package com.example;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequestMapping("/users")
public class ResourceController {

    @RequestMapping(method = RequestMethod.GET)
    public String readUser() {
        return "read user " + UUID.randomUUID().toString();
    }

    @PreAuthorize("hasAuthority('WRITE')")
    @RequestMapping(method = RequestMethod.POST)
    public String writeUser() {
        return "write user " + UUID.randomUUID().toString();
    }
}
