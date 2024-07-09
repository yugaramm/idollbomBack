package com.example.idollbom.service.proservice;

import com.example.idollbom.domain.dto.prodto.ClassDTO;
import org.springframework.stereotype.Service;

@Service
public interface RegisterFormService {

    public void saveClass(ClassDTO classDTO);

}
