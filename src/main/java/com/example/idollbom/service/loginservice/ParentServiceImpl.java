package com.example.idollbom.service.loginservice;
import com.example.idollbom.domain.dto.logindto.ParentDTO;
import com.example.idollbom.domain.vo.ParentVO;
import com.example.idollbom.mapper.loginmapper.ParentMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ParentServiceImpl implements ParentService {

    private final ParentMapper parentMapper;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public void save(ParentDTO dto) {
        dto.setParentPassword(bCryptPasswordEncoder.encode(dto.getParentPassword()));
        ParentVO vo = ParentVO.toEntity(dto);

        parentMapper.insert(vo);
    }

    }





