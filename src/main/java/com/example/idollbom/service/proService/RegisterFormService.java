package com.example.idollbom.service.proService;

import com.example.idollbom.domain.dto.prodto.ClassDTO;
import com.example.idollbom.domain.dto.prodto.ReservationDateDTO;
import com.example.idollbom.domain.dto.prodto.ReservationTimeDTO;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public interface RegisterFormService {
    // 수업, 수업날짜, 수업시간, 이미지를 한방에 insert
    void registerClass(ClassDTO classDTO, ReservationDateDTO reservationDateDTO, ReservationTimeDTO reservationTimeDTO, MultipartFile imageFileUrl);
    
    // 수업에 대한 썸네일 이미지를 저장하는 서비스
    void saveFile(Long classNumber, MultipartFile file);
}
