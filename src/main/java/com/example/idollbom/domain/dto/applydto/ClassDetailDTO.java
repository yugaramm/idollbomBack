package com.example.idollbom.domain.dto.applydto;

import lombok.Data;

// 수업 상세보기 페이지에 뿌려줄 데이터 DTO
@Data
public class ClassDetailDTO {

    private Long classNumber;               // pk
    private String className;               // 수업 제목
    private String classCategoryBig;        // 수업 카테고리(대)
    private String classCategorySmall;      // 수업 카테고리(소)
    private String classContent;            // 수업 내용
    private String classPaymentAccount;     // 수업 결제금액
    private String classRegisterDate;       // 수업 등록일
    private Long proNumber;                 // fk ( 전문가 pk )
    private String proName;                 // 전문가 이름

}
