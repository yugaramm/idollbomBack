package com.example.idollbom.controller.pro;

import com.example.idollbom.domain.dto.prodto.ClassDTO;
import com.example.idollbom.service.proservice.RegisterFormService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/registerForm")
@RequiredArgsConstructor
@Slf4j
public class RegisterFormController {

    private final RegisterFormService registerFormService;

    @PostMapping("/insertClass")
    public String saveClass(@ModelAttribute ClassDTO classDTO){
        registerFormService.saveClass(classDTO);
        return "redirect:/registerForm";
    }


}
