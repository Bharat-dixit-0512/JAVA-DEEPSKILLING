package Week8_Microservices.account.src.main.java.com.cognizant.account.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AccountController {

    @GetMapping("/accounts/{number}")
    public Map<String, String> getAccountDetails(@PathVariable String number) {
        Map<String, String> accountDetails = new HashMap<>();
        accountDetails.put("number", number);
        accountDetails.put("type", "savings");
        accountDetails.put("balance", "234343");
        return accountDetails;
    }
}