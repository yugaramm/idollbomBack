package com.example.idollbom.domain.vo;

import lombok.*;

@ToString
@NoArgsConstructor
@Builder
@AllArgsConstructor
@Getter
public class classVO {
    private Long classNumber;
    private String className;
    private String classCategoryBig;
    private String classCategorySmall;
    private String classContent;
    private Long classPaymentAccount;
    private Long proNumber;
}
