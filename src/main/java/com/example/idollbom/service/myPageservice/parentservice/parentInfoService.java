package com.example.idollbom.service.myPageservice.parentservice;

import com.example.idollbom.domain.dto.logindto.ParentDTO;
import com.example.idollbom.domain.vo.ParentVO;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Service
public interface parentInfoService {
    ParentVO selectParentInfo();

    public void update(ParentDTO parentDTO, MultipartFile file) throws IOException;
}
