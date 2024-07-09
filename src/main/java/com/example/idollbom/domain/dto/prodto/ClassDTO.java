package com.example.idollbom.domain.dto.prodto;

import lombok.Data;

@Data
public class ClassDTO {
    private Long classNumber;
    private String className;
    private String classCategoryBig;
    private String classCategorySmall;
    private String classContent;
    private Long classPaymentAccount;
    private Long proNumber;
}
