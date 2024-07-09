package com.example.idollbom.controller.main;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/pro")
@RequiredArgsConstructor
@Slf4j
public class IndexProController {

    @GetMapping("/index")
    public String proindex() {
        return "html/main/index_pro";
    }

    @GetMapping("/childfind")
    public String childfind() {
        return "html/pro/childfind";

    }

    @GetMapping("/registerForm")
    public String registerForm() {
        return "html/pro/registerForm";

    }

}
