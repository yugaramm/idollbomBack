package com.example.idollbom.domain.vo;

import com.example.idollbom.domain.dto.prodto.ClassDTO;
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

    public static classVO toEntity(ClassDTO classDTO){


        return classVO.builder()
                .classNumber(classDTO.getClassNumber())
                .className(classDTO.getClassName())
                .classCategoryBig(classDTO.getClassCategoryBig())
                .classCategorySmall(classDTO.getClassCategorySmall())
                .classContent(classDTO.getClassContent())
                .classPaymentAccount(classDTO.getClassPaymentAccount())
                .proNumber(classDTO.getProNumber())
                .build();

    }
}
