package com.example.idollbom.service.proservice;

import com.example.idollbom.domain.dto.prodto.ClassDTO;
import com.example.idollbom.domain.vo.ProVO;
import com.example.idollbom.domain.vo.classVO;
import com.example.idollbom.mapper.pro.ProMapper;
import com.example.idollbom.mapper.pro.RegisterFormMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class RegisterFormServiceImpl implements RegisterFormService {

    private ProMapper proMapper;
    private RegisterFormMapper registerFormMapper;

    @Override
    public void saveClass(ClassDTO classDTO) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

//        유저id
        String username = ((UserDetails) principal).getUsername();

        ProVO userNumber = proMapper.selectOne(username);
        classDTO.setProNumber(userNumber.getProNumber());

        registerFormMapper.saveClass(classVO.toEntity(classDTO));

    }
}
