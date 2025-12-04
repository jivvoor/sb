package kr.java.sb.controller;

import kr.java.sb.entity.Memo;
import kr.java.sb.props.AppProps;
import kr.java.sb.repository.MemoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller // ComponentScan + Web MVC
//@RequestMapping // DispatcherServlet -> '/'
@RequiredArgsConstructor
public class MemoController {
    private final MemoRepository memoRepository;
    // -> final을 포함한 생성자 -> @RequiredArgsConstructor

    //    private String msg = "나는 최고의 스프링 개발자!";
    @Value("${app.msg}")
    private String msg;
    @Value("${app.year}")
    private int year;
    @Value("${app.skill[0]}")
    private String skill;

    private final AppProps appProps;

    @GetMapping // GetMapping -> "/" -> fetch, form : GET. ㅂ라우저 : 접속.
    public String index(Model model) {
//        model.addAttribute("msg", msg);
//        model.addAttribute("msg", msg + " " + year + " " + skill);
        model.addAttribute("msg", appProps.getMsg() + " " + appProps.getYear() + " " + appProps.getSkill());

        model.addAttribute("memos", memoRepository.findAll());
        // Entity -> Data -> @ToString -> <%= memos %>
        // 뷰 경로
        return "index";
    }

    @PostMapping
    // @RequestParam("content")
    // -> configurations { compileOnly { extendsFrom annotationProcessor } }
    public String form(@RequestParam String content) {
        Memo memo = new Memo();
        memo.setContent(content);
        memoRepository.save(memo);
        return "redirect:/"; // PRG
    }
}