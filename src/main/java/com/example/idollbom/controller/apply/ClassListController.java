package com.example.idollbom.controller.apply;

import com.example.idollbom.domain.dto.applydto.ClassListDTO;
import com.example.idollbom.service.applyservice.ClassListService;
import jdk.jfr.Category;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/class")
@RequiredArgsConstructor
@Slf4j
public class ClassListController {

    private final ClassListService classListService;

    // 페이지 전부 페이징 처리 구현하기
    // 돌봄 페이지, default는 등하원으로
   @GetMapping("/classcare")
    public String classCare(@RequestParam(value = "category", defaultValue = "등/하원") String category, Model model) {
       List<ClassListDTO> classListDTO = classListService.findAllClass(category);
       int count = classListService.classCount(category);

        model.addAttribute("count", count);
        model.addAttribute("classLists", classListDTO);
        return "/html/apply/class_list_care";
    }

    // 운동 페이지 - default 축구
    @GetMapping("/classsport")
    public String classSport(@RequestParam(value = "category", defaultValue = "축구") String category, Model model) {
        List<ClassListDTO> classListDTO = classListService.findAllClass(category);
        int count = classListService.classCount(category);

        model.addAttribute("count", count);
        model.addAttribute("classLists", classListDTO);
        return "/html/apply/class_list_sport";
    }

    // 예능 페이지 - default 그리기
    @GetMapping("/classentertainment")
    public String classEntertainment(@RequestParam(value = "category", defaultValue = "그리기") String category, Model model) {
        List<ClassListDTO> classListDTO = classListService.findAllClass(category);
        int count = classListService.classCount(category);

        model.addAttribute("count", count);
        model.addAttribute("classLists", classListDTO);
        return "/html/apply/class_list_entertainment";
    }

    // 공부 페이지 - default 초등국어
    @GetMapping("/classstudy")
    public String classStudy(@RequestParam(value = "category", defaultValue = "초등국어") String category, Model model) {
        List<ClassListDTO> classListDTO = classListService.findAllClass(category);
        int count = classListService.classCount(category);

        model.addAttribute("count", count);
        model.addAttribute("classLists", classListDTO);
        return "/html/apply/class_list_study";
    }

    // 검색 기능 구현
    @GetMapping("/search")
    public String classSearch(@RequestParam(name = "searchWord") String searchWord,
                              @RequestParam(name = "searchType", defaultValue = "all") String searchType,
                              @RequestParam(value = "category", defaultValue = "등/하원") String category,
                              Model model) {
        List<ClassListDTO> classListDTO = classListService.searchClassList(searchWord, searchType, category);
        // 카운트도 다시!
        int count = classListService.classCount(category);

        model.addAttribute("count", count);
        model.addAttribute("classLists", classListDTO);
        return "/html/apply/class_list_care";
    }

    // 수업 상세보기 페이지
}
